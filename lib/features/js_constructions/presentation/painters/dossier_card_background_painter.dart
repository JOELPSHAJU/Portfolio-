import 'package:flutter/material.dart';

/// Path generator for the tabbed military dossier folder card geometry
Path buildDossierCardPath(
  Size size, {
  double tabWidth = 64.0,
  double stepDown = 12.0,
  double cornerRadius = 8.0,
}) {
  final path = Path();
  final w = size.width;
  final h = size.height;
  final r = cornerRadius;

  path.moveTo(r, 0);
  path.lineTo(tabWidth, 0);
  path.lineTo(tabWidth + stepDown, stepDown);
  path.lineTo(w - r, stepDown);
  path.arcToPoint(Offset(w, stepDown + r), radius: Radius.circular(r));
  path.lineTo(w, h - r);
  path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
  path.lineTo(r, h);
  path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
  path.lineTo(0, r);
  path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
  path.close();

  return path;
}

/// Custom painter for the tabbed dossier card background, glow and technical border
class DossierCardBackgroundPainter extends CustomPainter {
  final double tabWidth;
  final double stepDown;
  final double cornerRadius;
  final Color borderColor;
  final Color fillColor;
  final bool isHovered;

  const DossierCardBackgroundPainter({
    this.tabWidth = 64.0,
    this.stepDown = 12.0,
    this.cornerRadius = 8.0,
    required this.borderColor,
    required this.fillColor,
    this.isHovered = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final effectiveTabWidth = (size.width * 0.38).clamp(56.0, 78.0);
    final path = buildDossierCardPath(
      size,
      tabWidth: effectiveTabWidth,
      stepDown: stepDown,
      cornerRadius: cornerRadius,
    );

    // 1. Ambient outer glow when hovered
    if (isHovered) {
      final glowPaint = Paint()
        ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);
      canvas.drawPath(path, glowPaint);
    }

    // 2. Translucent dark fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Technical stroke border
    final strokePaint = Paint()
      ..color = isHovered
          ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
          : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? 1.5 : 1.2;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant DossierCardBackgroundPainter oldDelegate) =>
      oldDelegate.tabWidth != tabWidth ||
      oldDelegate.stepDown != stepDown ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.isHovered != isHovered;
}
