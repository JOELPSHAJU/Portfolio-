import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Signature Dark Forest Green Button matching the original design
class SkincareButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isFullWidth;

  const SkincareButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  State<SkincareButton> createState() => _SkincareButtonState();
}

class _SkincareButtonState extends State<SkincareButton> {
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
          duration: const Duration(milliseconds: 180),
          width: widget.isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF132817)
                : const Color(0xFF1E3822),
            borderRadius: BorderRadius.circular(2),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF1E3822).withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
