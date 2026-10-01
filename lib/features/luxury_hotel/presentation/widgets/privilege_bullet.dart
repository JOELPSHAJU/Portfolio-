import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class PrivilegeBullet extends StatelessWidget {
  final String text;

  const PrivilegeBullet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: kGold,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.outfit(color: kIvory, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
