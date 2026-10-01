import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Right-side fleet feature badge item
class FleetFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FleetFeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5A93B), width: 1.5),
            color: Colors.black.withValues(alpha: 0.35),
          ),
          child: Icon(icon, color: const Color(0xFFE5A93B), size: 20),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF94A3B8),
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
