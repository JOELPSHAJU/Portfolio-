import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';

/// A minimalist, premium background.
/// Features a completely plain surface color illuminated by ultra-soft,
/// heavily blurred, and slowly drifting ambient color orbs.
class GlowBackground extends StatefulWidget {
  final Widget child;

  const GlowBackground({super.key, required this.child});

  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 30 seconds for an extremely calm, imperceptible drifting animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pal = context.palette;

    return Scaffold(
      backgroundColor: pal.surface,
      body: Stack(
        children: [
          // ── Minimalist Blurred Color Orbs ──
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: _AmbientGlowPainter(
                    progress: _controller.value,
                    isDark: isDark,
                  ),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),
          
          // ── Foreground Content ──
          RepaintBoundary(child: widget.child),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Soft Ambient Glow Painter
// ─────────────────────────────────────────────────────────────────────────────
class _AmbientGlowPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _AmbientGlowPainter({
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * 2 * math.pi;

    // Helper to draw heavily blurred, low-opacity ambient orbs
    void drawBlurredOrb(Offset center, double radius, Color color, double opacity) {
      final paint = Paint()
        ..color = color.withValues(alpha: opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 200); // Massive blur for soft gradients
      canvas.drawCircle(center, radius, paint);
    }

    if (isDark) {
      // ── Dark Mode Ambient Glows ──
      // Subtle cyan/neon glow top-left
      drawBlurredOrb(
        Offset(size.width * 0.2 + math.sin(t) * 100, size.height * 0.2 + math.cos(t) * 50),
        size.width * 0.45,
        BrandColors.primaryNeon,
        0.04, 
      );
      
      // Deep purple/magenta glow bottom-right
      drawBlurredOrb(
        Offset(size.width * 0.8 + math.cos(t * 0.8) * 100, size.height * 0.8 + math.sin(t * 0.8) * 50),
        size.width * 0.5,
        BrandColors.secondaryNeon,
        0.03,
      );

      // Warm structural glow drifting in the center
      drawBlurredOrb(
        Offset(size.width * 0.5 + math.sin(t * 1.2) * 150, size.height * 0.5 + math.cos(t * 1.2) * 100),
        size.width * 0.6,
        BrandColors.warmBrown,
        0.04,
      );
    } else {
      // ── Light Mode Ambient Glows ──
      // Soft warm charcoal gradient top-left
      drawBlurredOrb(
        Offset(size.width * 0.1 + math.sin(t) * 50, size.height * 0.2 + math.cos(t) * 30),
        size.width * 0.5,
        BrandColors.warmBrown,
        0.03, 
      );
      
      // Warm amber/gold subtle tint bottom-right
      drawBlurredOrb(
        Offset(size.width * 0.9 + math.cos(t * 0.7) * 80, size.height * 0.8 + math.sin(t * 0.7) * 40),
        size.width * 0.6,
        BrandColors.warmAmber,
        0.04,
      );

      // Pure white central core to keep the layout very airy and clean
      drawBlurredOrb(
        Offset(size.width * 0.5 + math.sin(t * 1.1) * 100, size.height * 0.5 + math.cos(t * 1.1) * 60),
        size.width * 0.4,
        Colors.white,
        0.3, 
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientGlowPainter old) => old.progress != progress;
}
