import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Interactive "OUR SERVICES →" Button with Amber Glow & Micro-animation
class AboutServicesButton extends StatefulWidget {
  final VoidCallback onTap;
  const AboutServicesButton({super.key, required this.onTap});

  @override
  State<AboutServicesButton> createState() => _AboutServicesButtonState();
}

class _AboutServicesButtonState extends State<AboutServicesButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFDF9B35);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? goldColor.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _isHovered ? goldColor : goldColor.withValues(alpha: 0.85),
              width: 1.4,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: goldColor.withValues(alpha: 0.25),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'OUR SERVICES',
                style: GoogleFonts.outfit(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  color: goldColor,
                ),
              ),
              const SizedBox(width: 14),
              AnimatedSlide(
                duration: const Duration(milliseconds: 220),
                offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: goldColor,
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
