import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class SectionHeading extends StatelessWidget {
  final String tag;
  final String title;
  final String? description;
  final double lineWidth;
  final bool isDesktop;
  final bool isTablet;

  const SectionHeading({
    super.key,
    required this.tag,
    required this.title,
    this.description,
    this.lineWidth = 28,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: lineWidth, height: 2, color: kGold),
            const SizedBox(width: 10),
            Text(
              tag,
              style: GoogleFonts.spaceMono(
                color: kGold,
                fontSize: 11,
                letterSpacing: 3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.cinzel(
            color: kIvory,
            fontSize: isDesktop ? 34 : (isTablet ? 28 : 22),
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              description!,
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
