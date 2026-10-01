import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Navigation link with smooth hover animations
class HoverableNavLink extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool hasDropdown;
  final VoidCallback onTap;

  const HoverableNavLink({
    super.key,
    required this.label,
    this.isSelected = false,
    this.hasDropdown = false,
    required this.onTap,
  });

  @override
  State<HoverableNavLink> createState() => _HoverableNavLinkState();
}

class _HoverableNavLinkState extends State<HoverableNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.outfit(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: (widget.isSelected || _isHovered)
                    ? const Color(0xFF1E3822)
                    : const Color(0xFF2A2A2A),
              ),
            ),
            if (widget.hasDropdown) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 15,
                color: (widget.isSelected || _isHovered)
                    ? const Color(0xFF1E3822)
                    : const Color(0xFF555555),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
