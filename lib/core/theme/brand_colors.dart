import 'package:flutter/material.dart';

class BrandColors {
  const BrandColors._();

  // ─────────────────────────────────────────────────────────
  // BACKGROUNDS
  // ─────────────────────────────────────────────────────────

  static const Color darkBackground = Color(0xFFFDFDFD);
  static const Color darkSurface = Color(0xFFF8F9FB);
  static const Color darkCard = Color(0xFFFFFFFF);

  // ─────────────────────────────────────────────────────────
  // PRIMARY BRAND COLORS
  // ─────────────────────────────────────────────────────────

  static const Color primaryNeon = Color(0xFF111827);
  static const Color secondaryNeon = Color(0xFF374151);
  static const Color accentNeon = Color(0xFF6366F1);

  static const Color successNeon = Color(0xFF10B981);
  static const Color warningNeon = Color(0xFFF59E0B);

  // ─────────────────────────────────────────────────────────
  // TEXT COLORS
  // ─────────────────────────────────────────────────────────

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);

  static const Color textDark = Color(0xFF020617);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ─────────────────────────────────────────────────────────
  // SURFACES
  // ─────────────────────────────────────────────────────────

  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderMuted = Color(0xFFF1F5F9);

  static const Color surfaceAlt = Color(0xFFF8FAFC);
  static const Color surfaceWarm = Color(0xFFFAFAFA);

  static const Color surfaceBlue = Color(0xFFF8FAFC);
  static const Color surfaceMint = Color(0xFFF8FAFC);
  static const Color surfaceSlate = Color(0xFFF1F5F9);

  // ─────────────────────────────────────────────────────────
  // PREMIUM SILVER PALETTE
  // ─────────────────────────────────────────────────────────

  static const Color warmBlack = Color(0xFF111827);
  static const Color warmBrown = Color(0xFF374151);
  static const Color warmMid = Color(0xFF64748B);
  static const Color warmAccent = Color(0xFF8B5CF6);

  static const Color warmLight = Color(0xFFCBD5E1);
  static const Color warmGold = Color(0xFFE5E7EB);
  static const Color warmAmber = Color(0xFFF3F4F6);

  static const Color warmPale = Color(0xFFF8FAFC);
  static const Color warmCream = Color(0xFFFAFAFA);
  static const Color warmPaper = Color(0xFFFCFCFC);

  static const Color warmWhite = Color(0xFFFFFFFF);
  static const Color warmFaint = Color(0xFFFDFDFD);

  // ─────────────────────────────────────────────────────────
  // HERO
  // ─────────────────────────────────────────────────────────

  static const Color heroBg1 = Color(0xFFFFFFFF);
  static const Color heroBg2 = Color(0xFFF8FAFC);

  static const Color heroGlowAmber = Color(0xFFE0E7FF);

  // ─────────────────────────────────────────────────────────
  // PROJECT COLORS
  // ─────────────────────────────────────────────────────────

  static const Color kahramaaDark = Color(0xFF0F172A);
  static const Color kahramaaMid = Color(0xFF334155);
  static const Color kahramaaLight = Color(0xFFCBD5E1);

  static const Color khadoomDark = Color(0xFF312E81);
  static const Color khadoomMid = Color(0xFF6366F1);
  static const Color khadoomLight = Color(0xFFC7D2FE);

  static const Color qswDark = Color(0xFF1E293B);
  static const Color qswMid = Color(0xFF475569);
  static const Color qswLight = Color(0xFFE2E8F0);

  static const Color museumDark = Color(0xFF14532D);
  static const Color museumMid = Color(0xFF22C55E);
  static const Color museumLight = Color(0xFFBBF7D0);

  // ─────────────────────────────────────────────────────────
  // STATUS
  // ─────────────────────────────────────────────────────────

  static const Color errorRed = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color orangeAccent = Color(0xFFF59E0B);
  static const Color orangeBright = Color(0xFFFBBF24);

  static const Color orangeFlame = Color(0xFFF59E0B);
  static const Color orangeNeon = Color(0xFFFCD34D);

  static const Color emeraldGreen = Color(0xFF10B981);

  static const Color linkBlue = Color(0xFF4F46E5);

  // ─────────────────────────────────────────────────────────
  // PREMIUM DEPTH
  // ─────────────────────────────────────────────────────────

  static const Color deepIndigoBlack = Color(0xFFF8FAFC);
  static const Color deepViolet = Color(0xFFF1F5F9);
  static const Color deepPurple = Color(0xFFE2E8F0);
  static const Color deepPurpleMid = Color(0xFFCBD5E1);
  static const Color deepPurpleCard = Color(0xFFFFFFFF);
  static const Color deepPurpleMuted = Color(0xFF94A3B8);

  // ─────────────────────────────────────────────────────────
  // GLASS
  // ─────────────────────────────────────────────────────────

  static const Color glassWhite = Color(0xFFFFFFFF);
  static const Color glassBorder = Color(0xFFE2E8F0);
  static const Color glassBlack = Color(0xCCFFFFFF);

  // ─────────────────────────────────────────────────────────
  // GRADIENTS
  // ─────────────────────────────────────────────────────────

  /// Dark navy → slate — primary CTA gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNeon, secondaryNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Indigo → violet — secondary accent gradient
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [linkBlue, accentNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// White → lavender — hero title gradient
  static const LinearGradient neonPinkGradient = LinearGradient(
    colors: [darkCard, heroGlowAmber],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Surface → border — subtle section divider gradient
  static const LinearGradient goldGradient = LinearGradient(
    colors: [surfaceAlt, borderLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Page background — top-to-bottom fade
  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [darkCard, darkSurface, darkCard],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Glass panel surface gradient
  static const LinearGradient glassGradient = LinearGradient(
    colors: [darkCard, surfaceAlt],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

