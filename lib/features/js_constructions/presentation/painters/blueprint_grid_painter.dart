import 'package:flutter/material.dart';

/// Precision Architectural Blueprint Millimeter Grid
class BlueprintGridPainter extends CustomPainter {
  final Color lineColor;
  final double step;

  const BlueprintGridPainter({
    this.lineColor = const Color(0x12FF9F1C),
    this.step = 36.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 0.8;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
