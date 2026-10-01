import 'package:flutter/material.dart';

/// Dynamic Expanding Amber Turntable Docking Shockwave Ring
class StageDockingRing extends StatelessWidget {
  final double width;
  const StageDockingRing({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 620),
      curve: Curves.easeOutCubic,
      builder: (context, val, _) {
        final double scale = 0.45 + (0.65 * val);
        final double opacity = (1.0 - val).clamp(0.0, 1.0) * 0.85;

        return Transform(
          transform: Matrix4.diagonal3Values(scale, scale * 0.38, 1.0),
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFF9F1C).withValues(alpha: opacity),
                width: 2.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    0xFFFF9F1C,
                  ).withValues(alpha: opacity * 0.65),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
