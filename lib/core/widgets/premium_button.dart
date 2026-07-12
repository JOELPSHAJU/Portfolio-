import 'package:flutter/material.dart';
import '../theme/brand_colors.dart';

/// An elegant button featuring premium gradients and smooth scale-press micro-animations.
class PremiumButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Gradient gradient;
  final Color glowColor;
  final bool isLoading;
  final Color? textColor;
  final Color? borderColor;

  const PremiumButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradient = BrandColors.primaryGradient,
    this.glowColor = BrandColors.primaryNeon,
    this.isLoading = false,
    this.textColor,
    this.borderColor,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = widget.textColor ?? Colors.white;
    final hasBorder = widget.borderColor != null;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: widget.gradient,
            border: hasBorder
                ? Border.all(color: widget.borderColor!, width: 1)
                : null,
            boxShadow: widget.glowColor == Colors.transparent
                ? []
                : [
                    BoxShadow(
                      color: widget.glowColor.withOpacity(_hovered ? 0.40 : 0.22),
                      blurRadius: _hovered ? 20 : 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              splashColor: Colors.white.withOpacity(0.10),
              highlightColor: Colors.transparent,
              onTapDown: (_) {
                if (!widget.isLoading) _controller.forward();
              },
              onTapCancel: () {
                if (!widget.isLoading) _controller.reverse();
              },
              onTap: () {
                if (!widget.isLoading) {
                  _controller.reverse();
                  widget.onPressed();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading) ...[
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: labelColor,
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ] else if (widget.icon != null) ...[
                      Icon(widget.icon, color: labelColor, size: 17),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: labelColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
