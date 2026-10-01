import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'purelis_colors.dart';

class PurelisTypography {
  PurelisTypography._();

  static TextStyle announcement({required bool isDesktop}) => GoogleFonts.outfit(
        color: Colors.white,
        fontSize: isDesktop ? 12.0 : 10.5,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
      );

  static TextStyle logoTitle = GoogleFonts.cormorantGaramond(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: 4.5,
    color: PurelisColors.textPrimary,
    height: 1.0,
  );

  static TextStyle logoSubtitle = GoogleFonts.outfit(
    fontSize: 8.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 3.5,
    color: const Color(0xFF6E786E),
    height: 1.0,
  );

  static TextStyle heroHeading({required bool isDesktop, Color? color}) =>
      GoogleFonts.cormorantGaramond(
        fontSize: isDesktop ? 46 : 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
        color: color ?? PurelisColors.textPrimary,
        height: 1.1,
      );

  static TextStyle heroSubtitle({required bool isDesktop}) => GoogleFonts.outfit(
        fontSize: isDesktop ? 15.5 : 14.0,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF3E4A3E),
        height: 1.55,
      );

  static TextStyle sectionTitle({required bool isDesktop}) =>
      GoogleFonts.cormorantGaramond(
        fontSize: isDesktop ? 28 : 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 3.5,
        color: PurelisColors.textPrimary,
      );

  static TextStyle promoHeadline = GoogleFonts.cormorantGaramond(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: PurelisColors.textPrimary,
    height: 1.1,
  );
}
