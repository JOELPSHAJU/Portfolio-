import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';

/// A premium futuristic ambient background featuring glowing neon spheres
/// blurred behind a glassmorphic surface overlay.
class GlowBackground extends StatefulWidget {
  final Widget child;

  const GlowBackground({super.key, required this.child});

  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = List.generate(20, (index) => _Particle());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
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
      // Clean light gradient for light mode
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3F6FA), Color(0xFFEAF0F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: widget.child,
      );
    }

    return Scaffold(
      backgroundColor: BrandColors.darkBackground,
      body: Stack(
        children: [
          // Sphere 1, 2, 3: Animated Aurora Glow Spheres
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final val = _controller.value * 2 * math.pi;

              // Slowly shifting positions for organic aurora float effect
              final sphere1Offset = Offset(
                math.sin(val) * 70 - size.width * 0.1,
                math.cos(val) * 70 - size.height * 0.1,
              );

              final sphere2Offset = Offset(
                math.cos(val * 0.8) * 90 + size.width * 0.7,
                math.sin(val * 0.8) * 90 + size.height * 0.35,
              );

              final sphere3Offset = Offset(
                math.sin(val + math.pi) * 80 + size.width * 0.2,
                math.cos(val + math.pi) * 80 + size.height * 0.75,
              );

              return Stack(
                children: [
                  // Sphere 1: Electric Indigo Glow
                  Positioned(
                    left: sphere1Offset.dx,
                    top: sphere1Offset.dy,
                    child: Container(
                      width: size.width * 0.65,
                      height: size.width * 0.65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BrandColors.primaryNeon.withOpacity(0.09),
                      ),
                    ),
                  ),

                  // Sphere 2: Cyan Aurora Glow
                  Positioned(
                    left: sphere2Offset.dx,
                    top: sphere2Offset.dy,
                    child: Container(
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BrandColors.secondaryNeon.withOpacity(0.08),
                      ),
                    ),
                  ),

                  // Sphere 3: Emerald Success Glow
                  Positioned(
                    left: sphere3Offset.dx,
                    top: sphere3Offset.dy,
                    child: Container(
                      width: size.width * 0.55,
                      height: size.width * 0.55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: BrandColors.successNeon.withOpacity(0.05),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Mesh grid pattern overlay for high-tech digital aesthetic
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(gridSize: 32, opacity: 0.04),
            ),
          ),

          // Floating particles layer
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlesPainter(
                    particles: _particles,
                    progress: _controller.value,
                  ),
                );
              },
            ),
          ),

          // Blur filter to blend the spheres smoothly
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 95.0, sigmaY: 95.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),

          // The page contents go over the background
          Positioned.fill(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

class _Particle {
  late double x;
  late double y;
  late double size;
  late double speed;
  late double opacity;
  late double angle;

  _Particle() {
    final random = math.Random();
    x = random.nextDouble();
    y = random.nextDouble();
    size = random.nextDouble() * 3.5 + 1;
    speed = random.nextDouble() * 0.02 + 0.005;
    opacity = random.nextDouble() * 0.25 + 0.1;
    angle = random.nextDouble() * 2 * math.pi;
  }

  void update(double progress) {
    y -= speed * 0.1;
    if (y < 0) y = 1.0;
    x += math.sin(progress * 2 * math.pi + angle) * 0.002;
    if (x < 0) x = 1.0;
    if (x > 1.0) x = 0.0;
  }
}

class ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  ParticlesPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var p in particles) {
      p.update(progress);
      paint.color = Colors.white.withOpacity(p.opacity);
      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GridPainter extends CustomPainter {
  final double gridSize;
  final double opacity;

  GridPainter({required this.gridSize, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
