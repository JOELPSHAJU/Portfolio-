import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Atmospheric Dust & Haze Particles
class AtmosphericDustPainter extends CustomPainter {
  final double progress;

  const AtmosphericDustPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final dustPaint = Paint()..style = PaintingStyle.fill;

    final random = math.Random(42);
    for (int i = 0; i < 45; i++) {
      final x = (random.nextDouble() * size.width + progress * 60) % size.width;
      final y =
          (random.nextDouble() * size.height - progress * 100) % size.height;
      final radius = 1.0 + random.nextDouble() * 2.2;
      final alpha = (0.15 + random.nextDouble() * 0.35).clamp(0.0, 1.0);

      dustPaint.color = const Color(0xFFFFE0A0).withValues(alpha: alpha);
      canvas.drawCircle(Offset(x, y), radius, dustPaint);
    }
  }

  @override
  bool shouldRepaint(covariant AtmosphericDustPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
