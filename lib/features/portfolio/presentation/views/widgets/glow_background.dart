import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';

/// Performance-optimised ambient background.
///
/// Design goals (no scroll jank):
///  1. ONE AnimatedBuilder for all animated layers — one animation listener,
///     not three.
///  2. RepaintBoundary around the background stack — the scroll view above
///     never triggers a background repaint and vice-versa.
///  3. BackdropFilter REMOVED — sigmaX/Y=95 forced a full raster flush every
///     frame, the single largest source of scroll jank.
///  4. Particle & sphere layers isolated in their own RepaintBoundary.
///  5. shouldRepaint returns false when data is unchanged.
class GlowBackground extends StatefulWidget {
  final Widget child;

  const GlowBackground({super.key, required this.child});

  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(14, (_) => _Particle());

  @override
  void initState() {
    super.initState();
    // Slow cadence — less GPU work per second
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!isDark) {
      return _LightBackground(child: widget.child);
    }

    return Scaffold(
      backgroundColor: BrandColors.darkBackground,
      body: Stack(
        children: [
          // ── Static base fill — never repaints ─────────────────────
          const Positioned.fill(
            child: ColoredBox(color: BrandColors.darkBackground),
          ),

          // ── All animated layers in ONE AnimatedBuilder ─────────────
          // Wrapped in RepaintBoundary so the scroll view above is
          // composited on a different layer and never forced to repaint.
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              child: const SizedBox.expand(), // const child — not rebuilt
              builder: (context, _) {
                final t = _controller.value;
                final val = t * 2 * math.pi;

                return CustomPaint(
                  painter: _BackgroundPainter(
                    progress: t,
                    val: val,
                    size: size,
                    particles: _particles,
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),

          // ── Static grid — painted once, cached ────────────────────
          RepaintBoundary(
            child: CustomPaint(
              painter: _GridPainter(gridSize: 32, opacity: 0.03),
              child: const SizedBox.expand(),
            ),
          ),

          // ── Scrollable content on its own compositor layer ──────────
          RepaintBoundary(child: widget.child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Light mode — fully static, no animation at all
// ─────────────────────────────────────────────────────────────────────────────
class _LightBackground extends StatelessWidget {
  final Widget child;

  const _LightBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          // Static gradient
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFFFFF), Color(0xFFF4F4FF), Color(0xFFEEEEFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Static accent glows — no animation
          Positioned(
            left: -120,
            top: -80,
            child: _StaticGlow(
              size: 500,
              color: BrandColors.primaryNeon.withOpacity(0.06),
            ),
          ),
          Positioned(
            right: -80,
            top: 200,
            child: _StaticGlow(
              size: 420,
              color: BrandColors.accentNeon.withOpacity(0.05),
            ),
          ),
          // Grid overlay
          RepaintBoundary(
            child: CustomPaint(
              painter: _GridPainter(gridSize: 36, opacity: 0.025),
              child: const SizedBox.expand(),
            ),
          ),
          RepaintBoundary(child: child),
        ],
      ),
    );
  }
}

class _StaticGlow extends StatelessWidget {
  final double size;
  final Color color;

  const _StaticGlow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single CustomPainter that owns ALL dark-mode animated layers:
//   • perspective grid (WorldDepth)
//   • 3 ambient spheres
//   • particles
// Consolidating into one painter means one canvas.save/restore and one
// shouldRepaint check instead of three separate AnimatedBuilders.
// ─────────────────────────────────────────────────────────────────────────────
class _BackgroundPainter extends CustomPainter {
  final double progress;
  final double val;
  final Size size;
  final List<_Particle> particles;

  _BackgroundPainter({
    required this.progress,
    required this.val,
    required this.size,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    // 1. Perspective depth grid
    _paintDepthGrid(canvas, canvasSize);

    // 2. Ambient glow spheres
    _paintSpheres(canvas, canvasSize);

    // 3. Particles
    _paintParticles(canvas, canvasSize);
  }

  void _paintDepthGrid(Canvas canvas, Size s) {
    final horizonY = s.height * 0.44;
    final vp = Offset(s.width * 0.5, horizonY);

    final gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.6
      ..color = Colors.white.withOpacity(0.04);

    final accentPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..color = BrandColors.primaryNeon.withOpacity(0.08);

    // Radial lines
    for (var i = -8; i <= 8; i++) {
      canvas.drawLine(
        vp,
        Offset(s.width * 0.5 + i * s.width * 0.12, s.height),
        gridPaint,
      );
    }

    // Horizontal depth bands
    for (var i = 0; i < 12; i++) {
      final t = i / 11;
      final eased = t * t;
      final y = lerpDouble(s.height * 0.48, s.height, eased)!;
      final w = lerpDouble(s.width * 0.12, s.width * 1.3, eased)!;
      canvas.drawLine(
        Offset(s.width * 0.5 - w / 2, y),
        Offset(s.width * 0.5 + w / 2, y),
        gridPaint,
      );
    }

    // Horizon line
    canvas.drawLine(
      Offset(s.width * 0.08, horizonY),
      Offset(s.width * 0.92, horizonY),
      accentPaint,
    );

    // Pulsing arcs
    final pulse = 0.5 + math.sin(progress * math.pi * 2) * 0.5;
    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = BrandColors.primaryNeon.withOpacity(0.04 + pulse * 0.04);

    for (var i = 0; i < 3; i++) {
      final r = s.width * (0.18 + i * 0.10 + pulse * 0.012);
      canvas.drawArc(
        Rect.fromCircle(center: Offset(s.width * 0.5, horizonY), radius: r),
        math.pi,
        math.pi,
        false,
        glowPaint,
      );
    }
  }

  void _paintSpheres(Canvas canvas, Size s) {
    // Spheres move very slowly — divided by 3 to reduce jitter vs 15s cycle
    final s1 = Offset(
      math.sin(val) * 60 - s.width * 0.1,
      math.cos(val) * 60 - s.height * 0.1,
    );
    final s2 = Offset(
      math.cos(val * 0.7) * 75 + s.width * 0.7,
      math.sin(val * 0.7) * 75 + s.height * 0.35,
    );
    final s3 = Offset(
      math.sin(val + math.pi) * 65 + s.width * 0.2,
      math.cos(val + math.pi) * 65 + s.height * 0.75,
    );

    _drawSphere(canvas, s1, s.width * 0.65, BrandColors.primaryNeon, 0.09);
    _drawSphere(canvas, s2, s.width * 0.60, BrandColors.accentNeon, 0.07);
    _drawSphere(canvas, s3, s.width * 0.52, BrandColors.secondaryNeon, 0.08);
  }

  void _drawSphere(
    Canvas canvas,
    Offset offset,
    double diameter,
    Color color,
    double opacity,
  ) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);
    canvas.drawCircle(
      Offset(offset.dx + diameter / 2, offset.dy + diameter / 2),
      diameter / 2,
      paint,
    );
  }

  void _paintParticles(Canvas canvas, Size s) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (final p in particles) {
      p.update(progress);
      paint.color = BrandColors.accentNeon.withOpacity(p.opacity * 0.25);
      canvas.drawCircle(
        Offset(p.x * s.width, p.y * s.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter old) =>
      old.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────
class _Particle {
  late double x, y, size, speed, opacity, angle;

  _Particle() {
    final r = math.Random();
    x = r.nextDouble();
    y = r.nextDouble();
    size = r.nextDouble() * 2.5 + 0.8;
    speed = r.nextDouble() * 0.015 + 0.004;
    opacity = r.nextDouble() * 0.22 + 0.08;
    angle = r.nextDouble() * 2 * math.pi;
  }

  void update(double progress) {
    y -= speed * 0.08;
    if (y < 0) y = 1.0;
    x += math.sin(progress * 2 * math.pi + angle) * 0.0015;
    if (x < 0) x = 1.0;
    if (x > 1.0) x = 0.0;
  }
}

class _GridPainter extends CustomPainter {
  final double gridSize;
  final double opacity;

  const _GridPainter({required this.gridSize, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 0.4;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  // Grid is static — never needs repainting
  bool shouldRepaint(covariant _GridPainter old) =>
      old.gridSize != gridSize || old.opacity != opacity;
}
