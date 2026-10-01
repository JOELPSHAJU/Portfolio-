import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class BookingInput extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final bool compact;
  final VoidCallback onTap;

  const BookingInput({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.compact = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 4 : 8, vertical: 4),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(compact ? 8 : 10),
              decoration: BoxDecoration(
                color: kGold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kGold.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: kGold, size: compact ? 16 : 20),
            ),
            SizedBox(width: compact ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.spaceMono(
                      color: kMuted,
                      fontSize: compact ? 9 : 10,
                      letterSpacing: compact ? 1.0 : 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: GoogleFonts.cinzel(
                      color: kIvory,
                      fontSize: compact ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      color: kGoldLight.withValues(alpha: 0.7),
                      fontSize: compact ? 10 : 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
