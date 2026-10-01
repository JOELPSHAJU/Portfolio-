import 'package:flutter/material.dart';

/// High-Precision Hazard Warning Chevron Stripe Painter
class HazardStripePainter extends CustomPainter {
  const HazardStripePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF161922);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final stripePaint = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.90);
    const stripeWidth = 14.0;
    for (
      double x = -size.height;
      x < size.width + size.height;
      x += stripeWidth * 2
    ) {
      final path = Path()
        ..moveTo(x, size.height)
        ..lineTo(x + stripeWidth, size.height)
        ..lineTo(x + stripeWidth + size.height, 0)
        ..lineTo(x + size.height, 0)
        ..close();
      canvas.drawPath(path, stripePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
