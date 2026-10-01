import 'package:flutter/material.dart';

/// Vector Painter for Safety Shield with Checkmark Icon
class SafetyShieldIconPainter extends CustomPainter {
  final Color color;
  const SafetyShieldIconPainter({this.color = const Color(0xFFDF9B35)});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 28.0;
    final scaleY = size.height / 28.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    // 1. Shield outline
    final shieldPath = Path()
      ..moveTo(14.0, 3.5)
      ..lineTo(22.5, 6.0)
      ..lineTo(22.5, 13.5)
      ..cubicTo(22.5, 19.0, 18.0, 23.0, 14.0, 25.0)
      ..cubicTo(10.0, 23.0, 5.5, 19.0, 5.5, 13.5)
      ..lineTo(5.5, 6.0)
      ..close();
    canvas.drawPath(shieldPath, strokePaint);

    // 2. Checkmark inside
    final checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path()
      ..moveTo(9.5, 14.0)
      ..lineTo(12.8, 17.5)
      ..lineTo(18.5, 10.5);
    canvas.drawPath(checkPath, checkPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SafetyShieldIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
