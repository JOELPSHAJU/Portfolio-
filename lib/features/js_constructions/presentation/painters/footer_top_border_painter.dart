import 'package:flutter/material.dart';

/// Technical yellow/amber top border line for the footer panel
class FooterTopBorderPainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;

  const FooterTopBorderPainter({
    this.lineColor = const Color(0xFFFF9F1C),
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    const stepY = 12.0;
    final leftStepX = (w * 0.10).clamp(50.0, 130.0);
    final rightStepX = w - (w * 0.14).clamp(60.0, 160.0);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(leftStepX, 0)
      ..lineTo(leftStepX + stepY, stepY)
      ..lineTo(rightStepX - 24.0, stepY)
      ..lineTo(rightStepX - 16.0, stepY + 6.0)
      ..lineTo(rightStepX + 16.0, stepY + 6.0)
      ..lineTo(rightStepX + 24.0, 0)
      ..lineTo(w, 0);

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(path, paint);

    // Corner tech accent ticks
    final tickPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(leftStepX + stepY, stepY + 4),
      Offset(leftStepX + stepY + 12, stepY + 4),
      tickPaint,
    );
    canvas.drawLine(
      Offset(rightStepX - 24.0, stepY + 4),
      Offset(rightStepX - 12.0, stepY + 4),
      tickPaint,
    );
  }

  @override
  bool shouldRepaint(covariant FooterTopBorderPainter oldDelegate) => false;
}
