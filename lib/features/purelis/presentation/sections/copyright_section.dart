import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/purelis_colors.dart';

class CopyrightSection extends StatelessWidget {
  final bool isDesktop;

  const CopyrightSection({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PurelisColors.copyrightBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 14,
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '© 2025 Purelis Skincare. All Rights Reserved.',
                    style: GoogleFonts.outfit(
                      color: PurelisColors.copyrightText,
                      fontSize: 11.5,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    'Privacy Policy   |   Terms & Conditions   |   Shipping Policy   |   Contact Us',
                    style: GoogleFonts.outfit(
                      color: PurelisColors.copyrightText,
                      fontSize: 11.5,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  '© 2025 Purelis Skincare. All Rights Reserved.',
                  style: GoogleFonts.outfit(
                    color: PurelisColors.copyrightText,
                    fontSize: 11.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Privacy Policy | Terms & Conditions | Shipping Policy | Contact Us',
                  style: GoogleFonts.outfit(
                    color: PurelisColors.copyrightText,
                    fontSize: 10.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }
}
