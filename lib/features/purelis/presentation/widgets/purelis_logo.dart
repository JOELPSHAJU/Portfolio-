import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/purelis_colors.dart';

class PurelisLogo extends StatelessWidget {
  final VoidCallback? onTap;

  const PurelisLogo({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.eco_rounded,
                  size: 16,
                  color: PurelisColors.topBarGreen,
                ),
                const SizedBox(width: 6),
                Text(
                  'PURELIS',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4.5,
                    color: PurelisColors.textPrimary,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'SKINCARE',
                style: GoogleFonts.outfit(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3.5,
                  color: const Color(0xFF6E786E),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
