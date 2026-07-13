import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A widget that displays a highly realistic, interactive shallow water physics simulation inside the text on hover.
class HoverAnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color liquidColor;

  const HoverAnimatedText({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.liquidColor = const Color(0xFF00E5FF), // Electric Cyan Water
  });

  @override
  State<HoverAnimatedText> createState() => _HoverAnimatedTextState();
}

class _HoverAnimatedTextState extends State<HoverAnimatedText> with TickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Ticker _ticker;
  
  // Physics arrays for 45 columns
  final List<double> _heights = List.filled(45, 0.0);
  final List<double> _velocities = List.filled(45, 0.0);
  final List<_Bubble> _bubbles = [];

  Offset _mousePos = Offset.zero;
  Offset _prevMousePos = Offset.zero;
  bool _isHovered = false;
  bool _justEntered = false;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    // Hover controller animates water level rising and fading (from 0.0 to 1.0)
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    // Vsync ticker runs physics and redraws at 60fps/120fps dynamically
    _ticker = createTicker(_onTick);
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
              // Base static text
              Opacity(
                opacity: (1.0 - hoverVal).clamp(0.0, 1.0),
                child: Text(
                  widget.text,
                  style: widget.style,
                  textAlign: widget.textAlign,
                  overflow: widget.overflow,
                  maxLines: widget.maxLines,
                ),
              ),
              // Glowing interactive shallow water layer
              if (hoverVal > 0.0)
                Opacity(
                  opacity: hoverVal,
                  child: CustomPaint(
                    painter: _WaterTextPainter(
                      text: widget.text,
                      style: widget.style,
                      textAlign: widget.textAlign,
                      overflow: widget.overflow,
                      maxLines: widget.maxLines,
                      heights: _heights,
                      velocities: _velocities,
                      bubbles: _bubbles,
                      hoverProgress: hoverVal,
                      mousePos: _mousePos,
                      prevMousePos: _prevMousePos,
                      isHovered: _isHovered,
                      justEntered: _justEntered,
                      time: _time,
                      waterColor: widget.liquidColor,
                      onHandledEntry: () {
                        _justEntered = false;
                      },
                    ),
                    child: Text(
                      widget.text,
                      style: widget.style.copyWith(color: Colors.transparent),
                      textAlign: widget.textAlign,
                      overflow: widget.overflow,
                      maxLines: widget.maxLines,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Alignment _getAlignment(TextAlign? textAlign) {
    if (textAlign == null) return Alignment.centerLeft;
    switch (textAlign) {
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.right:
      case TextAlign.end:
        return Alignment.centerRight;
      case TextAlign.left:
      case TextAlign.start:
      default:
        return Alignment.centerLeft;
    }
  }
}

class _Bubble {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;

  _Bubble({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });
}

class _WaterTextPainter extends CustomPainter {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  
  final List<double> heights;
  final List<double> velocities;
  final List<_Bubble> bubbles;
  
  final double hoverProgress;
  final Offset mousePos;
  final Offset prevMousePos;
  final bool isHovered;
  final bool justEntered;
  final double time;
  final Color waterColor;
  final VoidCallback onHandledEntry;

  const _WaterTextPainter({
    required this.text,
    required this.style,
    required this.textAlign,
    required this.overflow,
    required this.maxLines,
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
    // 1. Layout primary text mask
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style.copyWith(color: Colors.white)),
      textDirection: TextDirection.ltr,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      ellipsis: overflow == TextOverflow.ellipsis ? '...' : null,
    );
    textPainter.layout(maxWidth: size.width);

    // 2. Draw empty glass container body
    final emptyPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style.copyWith(
          color: (style.color ?? Colors.white).withOpacity(0.08),
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      ellipsis: overflow == TextOverflow.ellipsis ? '...' : null,
    );
    emptyPainter.layout(maxWidth: size.width);
    emptyPainter.paint(canvas, Offset.zero);

    // 3. Setup wave baseline
    // Water fills up to 60% of the text container height on full hover
    final double restHeight = size.height * (1.0 - hoverProgress * 0.6);

    // If arrays are uninitialized, populate with baseline height
    if (heights.every((h) => h == 0.0)) {
      for (int i = 0; i < heights.length; i++) {
        heights[i] = size.height;
      }
    }

    // 4. Run Shallow Water spring-column physics
    final double k = 0.022; // Spring constant
    final double spread = 0.08; // Wave propagation speed
    final double dampening = 0.965; // Viscous friction / decay

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

    // Apply velocities and limit height bounds
    for (int i = 0; i < heights.length; i++) {
      if (i > 0) heights[i - 1] += leftDeltas[i];
      if (i < heights.length - 1) heights[i + 1] += rightDeltas[i];

      velocities[i] *= dampening;
      heights[i] += velocities[i];
      heights[i] = heights[i].clamp(0.0, size.height);
    }

    // 5. Handle Interactive Mouse Splash
    final double colWidth = size.width / (heights.length - 1);
    final int colIdx = (mousePos.dx / colWidth).floor().clamp(0, heights.length - 1);

    if (isHovered) {
      if (justEntered) {
        // Trigger initial entry splash
        velocities[colIdx] -= size.height * 0.18;
        if (colIdx > 0) velocities[colIdx - 1] -= size.height * 0.09;
        if (colIdx < heights.length - 1) velocities[colIdx + 1] -= size.height * 0.09;
        onHandledEntry();
      } else {
        // Calculate mouse drag velocity
        final double dist = (mousePos - prevMousePos).distance;
        if (dist > 0.4) {
          // Push column downward (or upward depending on speed)
          final double push = (mousePos.dy > heights[colIdx] ? 1.0 : -1.0) * dist * 0.22;
          velocities[colIdx] += push;
          if (colIdx > 0) velocities[colIdx - 1] += push * 0.5;
          if (colIdx < heights.length - 1) velocities[colIdx + 1] += push * 0.5;
        }
      }
    }

    // 6. Handle floating bubbles update
    final random = math.Random();
    // Spawn bubbles near bottom
    if (isHovered && random.nextDouble() < 0.12) {
      final double bx = random.nextDouble() * size.width;
      bubbles.add(_Bubble(
        x: bx,
        y: size.height,
        vx: (random.nextDouble() - 0.5) * 0.5,
        vy: -0.7 - random.nextDouble() * 1.3,
        radius: 1.0 + random.nextDouble() * 2.0,
        opacity: 0.25 + random.nextDouble() * 0.5,
      ));
    }

    // Update positions and pop on surface
    for (int i = bubbles.length - 1; i >= 0; i--) {
      final b = bubbles[i];
      b.y += b.vy;
      b.x += b.vx + math.sin(time * 6.0 + b.y) * 0.35;

      final int col = (b.x / colWidth).floor().clamp(0, heights.length - 1);
      final double waterSurfaceY = heights[col];

      if (b.y <= waterSurfaceY || b.x < 0 || b.x > size.width) {
        bubbles.removeAt(i);
      }
    }

    // 7. Paint contents inside text bounds
    final rect = Offset.zero & size;
    canvas.saveLayer(rect, Paint());

    // Paint text mask
    textPainter.paint(canvas, Offset.zero);

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
          waterColor.withOpacity(0.88), // Glowing cyan surface
          Color.alphaBlend(Colors.black.withOpacity(0.8), waterColor).withOpacity(0.92), // Deep water
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
      ..strokeWidth = 2.2
      ..color = const Color(0xFFE0F7FA);
    canvas.drawPath(crestPath, crestPaint);

    // Draw floating bubbles
    for (final b in bubbles) {
      // Outer bubble circle
      final bubblePaint = Paint()
        ..blendMode = BlendMode.srcIn
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = Colors.white.withOpacity(b.opacity);
      canvas.drawCircle(Offset(b.x, b.y), b.radius, bubblePaint);

      // Specular highlight dot
      final specPaint = Paint()
        ..blendMode = BlendMode.srcIn
        ..color = Colors.white.withOpacity(b.opacity * 0.8);
      canvas.drawCircle(Offset(b.x - b.radius * 0.35, b.y - b.radius * 0.35), b.radius * 0.22, specPaint);
    }

    canvas.restore();

    // 8. Overlay thin translucent glass outlines
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(0.22);
    final outlinePainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style.copyWith(
          color: null,
          foreground: outlinePaint,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      ellipsis: overflow == TextOverflow.ellipsis ? '...' : null,
    );
    outlinePainter.layout(maxWidth: size.width);
    outlinePainter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant _WaterTextPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.style != style ||
        oldDelegate.hoverProgress != hoverProgress ||
        oldDelegate.mousePos != mousePos ||
        oldDelegate.isHovered != isHovered ||
        oldDelegate.time != time ||
        oldDelegate.waterColor != waterColor;
  }
}
