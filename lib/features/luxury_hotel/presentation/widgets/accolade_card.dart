import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/accolade.dart';
import '../theme/luxury_hotel_colors.dart';

class AccoladeCard extends StatelessWidget {
  final Accolade accolade;

  const AccoladeCard({super.key, required this.accolade});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          accolade.issuer,
          style: GoogleFonts.spaceMono(
            color: kMuted,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          accolade.grade,
          style: GoogleFonts.cinzel(
            color: kGold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          accolade.award,
          style: GoogleFonts.outfit(
            color: kIvory.withValues(alpha: 0.8),
            fontSize: 12,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
