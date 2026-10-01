import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/spa_treatment.dart';
import '../theme/luxury_hotel_colors.dart';

class SpaCard extends StatelessWidget {
  final SpaTreatment treatment;
  final bool isDesktop;

  const SpaCard({
    super.key,
    required this.treatment,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDesktop
          ? (MediaQuery.of(context).size.width - 160) / 3
          : double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kCardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGold.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                treatment.time,
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                treatment.price,
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            treatment.title,
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            treatment.desc,
            style: GoogleFonts.outfit(
              color: kMuted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
