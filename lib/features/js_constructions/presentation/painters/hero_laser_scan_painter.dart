import 'package:flutter/material.dart';

/// Holographic Laser Contour Sweep Painter
class HeroLaserScanPainter extends CustomPainter {
  final double progress;

  const HeroLaserScanPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0.05 || progress >= 0.95) return;
    final double sweep = (progress - 0.05) / 0.90;
    final double scanX = size.width * sweep;

    // Glowing laser beam line
    final linePaint = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: (1.0 - sweep) * 0.75)
      ..strokeWidth = 2.0;

    canvas.drawLine(Offset(scanX, 0), Offset(scanX, size.height), linePaint);

    // Subtle laser beam gradient flare
    final flarePaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFFFF9F1C).withValues(alpha: (1.0 - sweep) * 0.20),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(scanX - 25, 0, 50, size.height));

    canvas.drawRect(Rect.fromLTWH(scanX - 25, 0, 50, size.height), flarePaint);
  }

  @override
  bool shouldRepaint(covariant HeroLaserScanPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
