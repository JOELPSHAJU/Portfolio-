import 'package:flutter/material.dart';

/// Structural Steel Gantry Perimeter Overlay (Hero Entrance Frame)
class SiteGantryFramePainter extends CustomPainter {
  const SiteGantryFramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final steelPaint = Paint()
      ..color = const Color(0xFF1E232E).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final yellowLine = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Left steel I-Beam column
    canvas.drawLine(const Offset(24, 0), Offset(24, size.height), steelPaint);
    canvas.drawLine(const Offset(31, 0), Offset(31, size.height), yellowLine);

    // Right steel I-Beam column
    canvas.drawLine(
      Offset(size.width - 24, 0),
      Offset(size.width - 24, size.height),
      steelPaint,
    );
    canvas.drawLine(
      Offset(size.width - 31, 0),
      Offset(size.width - 31, size.height),
      yellowLine,
    );

    // Cross Truss Braces
    final trussPaint = Paint()
      ..color = const Color(0xFF283040).withValues(alpha: 0.35)
      ..strokeWidth = 3;

    for (double y = 80; y < size.height; y += 180) {
      canvas.drawLine(Offset(24, y), Offset(100, y + 90), trussPaint);
      canvas.drawLine(Offset(100, y), Offset(24, y + 90), trussPaint);
      canvas.drawLine(
        Offset(size.width - 24, y),
        Offset(size.width - 100, y + 90),
        trussPaint,
      );
      canvas.drawLine(
        Offset(size.width - 100, y),
        Offset(size.width - 24, y + 90),
        trussPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
