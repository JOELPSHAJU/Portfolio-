import 'dart:async';
import 'package:flutter/material.dart';
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

  /// Underlying video controller (currently active forward or reverse).
  VideoPlayerController? get videoPlayerController =>
      _state?._isReversingNotifier.value == true
          ? (_state?._reverseController ?? _state?._forwardController)
          : _state?._forwardController;

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

/// Ultra-smooth 60 FPS hardware scroll-driven video hero.
///
/// Features:
/// - Exact bi-directional continuity: when scrolling up after scrolling down,
///   playback begins immediately from the current shot where the user stopped,
///   never jumping to the end.
/// - Dual-video native hardware playback engine with background standby pre-seeking.
/// - Speed-proportional playback: speeds up with faster scrolls, glides smoothly.
/// - Pinned viewport during video progression; seamlessly scrolls page content
///   once the video reaches the end.
class ScrollVideoHero extends StatefulWidget {
  /// Forward MP4 video asset.
  final String videoAsset;

  /// Optional reversed MP4 video asset for seamless 60fps reverse scrubbing.
  final String? reversedVideoAsset;

  /// Page ScrollController.
  final ScrollController scrollController;

  /// Scroll distance dedicated to scrubbing the video from 0:00 to end.
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

  /// Legacy smoothing parameter (kept for API compatibility).
  final double smoothingFactor;

  /// Tolerance in milliseconds (kept for API compatibility).
  final int toleranceMs;

  /// Large jumps immediately seek to target.
  final int largeJumpThresholdMs;

  /// Optional progress callback.
  final ValueChanged<double>? onProgressChanged;

  /// Video BoxFit.
  final BoxFit fit;

  /// Optional mouse wheel smoothing.
  final bool enableSmoothWheel;

  const ScrollVideoHero({
    super.key,
    required this.videoAsset,
    this.reversedVideoAsset,
    required this.scrollController,
    this.scrollDistance = 2400.0,
    this.controller,
    this.overlayBuilder,
    this.underlayBuilder,
    this.placeholder,
    this.backgroundColor = const Color(0xFF08090D),
    this.smoothingFactor = 0.22,
    this.toleranceMs = 33,
    this.largeJumpThresholdMs = 2500,
    this.onProgressChanged,
    this.fit = BoxFit.cover,
    this.enableSmoothWheel = false,
  });

  @override
  State<ScrollVideoHero> createState() => _ScrollVideoHeroState();
}

class _ScrollVideoHeroState extends State<ScrollVideoHero> {
  late VideoPlayerController _forwardController;
  VideoPlayerController? _reverseController;

  final ValueNotifier<bool> _isReversingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<double> _displayProgressNotifier = ValueNotifier<double>(0.0);

  bool _isInitialized = false;
  bool _hasError = false;
  bool _isDisposing = false;

  bool _isReversing = false;
  bool _isSeekingRev = false;
  bool _isSeekingFwd = false;

  int _targetMs = 0;
  int _lastKnownFwdMs = 0;
  int _lastKnownRevMs = 0;
  double _lastScrollOffset = 0.0;
  Timer? _scrollDebounceTimer;

  bool _isAutoTouring = false;
  bool _isSyncingScroll = false;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    widget.scrollController.addListener(_handleScroll);
    _initVideo();
  }

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

    if (oldWidget.videoAsset != widget.videoAsset ||
        oldWidget.reversedVideoAsset != widget.reversedVideoAsset) {
      _reinitVideo();
    }
  }

  String? _resolveReversedAsset() {
    if (widget.reversedVideoAsset != null) {
      return widget.reversedVideoAsset;
    }
    // Auto-detect common reversed companion assets
    if (widget.videoAsset.contains('hotel_intro.mp4')) {
      return 'assets/hotel_intro_reversed.mp4';
    }
    if (widget.videoAsset.contains('construction_introd.mp4')) {
      return 'assets/construction_introd_reversed.mp4';
    }
    return null;
  }

  Future<void> _initVideo() async {
    try {
      _forwardController = VideoPlayerController.asset(
        widget.videoAsset,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      final reversedPath = _resolveReversedAsset();
      if (reversedPath != null) {
        _reverseController = VideoPlayerController.asset(
          reversedPath,
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
      }

      await Future.wait([
        _forwardController.initialize(),
        if (_reverseController != null) _reverseController!.initialize(),
      ]);

      if (_isDisposing) return;

      await Future.wait([
        _forwardController.setVolume(0.0),
        _forwardController.setLooping(false),
        _forwardController.pause(),
        if (_reverseController != null) ...[
          _reverseController!.setVolume(0.0),
          _reverseController!.setLooping(false),
          _reverseController!.pause(),
        ],
      ]);

      // Prime opening frames safely
      await _forwardController.seekTo(Duration.zero);
      _lastKnownFwdMs = 0;

      if (_reverseController != null) {
        final totalRev = _reverseController!.value.duration.inMilliseconds;
        // Prime safely away from EOF so it never resets to 0:00
        final primeRev = (totalRev - 120).clamp(50, totalRev);
        await _reverseController!.seekTo(Duration(milliseconds: primeRev));
        _lastKnownRevMs = primeRev;
      }

      if (_isDisposing) return;

      _forwardController.addListener(_onForwardTick);
      _reverseController?.addListener(_onReverseTick);

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
        _hasError = false;
      });

      widget.controller?.isInitialized.value = true;
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
    _scrollDebounceTimer?.cancel();
    _isInitialized = false;
    _hasError = false;
    widget.controller?.isInitialized.value = false;

    _forwardController.removeListener(_onForwardTick);
    _reverseController?.removeListener(_onReverseTick);

    try {
      await _forwardController.dispose();
      await _reverseController?.dispose();
    } catch (_) {}

    _reverseController = null;
    _targetMs = 0;
    _lastKnownFwdMs = 0;
    _lastKnownRevMs = 0;
    _lastScrollOffset = 0.0;
    _isReversing = false;
    _isSeekingRev = false;
    _isSeekingFwd = false;
    _isReversingNotifier.value = false;

    if (!mounted) return;
    await _initVideo();
  }

  void _onForwardTick() {
    if (!_forwardController.value.isInitialized) return;
    if (_isSeekingFwd) return;

    final current = _forwardController.value.position.inMilliseconds;
    _lastKnownFwdMs = current;

    if (_isAutoTouring) {
      final totalMs = _forwardController.value.duration.inMilliseconds > 0
          ? _forwardController.value.duration.inMilliseconds
          : 10000;
      final double progress = (current / totalMs).clamp(0.0, 1.0);
      _updateProgress(progress);

      if (widget.scrollController.hasClients) {
        final double desiredScroll = progress * widget.scrollDistance;
        _isSyncingScroll = true;
        widget.scrollController.jumpTo(desiredScroll);
        _scrollOffsetNotifier.value = desiredScroll;
        _isSyncingScroll = false;
      }

      if (current >= totalMs - 35) {
        _stopAutoTour();
      }
      return;
    }

    if (_isReversingNotifier.value) return;
    if (!_forwardController.value.isPlaying) return;

    if (current >= _targetMs - 15) {
      _forwardController.pause();
    }
  }

  void _onReverseTick() {
    if (_reverseController == null || !_reverseController!.value.isInitialized) {
      return;
    }
    if (_isSeekingRev) return;

    final current = _reverseController!.value.position.inMilliseconds;
    _lastKnownRevMs = current;

    if (!_isReversingNotifier.value) return;
    if (!_reverseController!.value.isPlaying) return;

    final totalMs = _forwardController.value.duration.inMilliseconds > 0
        ? _forwardController.value.duration.inMilliseconds
        : 10000;
    final revTargetMs = (totalMs - _targetMs).clamp(50, totalMs - 50);

    if (current >= revTargetMs - 15) {
      _reverseController!.pause();
    }
  }

  void _handleScroll() {
    if (_isSyncingScroll) return;
    if (!widget.scrollController.hasClients) return;

    final double currentOffset = widget.scrollController.offset;
    _scrollOffsetNotifier.value = currentOffset;

    if (_isAutoTouring) {
      _stopAutoTour();
    }

    if (!_isInitialized || _hasError) return;

    final totalDuration = _forwardController.value.duration;
    if (totalDuration == Duration.zero) return;
    final int totalMs = totalDuration.inMilliseconds > 0
        ? totalDuration.inMilliseconds
        : 10000;

    final double progress = (currentOffset / widget.scrollDistance).clamp(
      0.0,
      1.0,
    );
    final int newTargetMs = (totalMs * progress).round().clamp(0, totalMs);
    final bool isScrollingDown = currentOffset >= _lastScrollOffset;
    _lastScrollOffset = currentOffset;
    _targetMs = newTargetMs;

    _updateProgress(progress);

    if (isScrollingDown) {
      // ── Scrolling Forward (Down) ──────────────────────────────────────────
      _isReversing = false;

      if (_reverseController != null && _isReversingNotifier.value) {
        // Was reversing -> switch seamlessly to forward from the EXACT current shot
        _reverseController!.pause();
        final revPos = _reverseController!.value.position.inMilliseconds;
        final currentRev = revPos > 0 ? revPos : _lastKnownRevMs;
        final startFwd = (totalMs - currentRev).clamp(0, totalMs - 50);

        final fwdCurrent = _forwardController.value.position.inMilliseconds;
        if ((fwdCurrent - startFwd).abs() < 120) {
          _isReversingNotifier.value = false;
          _lastKnownFwdMs = startFwd;
          _applyForwardPlayback(newTargetMs);
        } else {
          // Keep reverse video visible on screen until forward seek completes
          _isSeekingFwd = true;
          _lastKnownFwdMs = startFwd;
          _forwardController.seekTo(Duration(milliseconds: startFwd)).then((_) {
            if (!mounted || _isReversing) return;
            _isSeekingFwd = false;
            _lastKnownFwdMs = startFwd;
            _isReversingNotifier.value = false;
            _applyForwardPlayback(_targetMs);
          });
        }
      } else {
        if (!_isSeekingFwd) {
          _applyForwardPlayback(newTargetMs);
        }
      }
    } else {
      // ── Scrolling Backward (Up) ───────────────────────────────────────────
      _isReversing = true;

      if (_reverseController != null) {
        final revTargetMs = (totalMs - _targetMs).clamp(50, totalMs - 50);

        if (!_isReversingNotifier.value) {
          // Was forwarding -> switch seamlessly to reverse from the EXACT current shot
          _forwardController.pause();
          final fwdPos = _forwardController.value.position.inMilliseconds;
          final currentFwd = fwdPos > 0 ? fwdPos : _lastKnownFwdMs;
          final startRev = (totalMs - currentFwd).clamp(50, totalMs - 50);

          final revCurrent = _reverseController!.value.position.inMilliseconds;
          if ((revCurrent - startRev).abs() < 120) {
            _isReversingNotifier.value = true;
            _lastKnownRevMs = startRev;
            _applyReversePlayback(revTargetMs);
          } else {
            // Keep forward video visibly paused on current shot until reverse seek finishes
            _isSeekingRev = true;
            _lastKnownRevMs = startRev;
            _reverseController!.seekTo(Duration(milliseconds: startRev)).then((_) {
              if (!mounted || !_isReversing) return;
              _isSeekingRev = false;
              _lastKnownRevMs = startRev;
              _isReversingNotifier.value = true;
              final currentRevTarget = (totalMs - _targetMs).clamp(50, totalMs - 50);
              _applyReversePlayback(currentRevTarget);
            });
          }
        } else {
          if (!_isSeekingRev) {
            _applyReversePlayback(revTargetMs);
          }
        }
      } else {
        // Fallback without companion reverse video
        _forwardController.seekTo(Duration(milliseconds: _targetMs));
        _lastKnownFwdMs = _targetMs;
      }
    }

    _scheduleDebounceCheck(totalMs);
  }

  void _applyForwardPlayback(int targetMs) {
    if (_isDisposing || !_isInitialized) return;
    final diff = targetMs - _lastKnownFwdMs;

    if (diff > widget.largeJumpThresholdMs) {
      _forwardController.seekTo(Duration(milliseconds: targetMs));
      _forwardController.pause();
      _lastKnownFwdMs = targetMs;
    } else if (diff > 15) {
      final double speed = (diff / 150.0).clamp(0.75, 3.5);
      _forwardController.setPlaybackSpeed(speed);
      if (!_forwardController.value.isPlaying) {
        _forwardController.play();
      }
    } else if (diff <= 0) {
      _forwardController.pause();
    }
  }

  void _applyReversePlayback(int revTargetMs) {
    if (_isDisposing || !_isInitialized || _reverseController == null) return;
    final diff = revTargetMs - _lastKnownRevMs;

    if (diff > widget.largeJumpThresholdMs) {
      _reverseController!.seekTo(Duration(milliseconds: revTargetMs));
      _reverseController!.pause();
      _lastKnownRevMs = revTargetMs;
    } else if (diff > 15) {
      final double speed = (diff / 150.0).clamp(0.75, 3.5);
      _reverseController!.setPlaybackSpeed(speed);
      if (!_reverseController!.value.isPlaying) {
        _reverseController!.play();
      }
    } else if (diff <= 0) {
      _reverseController!.pause();
    }
  }

  void _scheduleDebounceCheck(int totalMs) {
    _scrollDebounceTimer?.cancel();
    _scrollDebounceTimer = Timer(const Duration(milliseconds: 50), () {
      if (!mounted || !_isInitialized) return;

      if (!_isReversing) {
        _forwardController.pause();
        // Background pre-seek standby reverse controller to exact current frame
        if (_reverseController != null && !_isSeekingRev) {
          final fwdPos = _forwardController.value.position.inMilliseconds;
          final exactFwd = fwdPos > 0 ? fwdPos : _lastKnownFwdMs;
          final prepRev = (totalMs - exactFwd).clamp(50, totalMs - 50);
          _reverseController!.seekTo(Duration(milliseconds: prepRev));
          _lastKnownRevMs = prepRev;
        }
      } else if (_reverseController != null) {
        _reverseController!.pause();
        // Background pre-seek standby forward controller to exact current frame
        if (!_isSeekingFwd) {
          final revPos = _reverseController!.value.position.inMilliseconds;
          final exactRev = revPos > 0 ? revPos : _lastKnownRevMs;
          final prepFwd = (totalMs - exactRev).clamp(0, totalMs - 50);
          _forwardController.seekTo(Duration(milliseconds: prepFwd));
          _lastKnownFwdMs = prepFwd;
        }
      }
    });
  }

  void _updateProgress(double progress) {
    if ((_displayProgressNotifier.value - progress).abs() > 0.0005) {
      _displayProgressNotifier.value = progress;
      widget.controller?.progressNotifier.value = progress;
      widget.onProgressChanged?.call(progress);
    }
  }

  void _startAutoTour({Duration? overrideDuration}) {
    if (!widget.scrollController.hasClients || !_isInitialized || _hasError) {
      return;
    }

    final double currentOffset = widget.scrollController.offset;
    if (currentOffset >= widget.scrollDistance) {
      widget.scrollController.jumpTo(0.0);
      _scrollOffsetNotifier.value = 0.0;
      _targetMs = 0;
      _lastKnownFwdMs = 0;
      _forwardController.seekTo(Duration.zero);
    }

    _scrollDebounceTimer?.cancel();
    _isAutoTouring = true;
    _isReversing = false;
    _isReversingNotifier.value = false;
    _reverseController?.pause();
    widget.controller?.isAutoTourRunning.value = true;

    _forwardController.setPlaybackSpeed(1.0);
    _forwardController.play();
  }

  void _stopAutoTour() {
    if (!_isAutoTouring) return;
    _isAutoTouring = false;
    widget.controller?.isAutoTourRunning.value = false;
    if (_isInitialized) {
      _forwardController.pause();
    }
  }

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

        // Performance culling when video has fully scrolled off top
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
                  // 1. Dual-Video Native 60 FPS Hardware Playback Engine
                  if (_isInitialized && !_hasError)
                    _buildVideoDisplay()
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

                  // 2. Progress-Driven Dynamic Overlays and Underlays
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

  Widget _buildVideoDisplay() {
    final double width = _forwardController.value.size.width > 0
        ? _forwardController.value.size.width
        : 1920;
    final double height = _forwardController.value.size.height > 0
        ? _forwardController.value.size.height
        : 1080;

    return ClipRect(
      child: SizedBox.expand(
        child: FittedBox(
          fit: widget.fit,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: width,
            height: height,
            child: ValueListenableBuilder<bool>(
              valueListenable: _isReversingNotifier,
              builder: (context, isReversing, _) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: isReversing ? 0.0 : 1.0,
                      child: VideoPlayer(_forwardController),
                    ),
                    if (_reverseController != null)
                      Opacity(
                        opacity: isReversing ? 1.0 : 0.0,
                        child: VideoPlayer(_reverseController!),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isDisposing = true;
    _scrollDebounceTimer?.cancel();
    widget.controller?._detach();
    widget.scrollController.removeListener(_handleScroll);

    _scrollOffsetNotifier.dispose();
    _displayProgressNotifier.dispose();
    _isReversingNotifier.dispose();

    if (_isInitialized) {
      _forwardController.removeListener(_onForwardTick);
      _reverseController?.removeListener(_onReverseTick);
      _forwardController.dispose();
      _reverseController?.dispose();
    }

    super.dispose();
  }
}
