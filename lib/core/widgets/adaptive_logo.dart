import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Theme-aware logo with optional realistic shallow water wave simulation inside the logo on hover in dark mode.
class AdaptiveLogo extends StatefulWidget {
  final double height;
  final double? width;
  final bool floatingInDarkMode;
  final BoxFit fit;
  final Color waterColor;

  const AdaptiveLogo({
    super.key,
    this.height = 36,
    this.width,
    this.floatingInDarkMode = false,
    this.fit = BoxFit.contain,
    this.waterColor = const Color(0xFF00E5FF), // Electric Cyan
  });

  @override
  State<AdaptiveLogo> createState() => _AdaptiveLogoState();
}

class _AdaptiveLogoState extends State<AdaptiveLogo> with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Ticker _ticker;

  ui.Image? _logoImage;
  bool _isLoading = true;

  // Physics arrays for 30 columns
  final List<double> _heights = List.filled(30, 0.0);
  final List<double> _velocities = List.filled(30, 0.0);
  final List<_LogoBubble> _bubbles = [];

  Offset _mousePos = Offset.zero;
  Offset _prevMousePos = Offset.zero;
  bool _isHovered = false;
  bool _justEntered = false;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    // Hover controller animates water level rising (from 0.0 to 1.0)
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Vsync ticker runs physics and redraws at 60fps/120fps dynamically
    _ticker = createTicker(_onTick);

    _loadLogoImage();
  }

  Future<void> _loadLogoImage() async {
    try {
      final ImageProvider provider = const AssetImage('assets/new_logo.png');
      final ImageStream stream = provider.resolve(ImageConfiguration.empty);
      final Completer<ui.Image> completer = Completer<ui.Image>();
      ImageStreamListener? listener;
      listener = ImageStreamListener((ImageInfo frame, bool _) {
        completer.complete(frame.image);
        stream.removeListener(listener!);
      }, onError: (dynamic exception, StackTrace? stackTrace) {
        completer.completeError(exception, stackTrace);
        stream.removeListener(listener!);
      });
      stream.addListener(listener);

      final image = await completer.future;
      if (mounted) {
        setState(() {
          _logoImage = image;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Failed to load logo image: $e");
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (!mounted) return;

    _time = elapsed.inMilliseconds / 1000.0;

    if (!_isHovered) {
      // Performance optimization: Stop Vsync ticker when water drains completely
      if (_hoverController.value == 0.0) {
        _ticker.stop();
        _heights.fillRange(0, _heights.length, 0.0);
        _velocities.fillRange(0, _velocities.length, 0.0);
        _bubbles.clear();
        return;
      }
    }

    setState(() {});
  }

  void _onEnter(PointerEvent event) {
    setState(() {
      _isHovered = true;
      _justEntered = true;
      _mousePos = event.localPosition;
      _prevMousePos = event.localPosition;
    });
    _hoverController.forward();
    if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  void _onHover(PointerEvent event) {
    setState(() {
      _prevMousePos = _mousePos;
      _mousePos = event.localPosition;
    });
  }

  void _onExit() {
    setState(() {
      _isHovered = false;
    });
    _hoverController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // In light mode, or if loading, return the static logo directly
    if (!isDark || _isLoading || _logoImage == null) {
      final tint = isDark ? Colors.white : Colors.black;
      return ColorFiltered(
        colorFilter: ColorFilter.mode(tint, BlendMode.srcIn),
        child: Image.asset(
          'assets/new_logo.png',
          height: widget.height,
          width: widget.width,
          fit: widget.fit,
          filterQuality: FilterQuality.high,
        ),
      );
    }

    // Dynamic sizing based on the loaded image aspect ratio
    final double aspect = _logoImage!.width / _logoImage!.height;
    final double calculatedWidth = widget.width ?? (widget.height * aspect);
    final double calculatedHeight = widget.height;

    return MouseRegion(
      onEnter: _onEnter,
      onHover: _onHover,
      onExit: (_) => _onExit(),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          final double hoverVal = _hoverController.value;

          return Stack(
            children: [
              // Base static white logo (fades out as water level rises)
              Opacity(
                opacity: (1.0 - hoverVal).clamp(0.0, 1.0),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: Image.asset(
                    'assets/new_logo.png',
                    height: calculatedHeight,
                    width: calculatedWidth,
                    fit: widget.fit,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              // Interactive water logo layer (fades in on hover)
              if (hoverVal > 0.0)
                Opacity(
                  opacity: hoverVal,
                  child: CustomPaint(
                    painter: _WaterLogoPainter(
                      image: _logoImage!,
                      heights: _heights,
                      velocities: _velocities,
                      bubbles: _bubbles,
                      hoverProgress: hoverVal,
                      mousePos: _mousePos,
                      prevMousePos: _prevMousePos,
                      isHovered: _isHovered,
                      justEntered: _justEntered,
                      time: _time,
                      waterColor: widget.waterColor,
                      onHandledEntry: () {
                        _justEntered = false;
                      },
                    ),
                    child: SizedBox(
                      width: calculatedWidth,
                      height: calculatedHeight,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _LogoBubble {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;

  _LogoBubble({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });
}

class _WaterLogoPainter extends CustomPainter {
  final ui.Image image;
  final List<double> heights;
  final List<double> velocities;
  final List<_LogoBubble> bubbles;
  final double hoverProgress;
  final Offset mousePos;
  final Offset prevMousePos;
  final bool isHovered;
  final bool justEntered;
  final double time;
  final Color waterColor;
  final VoidCallback onHandledEntry;

  const _WaterLogoPainter({
    required this.image,
    required this.heights,
    required this.velocities,
    required this.bubbles,
    required this.hoverProgress,
    required this.mousePos,
    required this.prevMousePos,
    required this.isHovered,
    required this.justEntered,
    required this.time,
    required this.waterColor,
    required this.onHandledEntry,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);

    // 1. Draw empty silhouette background
    final bgPaint = Paint()
      ..colorFilter = ColorFilter.mode(
        Colors.white.withOpacity(0.08),
        BlendMode.srcIn,
      );
    canvas.drawImageRect(image, src, dst, bgPaint);

    // 2. Setup spring wave baseline
    final double restHeight = size.height * (1.0 - hoverProgress * 0.65);

    // If arrays are uninitialized, populate with baseline height
    if (heights.every((h) => h == 0.0)) {
      for (int i = 0; i < heights.length; i++) {
        heights[i] = size.height;
      }
    }

    // 3. Run Shallow Water Column Physics
    final double k = 0.025; // Spring constant
    final double spread = 0.09; // Wave propagation speed
    final double dampening = 0.96; // Viscous friction

    // Spring force to baseline
    for (int i = 0; i < heights.length; i++) {
      final double diff = heights[i] - restHeight;
      final double force = -k * diff;
      velocities[i] += force;
    }

    // Horizontal neighborhood wave propagation
    final List<double> leftDeltas = List.filled(heights.length, 0.0);
    final List<double> rightDeltas = List.filled(heights.length, 0.0);

    for (int i = 0; i < heights.length; i++) {
      if (i > 0) {
        leftDeltas[i] = spread * (heights[i] - heights[i - 1]);
        velocities[i - 1] += leftDeltas[i];
      }
      if (i < heights.length - 1) {
        rightDeltas[i] = spread * (heights[i] - heights[i + 1]);
        velocities[i + 1] += rightDeltas[i];
      }
    }

    // Apply velocities
    for (int i = 0; i < heights.length; i++) {
      if (i > 0) heights[i - 1] += leftDeltas[i];
      if (i < heights.length - 1) heights[i + 1] += rightDeltas[i];

      velocities[i] *= dampening;
      heights[i] += velocities[i];
      heights[i] = heights[i].clamp(0.0, size.height);
    }

    // 4. Handle Interactive Mouse Splash
    final double colWidth = size.width / (heights.length - 1);
    final int colIdx = (mousePos.dx / colWidth).floor().clamp(0, heights.length - 1);

    if (isHovered) {
      if (justEntered) {
        // Trigger initial entry splash
        velocities[colIdx] -= size.height * 0.2;
        if (colIdx > 0) velocities[colIdx - 1] -= size.height * 0.1;
        if (colIdx < heights.length - 1) velocities[colIdx + 1] -= size.height * 0.1;
        onHandledEntry();
      } else {
        // Calculate mouse drag velocity
        final double dist = (mousePos - prevMousePos).distance;
        if (dist > 0.4) {
          final double push = (mousePos.dy > heights[colIdx] ? 1.0 : -1.0) * dist * 0.3;
          velocities[colIdx] += push;
          if (colIdx > 0) velocities[colIdx - 1] += push * 0.5;
          if (colIdx < heights.length - 1) velocities[colIdx + 1] += push * 0.5;
        }
      }
    }

    // 5. Handle floating bubbles update
    final random = math.Random();
    // Spawn bubbles near bottom
    if (isHovered && random.nextDouble() < 0.15) {
      final double bx = random.nextDouble() * size.width;
      bubbles.add(_LogoBubble(
        x: bx,
        y: size.height,
        vx: (random.nextDouble() - 0.5) * 0.4,
        vy: -0.6 - random.nextDouble() * 1.2,
        radius: 0.8 + random.nextDouble() * 1.5,
        opacity: 0.2 + random.nextDouble() * 0.5,
      ));
    }

    // Update positions and pop on surface
    for (int i = bubbles.length - 1; i >= 0; i--) {
      final b = bubbles[i];
      b.y += b.vy;
      b.x += b.vx + math.sin(time * 6.0 + b.y) * 0.3;

      final int col = (b.x / colWidth).floor().clamp(0, heights.length - 1);
      final double waterSurfaceY = heights[col];

      if (b.y <= waterSurfaceY || b.x < 0 || b.x > size.width) {
        bubbles.removeAt(i);
      }
    }

    // 6. Draw masked water inside the logo shape
    canvas.saveLayer(dst, Paint());

    // Draw solid white mask
    final maskPaint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.white, BlendMode.srcIn);
    canvas.drawImageRect(image, src, dst, maskPaint);

    // Build water body path
    final waterPath = Path();
    waterPath.moveTo(0, size.height);
    waterPath.lineTo(0, heights[0]);
    for (int i = 0; i < heights.length; i++) {
      waterPath.lineTo(i * colWidth, heights[i]);
    }
    waterPath.lineTo(size.width, size.height);
    waterPath.close();

    // Paint water gradient
    final waterPaint = Paint()
      ..blendMode = BlendMode.srcIn
      ..shader = ui.Gradient.linear(
        Offset(0, restHeight - size.height * 0.1),
        Offset(0, size.height),
        [
          waterColor.withOpacity(0.85),
          Color.alphaBlend(Colors.black.withOpacity(0.85), waterColor).withOpacity(0.92),
        ],
      );
    canvas.drawPath(waterPath, waterPaint);

    // Build water surface crest line
    final crestPath = Path();
    crestPath.moveTo(0, heights[0]);
    for (int i = 1; i < heights.length; i++) {
      crestPath.lineTo(i * colWidth, heights[i]);
    }

    // Draw glowing surface reflection line
    final crestPaint = Paint()
      ..blendMode = BlendMode.srcIn
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = const Color(0xFFE0F7FA);
    canvas.drawPath(crestPath, crestPaint);

    // Draw floating bubbles
    for (final b in bubbles) {
      final bubblePaint = Paint()
        ..blendMode = BlendMode.srcIn
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.6
        ..color = Colors.white.withOpacity(b.opacity);
      canvas.drawCircle(Offset(b.x, b.y), b.radius, bubblePaint);

      final specPaint = Paint()
        ..blendMode = BlendMode.srcIn
        ..color = Colors.white.withOpacity(b.opacity * 0.8);
      canvas.drawCircle(Offset(b.x - b.radius * 0.3, b.y - b.radius * 0.3), b.radius * 0.22, specPaint);
    }

    canvas.restore();

    // 7. Overlay semi-transparent logo details on top
    final overlayPaint = Paint()
      ..colorFilter = ColorFilter.mode(
        Colors.white.withOpacity(0.18 * hoverProgress),
        BlendMode.srcIn,
      );
    canvas.drawImageRect(image, src, dst, overlayPaint);
  }

  @override
  bool shouldRepaint(covariant _WaterLogoPainter oldDelegate) {
    return oldDelegate.image != image ||
        oldDelegate.hoverProgress != hoverProgress ||
        oldDelegate.mousePos != mousePos ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.time != time ||
        oldDelegate.waterColor != waterColor;
  }
}
