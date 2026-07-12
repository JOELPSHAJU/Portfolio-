import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// SLATE & MONOCHROME — Portfolio Design System v3 (Achromatic Theme)
///
/// Concept: Pure monochromatic palette using white, grey, and black tones.
/// High contrast, crisp borders, and premium typography that feels like
/// a state-of-the-art software product.
/// ═══════════════════════════════════════════════════════════════════════════
class BrandColors {
  const BrandColors._();

  // ─── LIGHT BACKGROUND DEPTH SCALE ─────────────────────────────────────────

  /// Page canvas — slate off-white
  static const Color lightBackground = Color(0xFFF8FAFC);

  /// Slight depth — section alternating background
  static const Color lightSurface = Color(0xFFF1F5F9);

  /// Card/panel background
  static const Color lightCard = Color(0xFFFFFFFF);

  /// Elevated container
  static const Color lightElevated = Color(0xFFE2E8F0);

  // ─── DARK/CONTRAST COUNTERPARTS ───────────────────────────────────────────
  static const Color darkBackground = Color(0xFF030712);
  static const Color darkSurface = Color(0xFF0B0F19);
  static const Color darkCard = Color(0xFF1E293B);

  // ─── PRIMARY ACCENTS ──────────────────────────────────────────────────────

  /// Primary — Slate-700 / dark charcoal
  static const Color primaryNeon = Color(0xFF334155);

  /// Secondary — Slate-500 / medium grey
  static const Color secondaryNeon = Color(0xFF64748B);

  /// Tertiary — Slate-400 / cool grey
  static const Color accentNeon = Color(0xFF94A3B8);

  /// Success — Slate-600 / dark grey
  static const Color successNeon = Color(0xFF475569);

  /// Warning — Slate-300 / light grey
  static const Color warningNeon = Color(0xFFCBD5E1);

  // ─── TYPOGRAPHY ──────────────────────────────────────────────────────────

  /// Primary heading/display — Slate-900
  static const Color textPrimary = Color(0xFF0F172A);

  /// Secondary body — Slate-700
  static const Color textSecondary = Color(0xFF334155);

  /// Muted / placeholders — Slate-500
  static const Color textMuted = Color(0xFF64748B);

  /// Heading on dark surfaces
  static const Color textDark = Color(0xFFF8FAFC);

  /// Body on dark surfaces
  static const Color textOnDark = Color(0xFFCBD5E1);

  // ─── SURFACES & BORDERS ──────────────────────────────────────────────────

  /// Border on light surfaces — Slate-200
  static const Color borderLight = Color(0xFFE2E8F0);

  /// Subtle card border — Slate-300
  static const Color borderMuted = Color(0xFFCBD5E1);

  /// Alt light surface
  static const Color surfaceAlt = Color(0xFFF8FAFC);

  /// Warm beige surface (fallback / secondary tag)
  static const Color surfaceWarm = Color(0xFFF1F5F9);

  /// Cool sky surface
  static const Color surfaceBlue = Color(0xFFF8FAFC);

  static const Color glowGreen = Color.fromARGB(255, 64, 147, 67);

  /// Neutral light surface
  static const Color surfaceMint = Color(0xFFF1F5F9);

  /// Cool slate surface
  static const Color surfaceSlate = Color(0xFFF1F5F9);

  // ─── UTILITY PALETTE ─────────────────────────────────────────────────────

  static const Color warmBlack = Color(0xFF0F172A);
  static const Color warmBrown = Color(0xFF334155);
  static const Color warmMid = Color(0xFFF1F5F9);
  static const Color warmAccent = Color(0xFF475569);

  static const Color warmLight = Color(0xFFCBD5E1);
  static const Color warmGold = Color(0xFFE2E8F0);
  static const Color warmAmber = Color(0xFF64748B);

  static const Color warmPale = Color(0xFFF8FAFC);
  static const Color warmCream = Color(0xFFF1F5F9);
  static const Color warmPaper = Color(0xFFF8FAFC);
  static const Color warmWhite = Color(0xFFFFFFFF);
  static const Color warmFaint = Color(0xFF64748B);

  // ─── HERO SECTION ────────────────────────────────────────────────────────

  static const Color heroBg1 = Color(0xFFF8FAFC);
  static const Color heroBg2 = Color(0xFFF1F5F9);

  /// Grey glow behind portrait
  static const Color heroGlowAmber = Color(0xFFE2E8F0);

  // ─── PROJECT ACCENT PALETTES (Monochromatic slate/grey/black tones) ───────

  // Kahramaa — Slate Black / Medium Grey
  static const Color kahramaaDark = Color(0xFF0F172A);
  static const Color kahramaaMid = Color(0xFF475569);
  static const Color kahramaaLight = Color(0xFFE2E8F0);

  // Khadoom — Dark Grey / Cool Grey
  static const Color khadoomDark = Color(0xFF1E293B);
  static const Color khadoomMid = Color(0xFF64748B);
  static const Color khadoomLight = Color(0xFFCBD5E1);

  // QSW — Slate Grey / Off White
  static const Color qswDark = Color(0xFF0F172A);
  static const Color qswMid = Color(0xFF334155);
  static const Color qswLight = Color(0xFFF8FAFC);

  // Qatar Museums — Steel Grey
  static const Color museumDark = Color(0xFF1E293B);
  static const Color museumMid = Color(0xFF475569);
  static const Color museumLight = Color(0xFFE2E8F0);

  // ─── STATUS / SEMANTIC ───────────────────────────────────────────────────

  static const Color errorRed = Color(0xFF475569);
  static const Color errorDark = Color(0xFF0F172A);

  static const Color orangeAccent = Color(0xFF475569);
  static const Color orangeBright = Color(0xFF64748B);
  static const Color orangeFlame = Color(0xFF334155);
  static const Color orangeNeon = Color(0xFFE2E8F0);

  static const Color emeraldGreen = Color(0xFF475569);
  static const Color linkBlue = Color(0xFF64748B);

  // ─── DEPTH SCALE ─────────────────────────────────────────────────────────

  static const Color deepIndigoBlack = Color(0xFF030712);
  static const Color deepViolet = Color(0xFF0B0F19);
  static const Color deepPurple = Color(0xFF1E293B);
  static const Color deepPurpleMid = Color(0xFFE2E8F0);
  static const Color deepPurpleCard = Color(0xFFFFFFFF);
  static const Color deepPurpleMuted = Color(0xFF64748B);

  // ─── GLASSMORPHISM ───────────────────────────────────────────────────────

  /// Card glass fill — white semi-transparent
  static const Color glassWhite = Color(0xCCFFFFFF);

  /// Glass border — subtle slate tint
  static const Color glassBorder = Color(0x1A94A3B8);

  /// Heavy dark overlay
  static const Color glassBlack = Color(0xCC030712);

  // ─── SIGNATURE GRADIENTS ─────────────────────────────────────────────────

  /// Dark slate to light grey
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNeon, accentNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Medium grey to dark grey
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [secondaryNeon, primaryNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Light grey to cool grey
  static const LinearGradient neonPinkGradient = LinearGradient(
    colors: [accentNeon, secondaryNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Cream → Warm beige — card backgrounds
  static const LinearGradient goldGradient = LinearGradient(
    colors: [lightCard, lightSurface],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Page wash — slate ramp
  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [lightBackground, lightSurface, lightBackground],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Frosted panel — white glass
  static const LinearGradient glassGradient = LinearGradient(
    colors: [glassWhite, Color(0xAAFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ─── EXTENDED GRADIENTS ──────────────────────────────────────────────────

  /// Sweep from dark slate to light slate grey
  static const LinearGradient prismaticGradient = LinearGradient(
    colors: [primaryNeon, secondaryNeon, accentNeon],
    stops: [0.0, 0.50, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Subtle card shimmer
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [lightCard, lightSurface, lightElevated],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
