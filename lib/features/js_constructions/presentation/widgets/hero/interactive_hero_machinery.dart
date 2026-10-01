import 'package:flutter/material.dart';

/// Interactive 3D Turntable Mouse Parallax Tilt for Desktop
class InteractiveHeroMachinery extends StatefulWidget {
  final Widget child;
  final bool isDesktop;

  const InteractiveHeroMachinery({
    super.key,
    required this.child,
    required this.isDesktop,
  });

  @override
  State<InteractiveHeroMachinery> createState() =>
      _InteractiveHeroMachineryState();
}

class _InteractiveHeroMachineryState extends State<InteractiveHeroMachinery> {
  double _hoverX = 0.0;
  double _hoverY = 0.0;

  @override
  Widget build(BuildContext context) {
    if (!widget.isDesktop) return widget.child;

    return MouseRegion(
      onHover: (event) {
        final size = context.size ?? const Size(400, 300);
        final localPos = event.localPosition;
        setState(() {
          _hoverX = ((localPos.dx / size.width) - 0.5).clamp(-0.5, 0.5);
          _hoverY = ((localPos.dy / size.height) - 0.5).clamp(-0.5, 0.5);
        });
      },
      onExit: (_) {
        setState(() {
          _hoverX = 0.0;
          _hoverY = 0.0;
        });
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: _hoverX),
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        builder: (context, hx, innerWidget) {
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: _hoverY),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            builder: (context, hy, innerChild) {
              final matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateY(hx * 0.14) // subtle ±4 degrees
                ..rotateX(-hy * 0.08); // subtle ±2.3 degrees
              return Transform(
                transform: matrix,
                alignment: Alignment.bottomCenter,
                child: innerChild ?? const SizedBox.shrink(),
              );
            },
            child: innerWidget,
          );
        },
        child: widget.child,
      ),
    );
  }
}
