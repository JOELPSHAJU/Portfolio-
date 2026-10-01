import 'package:flutter/material.dart';

/// Fleet circular chevron arrow button (< and >)
class FleetCircleArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const FleetCircleArrow({super.key, required this.icon, required this.onTap});

  @override
  State<FleetCircleArrow> createState() => _FleetCircleArrowState();
}

class _FleetCircleArrowState extends State<FleetCircleArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? const Color(0xFFE5A93B).withValues(alpha: 0.22)
                : Colors.black.withValues(alpha: 0.45),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFFE5A93B)
                  : Colors.white.withValues(alpha: 0.20),
              width: 1.2,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _hovered ? const Color(0xFFE5A93B) : Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
