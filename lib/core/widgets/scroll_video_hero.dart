import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';

/// Controller for observing and controlling [ScrollVideoHero].
class ScrollVideoHeroController extends ChangeNotifier {
  final ValueNotifier<bool> isAutoTourRunning = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isInitialized = ValueNotifier<bool>(false);

  final ValueNotifier<double> progressNotifier = ValueNotifier<double>(0.0);

  _ScrollVideoHeroState? _state;

  void _attach(_ScrollVideoHeroState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// Underlying video controller.
  VideoPlayerController? get videoPlayerController => _state?._videoController;

  /// Start automatic video playback.
  void startAutoTour({Duration? duration}) {
    _state?._startAutoTour(overrideDuration: duration);
  }

  /// Stop automatic video playback.
  void stopAutoTour() {
    _state?._stopAutoTour();
  }

  /// Toggle automatic playback.
  void toggleAutoTour() {
    if (isAutoTourRunning.value) {
      stopAutoTour();
    } else {
      startAutoTour();
    }
  }

  @override
  void dispose() {
    isAutoTourRunning.dispose();
    isInitialized.dispose();
    progressNotifier.dispose();
    super.dispose();
  }
}

/// High-performance scroll-driven video hero.
///
/// Architecture:
///
/// Scroll
///   ↓
/// Target progress
///   ↓
/// 60/120Hz interpolation
///   ↓
/// Latest target only
///   ↓
/// Throttled video seek
///   ↓
/// Scroll stops
///   ↓
/// One exact final seek
///
/// Important:
/// The visual scroll interpolation is completely independent from
/// the video decoder. The decoder is never allowed to build a backlog
/// of obsolete seek requests.
class ScrollVideoHero extends StatefulWidget {
  /// MP4 asset.
  final String videoAsset;

  /// Page ScrollController.
  final ScrollController scrollController;

  /// Scroll distance used to scrub the entire video.
  final double scrollDistance;

  /// Optional external controller.
  final ScrollVideoHeroController? controller;

  /// Progress-dependent overlay builder.
  final Widget Function(BuildContext context, double progress, bool isReady)?
  overlayBuilder;

  /// Progress-dependent underlay builder.
  final Widget Function(BuildContext context, double progress)? underlayBuilder;

  /// Widget displayed while video initializes.
  final Widget? placeholder;

  /// Background color.
  final Color backgroundColor;

  /// Legacy smoothing parameter.
  ///
  /// Kept for API compatibility.
  final double smoothingFactor;

  /// Minimum time difference between normal seeks.
  ///
  /// 33ms is approximately two frames at 60fps.
  final int toleranceMs;

  /// Large jumps immediately move the visual timeline.
  final int largeJumpThresholdMs;

  /// Optional progress callback.
  final ValueChanged<double>? onProgressChanged;

  /// Video BoxFit.
  final BoxFit fit;

  /// Optional mouse wheel smoothing.
  ///
  /// Disabled by default because page-level mouse wheel handling
  /// should not fight this widget.
  final bool enableSmoothWheel;

  const ScrollVideoHero({
    super.key,
    required this.videoAsset,
    required this.scrollController,
    this.scrollDistance = 2400.0,
    this.controller,
    this.overlayBuilder,
    this.underlayBuilder,
    this.placeholder,
    this.backgroundColor = const Color(0xFF08090D),

    // Kept for backwards compatibility.
    this.smoothingFactor = 0.22,

    // ~2 frames at 60fps.
    this.toleranceMs = 33,

    // Faster response to large navigation jumps.
    this.largeJumpThresholdMs = 1200,

    this.onProgressChanged,
    this.fit = BoxFit.cover,

    // Prefer handling wheel smoothing outside this widget.
    this.enableSmoothWheel = false,
  });

  @override
  State<ScrollVideoHero> createState() => _ScrollVideoHeroState();
}

class _ScrollVideoHeroState extends State<ScrollVideoHero>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late Ticker _ticker;

  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier<double>(
    0.0,
  );

  final ValueNotifier<double> _displayProgressNotifier = ValueNotifier<double>(
    0.0,
  );

  // ---------------------------------------------------------------------------
  // VIDEO STATE
  // ---------------------------------------------------------------------------

  bool _isInitialized = false;
  bool _hasError = false;
  bool _isDisposing = false;

  int _totalVideoMs = 10000;

  // ---------------------------------------------------------------------------
  // TIMELINE STATE
  // ---------------------------------------------------------------------------

  double _targetMs = 0.0;
  double _currentDisplayMs = 0.0;

  Duration? _lastTickDuration;

  // ---------------------------------------------------------------------------
  // SEEK PIPELINE
  // ---------------------------------------------------------------------------

  bool _isSeeking = false;

  /// The newest requested seek.
  ///
  /// Older requests are overwritten.
  int? _latestSeekMs;

  int _lastDispatchedMs = -1;
  int _lastRenderedMs = -1;

  DateTime? _lastSeekTime;

  /// Normal seek pacing.
  ///
  /// 33ms ≈ 30 seeks/sec maximum.
  static const int _minSeekIntervalMs = 33;

  // ---------------------------------------------------------------------------
  // SCROLL IDLE
  // ---------------------------------------------------------------------------

  Timer? _scrollIdleTimer;

  bool _isUserScrolling = false;

  /// Exact seek is performed this long after scrolling stops.
  static const Duration _scrollIdleDuration = Duration(milliseconds: 70);

  // ---------------------------------------------------------------------------
  // AUTO TOUR
  // ---------------------------------------------------------------------------

  bool _isAutoTouring = false;
  bool _isSyncingScroll = false;

  // ---------------------------------------------------------------------------
  // INIT
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    widget.controller?._attach(this);

    _ticker = createTicker(_onTick);

    widget.scrollController.addListener(_handleScroll);

    _initVideo();
  }

  // ---------------------------------------------------------------------------
  // WIDGET UPDATE
  // ---------------------------------------------------------------------------

  @override
  void didUpdateWidget(covariant ScrollVideoHero oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }

    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController.removeListener(_handleScroll);

      widget.scrollController.addListener(_handleScroll);
    }

    if (oldWidget.videoAsset != widget.videoAsset) {
      _reinitVideo();
    }
  }

  // ---------------------------------------------------------------------------
  // VIDEO INITIALIZATION
  // ---------------------------------------------------------------------------

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.asset(
        widget.videoAsset,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _videoController = controller;

      await controller.initialize();

      if (_isDisposing) return;

      await controller.setVolume(0.0);
      await controller.setLooping(false);
      await controller.pause();

      // Prime first frame.
      await controller.seekTo(Duration.zero);

      if (_isDisposing) return;

      final duration = controller.value.duration;

      if (duration > Duration.zero) {
        _totalVideoMs = duration.inMilliseconds;
      }

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
        _hasError = false;
      });

      widget.controller?.isInitialized.value = true;

      _lastTickDuration = null;

      _ticker.start();

      _handleScroll();
    } catch (e) {
      debugPrint('ScrollVideoHero initialization error: $e');

      if (!mounted) return;

      setState(() {
        _hasError = true;
      });
    }
  }

  Future<void> _reinitVideo() async {
    _ticker.stop();

    _scrollIdleTimer?.cancel();

    _isInitialized = false;
    _hasError = false;

    widget.controller?.isInitialized.value = false;

    try {
      await _videoController.dispose();
    } catch (_) {}

    if (!mounted) return;

    _lastTickDuration = null;
    _targetMs = 0.0;
    _currentDisplayMs = 0.0;

    _lastDispatchedMs = -1;
    _lastRenderedMs = -1;

    _isSeeking = false;
    _latestSeekMs = null;

    await _initVideo();
  }

  // ---------------------------------------------------------------------------
  // SCROLL HANDLING
  // ---------------------------------------------------------------------------

  void _handleScroll() {
    if (_isSyncingScroll) return;

    if (!widget.scrollController.hasClients) {
      return;
    }

    final double currentOffset = widget.scrollController.offset;

    // This drives the physical hero position.
    _scrollOffsetNotifier.value = currentOffset;

    // Manual scroll interrupts auto-tour.
    if (_isAutoTouring) {
      _stopAutoTour();
    }

    if (!_isInitialized || _hasError || _totalVideoMs <= 0) {
      return;
    }

    final double progress = (currentOffset / widget.scrollDistance).clamp(
      0.0,
      1.0,
    );

    // This is the ONLY target the video needs to know about.
    _targetMs = progress * _totalVideoMs;

    _isUserScrolling = true;

    // Restart idle timer.
    _scrollIdleTimer?.cancel();

    _scrollIdleTimer = Timer(_scrollIdleDuration, _finishScroll);
  }

  // ---------------------------------------------------------------------------
  // SCROLL FINISHED
  // ---------------------------------------------------------------------------

  void _finishScroll() {
    if (!mounted || !_isInitialized || _hasError) {
      return;
    }

    _isUserScrolling = false;

    final int finalTarget = _targetMs.round().clamp(0, _totalVideoMs);

    // Remove obsolete intermediate request.
    _latestSeekMs = null;

    // Exact final frame.
    _requestSeek(finalTarget, isResting: true);
  }

  // ---------------------------------------------------------------------------
  // MAIN 60/120HZ TICKER
  // ---------------------------------------------------------------------------

  void _onTick(Duration elapsed) {
    if (!_isInitialized || _hasError || _totalVideoMs <= 0) {
      return;
    }

    // -------------------------------------------------------------------------
    // AUTO TOUR
    // -------------------------------------------------------------------------

    if (_isAutoTouring) {
      if (!_videoController.value.isPlaying) {
        _stopAutoTour();
        return;
      }

      final double currentMs = _videoController.value.position.inMilliseconds
          .toDouble();

      _currentDisplayMs = currentMs;
      _targetMs = currentMs;

      final double progress = (currentMs / _totalVideoMs).clamp(0.0, 1.0);

      _updateProgress(progress);

      // Keep page scroll synchronized.
      if (widget.scrollController.hasClients) {
        final double desiredScroll = progress * widget.scrollDistance;

        _isSyncingScroll = true;

        widget.scrollController.jumpTo(desiredScroll);

        _scrollOffsetNotifier.value = desiredScroll;

        _isSyncingScroll = false;
      }

      if (currentMs >= _totalVideoMs - 35) {
        _stopAutoTour();
      }

      return;
    }

    // -------------------------------------------------------------------------
    // FRAME-RATE INDEPENDENT VISUAL INTERPOLATION
    // -------------------------------------------------------------------------

    final double dt = _lastTickDuration == null
        ? 1.0 / 60.0
        : ((elapsed - _lastTickDuration!).inMicroseconds / 1000000.0).clamp(
            0.001,
            0.05,
          );

    _lastTickDuration = elapsed;

    final double diff = _targetMs - _currentDisplayMs;

    final bool visuallySettled = diff.abs() < 0.5;

    if (visuallySettled) {
      _currentDisplayMs = _targetMs;
    } else if (diff.abs() > widget.largeJumpThresholdMs) {
      // Large navigation jumps should not spend
      // hundreds of frames catching up.
      _currentDisplayMs = _targetMs;
    } else {
      // -----------------------------------------------------------------------
      // HIGH-RESPONSE EXPONENTIAL SMOOTHING
      // -----------------------------------------------------------------------

      final double normalizedSpeed = (diff.abs() / _totalVideoMs).clamp(
        0.0,
        1.0,
      );

      final double lambda = 26.0 + normalizedSpeed * 30.0;

      final double factor = 1.0 - math.exp(-lambda * dt);

      _currentDisplayMs += diff * factor;
    }

    final double displayProgress = (_currentDisplayMs / _totalVideoMs).clamp(
      0.0,
      1.0,
    );

    // UI animation runs independently of decoder.
    _updateProgress(displayProgress);

    // -------------------------------------------------------------------------
    // VIDEO SEEK
    // -------------------------------------------------------------------------

    final int desiredSeekMs = _currentDisplayMs.round().clamp(0, _totalVideoMs);

    _requestSeek(desiredSeekMs, isResting: false);
  }

  // ---------------------------------------------------------------------------
  // PROGRESS
  // ---------------------------------------------------------------------------

  void _updateProgress(double displayProgress) {
    if ((_displayProgressNotifier.value - displayProgress).abs() > 0.0003) {
      _displayProgressNotifier.value = displayProgress;

      widget.controller?.progressNotifier.value = displayProgress;

      widget.onProgressChanged?.call(displayProgress);
    }
  }

  // ---------------------------------------------------------------------------
  // SEEK REQUEST
  // ---------------------------------------------------------------------------

  void _requestSeek(int targetMs, {required bool isResting}) {
    if (!_isInitialized || _hasError || _isDisposing) {
      return;
    }

    targetMs = targetMs.clamp(0, _totalVideoMs);

    // -------------------------------------------------------------------------
    // FINAL EXACT SEEK
    // -------------------------------------------------------------------------

    if (isResting) {
      // If a seek is already happening, replace its queued target.
      if (_isSeeking) {
        _latestSeekMs = targetMs;
        return;
      }

      if (_lastDispatchedMs == targetMs && _lastRenderedMs == targetMs) {
        return;
      }

      _dispatchSeek(targetMs, isResting: true);

      return;
    }

    // -------------------------------------------------------------------------
    // NORMAL SCROLL SEEK
    // -------------------------------------------------------------------------

    final DateTime now = DateTime.now();

    if (_lastSeekTime != null) {
      final int elapsed = now.difference(_lastSeekTime!).inMilliseconds;

      if (elapsed < _minSeekIntervalMs) {
        // Do NOT create a queue.
        //
        // Just remember the newest target.
        _latestSeekMs = targetMs;
        return;
      }
    }

    // If decoder is busy, replace old target.
    if (_isSeeking) {
      _latestSeekMs = targetMs;
      return;
    }

    final int delta = (targetMs - _lastDispatchedMs).abs();

    if (delta < widget.toleranceMs) {
      return;
    }

    _dispatchSeek(targetMs, isResting: false);
  }

  // ---------------------------------------------------------------------------
  // ACTUAL VIDEO SEEK
  // ---------------------------------------------------------------------------

  void _dispatchSeek(int targetMs, {required bool isResting}) {
    if (_isSeeking || !_isInitialized || _isDisposing) {
      _latestSeekMs = targetMs;
      return;
    }

    _isSeeking = true;

    _lastSeekTime = DateTime.now();

    _lastDispatchedMs = targetMs;

    _videoController
        .seekTo(Duration(milliseconds: targetMs))
        .then((_) {
          if (_isDisposing) {
            return;
          }

          _isSeeking = false;

          _lastRenderedMs = targetMs;

          if (!mounted) {
            return;
          }

          // -----------------------------------------------------------------------
          // IMPORTANT:
          //
          // Only process the newest target.
          //
          // All obsolete intermediate positions are discarded.
          // -----------------------------------------------------------------------

          final int? latest = _latestSeekMs;

          _latestSeekMs = null;

          if (latest == null) {
            return;
          }

          if (latest == _lastDispatchedMs) {
            return;
          }

          // If the user is still scrolling,
          // obey normal seek throttling.
          //
          // If scrolling has stopped, this becomes
          // the exact final seek.
          final bool shouldExactSeek = !_isUserScrolling;

          if (shouldExactSeek) {
            _requestSeek(latest, isResting: true);
          } else {
            _requestSeek(latest, isResting: false);
          }
        })
        .catchError((_) {
          _isSeeking = false;
        });
  }

  // ---------------------------------------------------------------------------
  // AUTO TOUR
  // ---------------------------------------------------------------------------

  void _startAutoTour({Duration? overrideDuration}) {
    if (!widget.scrollController.hasClients || !_isInitialized || _hasError) {
      return;
    }

    final double currentOffset = widget.scrollController.offset;

    if (currentOffset >= widget.scrollDistance) {
      widget.scrollController.jumpTo(0.0);

      _scrollOffsetNotifier.value = 0.0;

      _targetMs = 0.0;
      _currentDisplayMs = 0.0;

      _lastDispatchedMs = 0;
      _lastRenderedMs = 0;
    }

    _scrollIdleTimer?.cancel();

    _isAutoTouring = true;

    widget.controller?.isAutoTourRunning.value = true;

    // -------------------------------------------------------------------------
    // Native video playback.
    //
    // If an override duration is supplied, we intentionally don't manipulate
    // playback speed here because video_player's setPlaybackSpeed can produce
    // inconsistent results across platforms.
    // -------------------------------------------------------------------------

    _videoController.play();
  }

  void _stopAutoTour() {
    if (!_isAutoTouring) {
      return;
    }

    _isAutoTouring = false;

    widget.controller?.isAutoTourRunning.value = false;

    if (_isInitialized) {
      _videoController.pause();
    }
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return ValueListenableBuilder<double>(
      valueListenable: _scrollOffsetNotifier,
      builder: (context, scrollOffset, _) {
        double translateY = 0.0;

        if (scrollOffset > widget.scrollDistance) {
          translateY = -(scrollOffset - widget.scrollDistance);
        }

        // ---------------------------------------------------------------------
        // PERFORMANCE CULLING
        // ---------------------------------------------------------------------

        if (translateY <= -screenSize.height) {
          return const SizedBox.shrink();
        }

        return RepaintBoundary(
          child: Transform.translate(
            offset: Offset(0, translateY),
            child: SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // ===========================================================
                  // VIDEO
                  // ===========================================================
                  if (_isInitialized && !_hasError)
                    _buildVideo()
                  else
                    widget.placeholder ??
                        Container(
                          color: widget.backgroundColor,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFFE5A93B),
                            ),
                          ),
                        ),

                  // ===========================================================
                  // PROGRESS-DRIVEN OVERLAYS
                  // ===========================================================
                  ValueListenableBuilder<double>(
                    valueListenable: _displayProgressNotifier,
                    builder: (context, displayProgress, _) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          if (widget.underlayBuilder != null)
                            widget.underlayBuilder!(context, displayProgress),

                          if (widget.overlayBuilder != null)
                            widget.overlayBuilder!(
                              context,
                              displayProgress,
                              _isInitialized,
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // VIDEO WIDGET
  // ---------------------------------------------------------------------------

  Widget _buildVideo() {
    final double aspectRatio = _videoController.value.aspectRatio;

    if (aspectRatio <= 0) {
      return VideoPlayer(_videoController);
    }

    return ClipRect(
      child: SizedBox.expand(
        child: FittedBox(
          fit: widget.fit,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: _videoController.value.size.width,
            height: _videoController.value.size.height,
            child: VideoPlayer(_videoController),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // DISPOSE
  // ---------------------------------------------------------------------------

  @override
  void dispose() {
    _isDisposing = true;

    _scrollIdleTimer?.cancel();

    widget.controller?._detach();

    widget.scrollController.removeListener(_handleScroll);

    _ticker.stop();
    _ticker.dispose();

    _scrollOffsetNotifier.dispose();
    _displayProgressNotifier.dispose();

    if (_isInitialized) {
      _videoController.dispose();
    }

    super.dispose();
  }
}
