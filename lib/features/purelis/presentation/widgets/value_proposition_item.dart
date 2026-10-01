import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/value_proposition.dart';
import '../theme/purelis_colors.dart';
import '../utils/purelis_icon_utils.dart';

class ValuePropositionItem extends StatelessWidget {
  final ValueProposition item;

  const ValuePropositionItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          PurelisIconUtils.resolve(item.icon),
          size: 28,
          color: PurelisColors.iconGreen,
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.title,
                style: GoogleFonts.outfit(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: PurelisColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
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
