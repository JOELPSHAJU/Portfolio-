import 'package:flutter/material.dart';

/// Vector Painter for Excavator / Heavy Earthmoving Icon
class ExcavatorIconPainter extends CustomPainter {
  final Color color;
  const ExcavatorIconPainter({this.color = const Color(0xFFDF9B35)});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scaleX = size.width / 28.0;
    final scaleY = size.height / 28.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    // 1. Crawler Tracks
    final trackRRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(2.5, 19.5, 13.0, 5.0),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(trackRRect, strokePaint);

    // Track rollers / wheels inside
    canvas.drawCircle(const Offset(5.5, 22.0), 0.9, fillPaint);
    canvas.drawCircle(const Offset(9.0, 22.0), 0.9, fillPaint);
    canvas.drawCircle(const Offset(12.5, 22.0), 0.9, fillPaint);

    // 2. Cab & Body
    final cabPath = Path()
      ..moveTo(4.0, 19.5)
      ..lineTo(4.0, 14.0)
      ..lineTo(7.5, 11.5)
      ..lineTo(13.5, 11.5)
      ..lineTo(13.5, 19.5);
    canvas.drawPath(cabPath, strokePaint);

    // Cab window
    final windowPath = Path()
      ..moveTo(7.5, 13.0)
      ..lineTo(12.0, 13.0)
      ..lineTo(12.0, 16.5)
      ..lineTo(6.5, 16.5)
      ..close();
    canvas.drawPath(windowPath, strokePaint);

    // 3. Boom & Stick
    final boomPath = Path()
      ..moveTo(12.5, 16.0)
      ..lineTo(17.0, 7.5)
      ..lineTo(21.5, 12.0)
      ..lineTo(22.0, 18.5);
    canvas.drawPath(boomPath, strokePaint);

    // Hydraulic piston line
    canvas.drawLine(
      const Offset(13.0, 13.5),
      const Offset(16.0, 9.5),
      strokePaint,
    );

    // 4. Bucket scoop
    final bucketPath = Path()
      ..moveTo(22.0, 18.5)
      ..lineTo(25.5, 20.0)
      ..lineTo(24.5, 24.0)
      ..lineTo(20.0, 23.5)
      ..lineTo(20.5, 19.5);
    canvas.drawPath(bucketPath, strokePaint);

    // Bucket teeth
    canvas.drawLine(
      const Offset(24.5, 24.0),
      const Offset(23.0, 25.5),
      strokePaint,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ExcavatorIconPainter oldDelegate) =>
      oldDelegate.color != color;
}
