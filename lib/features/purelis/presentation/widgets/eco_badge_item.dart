import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/trust_badge.dart';
import '../utils/purelis_icon_utils.dart';

class EcoBadgeItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const EcoBadgeItem({
    super.key,
    required this.icon,
    required this.label,
  });

  factory EcoBadgeItem.fromEntity(EcoBadge badge) {
    return EcoBadgeItem(
      icon: PurelisIconUtils.resolve(badge.icon),
      label: badge.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF2E4631)),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334635),
          ),
        ),
      ],
    );
  }
}
