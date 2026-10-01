import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/concierge_privilege.dart';
import '../theme/luxury_hotel_colors.dart';

class ConciergeCard extends StatelessWidget {
  final ConciergePrivilege privilege;
  final bool isDesktop;
  final bool isTablet;

  const ConciergeCard({
    super.key,
    required this.privilege,
    required this.isDesktop,
    required this.isTablet,
  });

  IconData _resolveIcon(String iconName) {
    switch (iconName) {
      case 'airplanemode_active_rounded':
        return Icons.airplanemode_active_rounded;
      case 'directions_boat_rounded':
        return Icons.directions_boat_rounded;
      case 'directions_car_filled_rounded':
        return Icons.directions_car_filled_rounded;
      case 'wine_bar_rounded':
        return Icons.wine_bar_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDesktop
          ? (MediaQuery.of(context).size.width - 192) / 4
          : (isTablet
                ? (MediaQuery.of(context).size.width - 90) / 2
                : double.infinity),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: kCardDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kGold.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kGold.withValues(alpha: 0.3)),
            ),
            child: Icon(
              _resolveIcon(privilege.icon),
              color: kGold,
              size: 26,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            privilege.title,
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            privilege.desc,
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
