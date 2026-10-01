import 'package:flutter/material.dart';

/// JS Architectural Stylized Logo Painter
class JsLogoPainter extends CustomPainter {
  const JsLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final orangePaint = Paint()
      ..color = const Color(0xFFFF9F1C)
      ..style = PaintingStyle.fill;

    // Left chevron beam
    final leftBeam = Path()
      ..moveTo(w * 0.38, 0)
      ..lineTo(w * 0.54, 0)
      ..lineTo(w * 0.18, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(leftBeam, orangePaint);

    // Right chevron upper beam
    final rightBeam = Path()
      ..moveTo(w * 0.40, 0)
      ..lineTo(w * 0.56, 0)
      ..lineTo(w * 0.86, h * 0.65)
      ..lineTo(w * 0.70, h * 0.65)
      ..close();
    canvas.drawPath(rightBeam, orangePaint);

    // White lower right wedge
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final whiteWedge = Path()
      ..moveTo(w * 0.52, h)
      ..lineTo(w * 0.80, h * 0.60)
      ..lineTo(w, h * 0.60)
      ..lineTo(w * 0.72, h)
      ..close();
    canvas.drawPath(whiteWedge, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
