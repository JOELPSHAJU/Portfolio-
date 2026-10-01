import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/dining_venue.dart';
import '../theme/luxury_hotel_colors.dart';

class DiningCard extends StatelessWidget {
  final DiningVenue venue;
  final bool isDesktop;
  final void Function(String name) onReserveTable;

  const DiningCard({
    super.key,
    required this.venue,
    required this.isDesktop,
    required this.onReserveTable,
  });

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: kCardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: kGold.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  venue.stars,
                  style: GoogleFonts.spaceMono(
                    color: kGold,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                Text(
                  venue.hours,
                  style: GoogleFonts.outfit(
                    color: kMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              venue.name,
              style: GoogleFonts.cinzel(
                color: kIvory,
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${venue.chef} • ${venue.cuisine}',
              style: GoogleFonts.outfit(
                color: kGoldLight.withValues(alpha: 0.9),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              venue.highlight,
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            InkWell(
              onTap: () => onReserveTable(venue.name),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'RESERVE A TABLE',
                    style: GoogleFonts.cinzel(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward,
                    size: 14,
                    color: kGold,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kCardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGold.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            venue.stars,
            style: GoogleFonts.spaceMono(
              color: kGold,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            venue.name,
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            venue.highlight,
            style: GoogleFonts.outfit(
              color: kMuted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => onReserveTable(venue.name),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kGold),
              foregroundColor: kGold,
            ),
            child: const Text('RESERVE TABLE'),
          ),
        ],
      ),
    );
  }
}
