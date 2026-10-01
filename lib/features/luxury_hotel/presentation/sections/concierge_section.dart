import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/concierge_privilege.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/concierge_card.dart';

class ConciergeSection extends StatelessWidget {
  final GlobalKey? conciergeKey;
  final bool isDesktop;
  final bool isTablet;
  final List<ConciergePrivilege> privileges;

  const ConciergeSection({
    super.key,
    this.conciergeKey,
    required this.isDesktop,
    required this.isTablet,
    required this.privileges,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 60,
    );

    return Container(
      key: conciergeKey,
      color: kCharcoal.withValues(alpha: 0.4),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: kGold),
              const SizedBox(width: 12),
              Text(
                'WHITE-GLOVE PRIVILEGES',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'BESPOKE CONCIERGE & FLEET',
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 38 : (isTablet ? 30 : 24),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              'No bespoke request is unattainable. Our certified Les Clefs d’Or royal concierge guild curates unforgettable air, land, and sea transitions for all resident patrons.',
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),

          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: privileges.map((p) {
              return ConciergeCard(
                privilege: p,
                isDesktop: isDesktop,
                isTablet: isTablet,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
