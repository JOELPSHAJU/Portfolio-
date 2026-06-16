import 'dart:async';
import 'package:flutter/material.dart';

/// Ultra-smooth entrance animation — GPU-only ops, zero CPU raster cost.
///
/// Uses ONLY hardware-accelerated primitives:
///   • Opacity  → compositor layer, zero pixel work
///   • Transform.scale / translate → matrix op on the GPU
///   • RepaintBoundary  → isolates the animated subtree so parents never repaint
///
/// The blur-based version was dropped: ImageFilter.blur runs on the CPU
/// raster thread and causes visible jank on every animated frame.
///
/// Curve: easeOutExpo — the sharpest, most "snappy-professional" deceleration
/// curve, the same used by Framer Motion's default spring.
class FadeInSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double direction; // kept for API compat — maps to Y-lift pixels

  const FadeInSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.direction = 30.0,
  });

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<double> _scale;
  late Animation<double> _lift;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(vsync: this, duration: widget.duration);

    // Exponential ease-out: fast start, buttery-smooth landing
    const curve = Curves.easeOutExpo;

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: curve),
    );

    // Gentle scale-up: starts at 95% — feels premium, not gimmicky
    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: curve),
    );

    // Y-lift: direction prop controls magnitude (default 30px)
    _lift = Tween<double>(begin: widget.direction, end: 0.0).animate(
      CurvedAnimation(parent: _ctrl, curve: curve),
    );

    if (widget.delay == Duration.zero) {
      _ctrl.forward();
    } else {
      _timer = Timer(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _ctrl,
        // child is NOT rebuilt on every tick — passed through as const child
        child: widget.child,
        builder: (context, child) {
          return Opacity(
            opacity: _fade.value,
            child: Transform(
              // Single matrix call: scale + translate in one GPU op
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..translate(0.0, _lift.value)
                ..scale(_scale.value),
              child: child,
            ),
          );
        },
      ),
    );
  }
}
