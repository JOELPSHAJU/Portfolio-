import 'package:flutter/material.dart';

/// Corner style for the Zone 04 Technical Blueprint Cards
enum TechCardCorner { topLeft, topRight }

/// Path generator for the chamfered tech card geometry
Path buildTechCardPath(
  Size size,
  TechCardCorner corner,
  double chamfer,
  double r,
) {
  final path = Path();
  final w = size.width;
  final h = size.height;

  if (corner == TechCardCorner.topLeft) {
    path.moveTo(chamfer, 0);
    path.lineTo(w - r, 0);
    path.arcToPoint(Offset(w, r), radius: Radius.circular(r));
    path.lineTo(w, h - r);
    path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    path.lineTo(r, h);
    path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    path.lineTo(0, chamfer);
    path.lineTo(chamfer, 0);
    path.close();
  } else {
    path.moveTo(r, 0);
    path.lineTo(w - chamfer, 0);
    path.lineTo(w, chamfer);
    path.lineTo(w, h - r);
    path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    path.lineTo(r, h);
    path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    path.lineTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
    path.close();
  }

  return path;
}

/// Custom painter for the tech card chamfer, border and orange corner accent
class TechCardBackgroundPainter extends CustomPainter {
  final TechCardCorner corner;
  final double chamfer;
  final double cornerRadius;
  final Color borderColor;
  final Color fillColor;
  final bool hasOrangeAccent;
  final bool isHovered;

  const TechCardBackgroundPainter({
    required this.corner,
    this.chamfer = 24.0,
    this.cornerRadius = 6.0,
    required this.borderColor,
    required this.fillColor,
    this.hasOrangeAccent = false,
    this.isHovered = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = buildTechCardPath(size, corner, chamfer, cornerRadius);

    // 1. Hover ambient glow
    if (isHovered) {
      final glowPaint = Paint()
        ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);
      canvas.drawPath(path, glowPaint);
    }

    // 2. Background fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Crisp tech stroke border
    final strokePaint = Paint()
      ..color = isHovered
          ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
          : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? 1.5 : 1.2;
    canvas.drawPath(path, strokePaint);

    // 4. Solid Orange Corner Triangle (matching the top-right corner notch on Cards 02 & 04)
    if (hasOrangeAccent && corner == TechCardCorner.topRight) {
      final accentPath = Path()
        ..moveTo(size.width - chamfer, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, chamfer)
        ..close();

      final accentPaint = Paint()
        ..color = const Color(0xFFFF9F1C)
        ..style = PaintingStyle.fill;
      canvas.drawPath(accentPath, accentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant TechCardBackgroundPainter oldDelegate) =>
      oldDelegate.corner != corner ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.hasOrangeAccent != hasOrangeAccent ||
      oldDelegate.isHovered != isHovered;
}
