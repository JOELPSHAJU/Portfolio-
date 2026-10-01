import 'package:flutter/material.dart';

/// Hazard warning diagonal slashes for the bottom-right of the copyright bar
class FooterBottomHazardPainter extends CustomPainter {
  const FooterBottomHazardPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF9F1C)
      ..style = PaintingStyle.fill;

    const barW = 5.0;
    const gap = 3.5;
    const count = 4;

    for (int i = 0; i < count; i++) {
      final x = i * (barW + gap);
      final path = Path()
        ..moveTo(x + size.height * 0.7, 0)
        ..lineTo(x + size.height * 0.7 + barW, 0)
        ..lineTo(x + barW, size.height)
        ..lineTo(x, size.height)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
