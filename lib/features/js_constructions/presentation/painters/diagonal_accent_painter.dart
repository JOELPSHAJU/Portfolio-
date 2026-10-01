import 'package:flutter/material.dart';

/// Diagonal 45-degree Blueprint Hazard accent painter
class DiagonalAccentPainter extends CustomPainter {
  const DiagonalAccentPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.45)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
