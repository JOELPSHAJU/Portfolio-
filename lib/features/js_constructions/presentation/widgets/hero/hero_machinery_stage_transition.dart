import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../painters/hero_laser_scan_painter.dart';

/// Cinematic 3D Drive-In, Perspective Swivel & Hydraulic Suspension Transition
class HeroMachineryStageTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final bool isIncoming;
  final int direction;

  const HeroMachineryStageTransition({
    super.key,
    required this.child,
    required this.animation,
    required this.isIncoming,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final double rawVal = animation.value;

        if (isIncoming) {
          // Curved progression for incoming vehicle
          final double t = Curves.easeOutCubic.transform(rawVal);

          // Hydraulic suspension compression and subtle rebound on touchdown:
          // Drops slightly onto the pad at rawVal > 0.38, compresses, then settles
          final double impactBounce = (rawVal > 0.38)
              ? math.sin((rawVal - 0.38) / 0.62 * math.pi * 2.0) *
                    math.exp(-(rawVal - 0.38) * 3.8) *
                    9.0
              : 0.0;

          // 3D Drive-In Slide Displacement along approach vector
          final double dx = direction * 230.0 * (1.0 - t);
          final double dy = -(1.0 - t) * 22.0 + impactBounce;

          // Hero scale progression from 0.76x to 1.0x
          final double scale = 0.76 + (0.24 * t);

          // 3D Turntable rotation: angled as it enters, swivels squarely toward viewer
          final double rotY = -direction * 0.36 * (1.0 - t);

          // Body roll along trajectory
          final double rotZ = -direction * 0.030 * (1.0 - t);

          // Fast opacity ramp so machine is prominently displayed throughout drive-in
          final double opacity = (rawVal * 2.4).clamp(0.0, 1.0);

          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.bottomCenter,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0014)
                  ..rotateY(rotY)
                  ..rotateZ(rotZ),
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: opacity,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      child,
                      // Subtle holographic laser scan sheen sweeping across the machine during entrance
                      if (rawVal < 0.96)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: ClipRect(
                              child: CustomPaint(
                                painter: HeroLaserScanPainter(
                                  progress: rawVal,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          // Outgoing machine: swivels away in 3D and retreats into the background staging area
          final double t = Curves.easeInCubic.transform(1.0 - rawVal);

          final double dx = -direction * 210.0 * t;
          final double dy = -16.0 * t;
          final double scale = 1.0 - (0.24 * t);
          final double rotY = direction * 0.32 * t;
          final double rotZ = direction * 0.024 * t;
          final double opacity = (rawVal / 0.55).clamp(0.0, 1.0);

          return Transform.translate(
            offset: Offset(dx, dy),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.bottomCenter,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0014)
                  ..rotateY(rotY)
                  ..rotateZ(rotZ),
                alignment: Alignment.bottomCenter,
                child: Opacity(opacity: opacity, child: child),
              ),
            ),
          );
        }
      },
    );
  }
}
