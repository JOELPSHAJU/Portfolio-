import 'package:flutter/material.dart';

/// Vector Painter for Skilled Construction Worker with Hardhat Icon
class WorkerIconPainter extends CustomPainter {
  final Color color;
  const WorkerIconPainter({this.color = const Color(0xFFDF9B35)});

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

    // 1. Hardhat dome
    final helmetPath = Path()
      ..moveTo(7.5, 9.0)
      ..cubicTo(7.5, 4.0, 20.5, 4.0, 20.5, 9.0);
    canvas.drawPath(helmetPath, strokePaint);

    // Helmet center crest
    canvas.drawLine(
      const Offset(14.0, 4.0),
      const Offset(14.0, 8.5),
      strokePaint,
    );

    // 2. Helmet brim
    final brimPath = Path()
      ..moveTo(5.0, 9.5)
      ..lineTo(23.0, 9.5);
    canvas.drawPath(brimPath, strokePaint);

    // 3. Head & neck outline
    final facePath = Path()
      ..moveTo(9.0, 10.5)
      ..lineTo(9.0, 14.0)
      ..cubicTo(9.0, 17.0, 19.0, 17.0, 19.0, 14.0)
      ..lineTo(19.0, 10.5);
    canvas.drawPath(facePath, strokePaint);

    // 4. Shoulders & upper torso
    final bodyPath = Path()
      ..moveTo(3.5, 24.5)
      ..cubicTo(5.5, 18.5, 9.5, 18.0, 12.0, 18.0)
      ..lineTo(16.0, 18.0)
      ..cubicTo(18.5, 18.0, 22.5, 18.5, 24.5, 24.5);
    canvas.drawPath(bodyPath, strokePaint);

    // Collar V
    final collarPath = Path()
      ..moveTo(12.0, 18.0)
      ..lineTo(14.0, 21.5)
      ..lineTo(16.0, 18.0);
    canvas.drawPath(collarPath, strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant WorkerIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
