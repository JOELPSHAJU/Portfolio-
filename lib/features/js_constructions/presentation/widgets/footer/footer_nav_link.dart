import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Interactive quick link in the footer with smooth hover transition
class FooterNavLink extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const FooterNavLink({super.key, required this.label, this.onTap});

  @override
  State<FooterNavLink> createState() => _FooterNavLinkState();
}

class _FooterNavLinkState extends State<FooterNavLink> {
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
          transform: Matrix4.translationValues(_isHovered ? 3 : 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.plusJakartaSans(
                  color: _isHovered
                      ? const Color(0xFFFF9F1C)
                      : const Color(0xFFE2E8F0),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: _isHovered
                    ? const Color(0xFFFF9F1C)
                    : const Color(0xFF64748B),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
