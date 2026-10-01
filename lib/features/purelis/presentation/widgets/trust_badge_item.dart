import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/trust_badge.dart';
import '../theme/purelis_colors.dart';
import '../utils/purelis_icon_utils.dart';

class TrustBadgeItem extends StatelessWidget {
  final TrustBadge badge;

  const TrustBadgeItem({
    super.key,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          PurelisIconUtils.resolve(badge.icon),
          size: 24,
          color: PurelisColors.iconGreen,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                badge.title,
                style: GoogleFonts.outfit(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: PurelisColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                badge.subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 12.0,
                  color: PurelisColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
