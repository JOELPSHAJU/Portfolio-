import 'package:flutter/material.dart';

/// Circular social media button with hover effect
class FooterSocialButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const FooterSocialButton({super.key, required this.child, this.onTap});

  @override
  State<FooterSocialButton> createState() => _FooterSocialButtonState();
}

class _FooterSocialButtonState extends State<FooterSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.15)
                : const Color(0x331E293B),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFF9F1C)
                  : const Color(0xFF334155),
              width: 1.0,
            ),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
