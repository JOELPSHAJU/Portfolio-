import 'package:flutter/material.dart';

/// ═════════════════════════════════════════════════════════════════════════════
/// OBSIDIAN PRISM — Enterprise Portfolio Design System
///
/// Inspired by: Linear, Figma, Raycast, Resend — the pinnacle of dark SaaS UI.
///
/// DARK  : Deep indigo-black canvas with violet-to-blue prismatic gradients.
///         Cards are raised obsidian panes; borders emit a faint violet aura.
///         Glows, halos, and micro-gradients carry all the visual energy.
///
/// LIGHT : Crisp white with a cool indigo tint — clean, confident, corporate.
///         Accent violet gives hierarchy without aggression.
///
/// Accent stack (violet → indigo → cyan): the tri-tone gradient is the
/// signature. Use individually for hierarchy or as a sweep for hero moments.
/// ═════════════════════════════════════════════════════════════════════════════
class BrandColors {
  const BrandColors._();

  // ───────────────────────────────────────────────────────────────────────────
  // DARK BACKGROUND DEPTH SCALE
  // ───────────────────────────────────────────────────────────────────────────

  /// Deepest layer — near-black with indigo undertone
  static const Color darkBackground = Color(0xFF06060F);

  /// Raised content layer
  static const Color darkSurface = Color(0xFF0B0B1A);

  /// Card / panel — obsidian glass
  static const Color darkCard = Color(0xFF10101E);

  // ───────────────────────────────────────────────────────────────────────────
  // PRISMATIC ACCENT STACK — violet → indigo → cyan
  // ───────────────────────────────────────────────────────────────────────────

  /// Signature violet — primary CTAs, active rings, hero titles
  static const Color primaryNeon = Color(0xFF7C3AED);

  /// Indigo — secondary hierarchy, underlines, tag fills
  static const Color secondaryNeon = Color(0xFF4F46E5);

  /// Electric cyan — tertiary pop, glow halos, dividers
  static const Color accentNeon = Color(0xFF06B6D4);

  /// Violet tint — success / confirm (keeps palette clean)
  static const Color successNeon = Color(0xFF8B5CF6);

  /// Amber — warnings only, maximum contrast on dark
  static const Color warningNeon = Color(0xFFF59E0B);

  // ───────────────────────────────────────────────────────────────────────────
  // TYPOGRAPHY
  // ───────────────────────────────────────────────────────────────────────────

  /// Primary text on light surfaces — near-black indigo ink
  static const Color textPrimary = Color(0xFF1E1B4B);

  /// Secondary / body — slate blue-grey
  static const Color textSecondary = Color(0xFF4B5563);

  /// Muted / placeholders — cool slate
  static const Color textMuted = Color(0xFF9CA3AF);

  /// Heading / display on dark surfaces — pure near-white
  static const Color textDark = Color(0xFFF5F3FF);

  /// Body copy on dark — silver blue-white
  static const Color textOnDark = Color(0xFFD1D5DB);

  // ───────────────────────────────────────────────────────────────────────────
  // SURFACES & BORDERS
  // ───────────────────────────────────────────────────────────────────────────

  /// Border on light surfaces
  static const Color borderLight = Color(0xFFE5E7EB);

  /// Subtle card border — faint violet aura
  static const Color borderMuted = Color(0x22A78BFA);

  /// Light app background — barely-there violet wash
  static const Color surfaceAlt  = Color(0xFFF9F8FF);

  /// Blue-tinted light surface
  static const Color surfaceWarm  = Color(0xFFF0EBFF);

  /// Sky / cool light surface
  static const Color surfaceBlue  = Color(0xFFEFF6FF);

  /// Neutral light surface
  static const Color surfaceMint  = Color(0xFFF8FAFC);

  /// Cool slate light surface
  static const Color surfaceSlate = Color(0xFFF1F5F9);

  // ───────────────────────────────────────────────────────────────────────────
  // UTILITY PALETTE — mapped to the prism stack
  // ───────────────────────────────────────────────────────────────────────────

  static const Color warmBlack  = Color(0xFF1E1B4B);   // indigo-black ink
  static const Color warmBrown  = Color(0xFF6B7280);   // cool grey
  static const Color warmMid    = Color(0xFF1C1C3A);   // deep panel fill
  static const Color warmAccent = Color(0xFF7C3AED);   // violet accent

  static const Color warmLight  = Color(0xFFC4B5FD);   // light violet
  static const Color warmGold   = Color(0xFF1A1A3E);   // dark elevated surface
  static const Color warmAmber  = Color(0xFF312E81);   // deep indigo panel

  static const Color warmPale   = Color(0xFFEDE9FE);   // pale violet tint
  static const Color warmCream  = Color(0xFF1C1C38);   // dark card
  static const Color warmPaper  = Color(0xFF0B0B1A);   // deep surface
  static const Color warmWhite  = Color(0xFF111127);   // darkest layer token
  static const Color warmFaint  = Color(0xFF06060F);   // near-black fill

  // ───────────────────────────────────────────────────────────────────────────
  // HERO SECTION
  // ───────────────────────────────────────────────────────────────────────────

  static const Color heroBg1       = Color(0xFF06060F);   // near-black
  static const Color heroBg2       = Color(0xFF0E0E24);   // indigo-black

  /// Violet-indigo halo behind portrait
  static const Color heroGlowAmber = Color(0xFF4C1D95);

  // ───────────────────────────────────────────────────────────────────────────
  // PROJECT ACCENT PALETTES — unique identity per project
  // ───────────────────────────────────────────────────────────────────────────

  // Kahramaa — teal-cyan industrial palette
  static const Color kahramaaDark  = Color(0xFF0C1A2E);
  static const Color kahramaaMid   = Color(0xFF0E7490);
  static const Color kahramaaLight = Color(0xFF67E8F9);

  // Khadoom — violet enterprise palette
  static const Color khadoomDark   = Color(0xFF1E1B4B);
  static const Color khadoomMid    = Color(0xFF6D28D9);
  static const Color khadoomLight  = Color(0xFFC4B5FD);

  // QSW — rose-magenta palette (unique, bold)
  static const Color qswDark  = Color(0xFF4C0519);
  static const Color qswMid   = Color(0xFFBE185D);
  static const Color qswLight = Color(0xFFFDA4AF);

  // Qatar Museums — amber-gold enterprise palette (was green)
  static const Color museumDark  = Color(0xFF451A03);
  static const Color museumMid   = Color(0xFFD97706);
  static const Color museumLight = Color(0xFFFDE68A);

  // ───────────────────────────────────────────────────────────────────────────
  // STATUS / SEMANTIC
  // ───────────────────────────────────────────────────────────────────────────

  static const Color errorRed  = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color orangeAccent = Color(0xFFF59E0B);   // amber
  static const Color orangeBright = Color(0xFFFBBF24);   // lighter amber
  static const Color orangeFlame  = Color(0xFFF97316);   // orange
  static const Color orangeNeon   = Color(0xFFFED7AA);   // pale orange

  static const Color emeraldGreen = Color(0xFF8B5CF6);   // remapped → violet
  static const Color linkBlue     = Color(0xFF38BDF8);   // sky blue link

  // ───────────────────────────────────────────────────────────────────────────
  // DEPTH SCALE — indigo-black
  // ───────────────────────────────────────────────────────────────────────────

  static const Color deepIndigoBlack = Color(0xFF06060F);
  static const Color deepViolet      = Color(0xFF0B0B1A);
  static const Color deepPurple      = Color(0xFF10101E);
  static const Color deepPurpleMid   = Color(0xFF1C1C3A);
  static const Color deepPurpleCard  = Color(0xFF1A1A38);
  static const Color deepPurpleMuted = Color(0xFF4B5563);

  // ───────────────────────────────────────────────────────────────────────────
  // GLASSMORPHISM
  // ───────────────────────────────────────────────────────────────────────────

  /// Card glass fill — ultra-thin white
  static const Color glassWhite  = Color(0x0CFFFFFF);

  /// Glass border — violet aura at 12% opacity
  static const Color glassBorder = Color(0x1FA78BFA);

  /// Heavy dark overlay
  static const Color glassBlack  = Color(0xE006060F);

  // ───────────────────────────────────────────────────────────────────────────
  // SIGNATURE GRADIENTS
  // ───────────────────────────────────────────────────────────────────────────

  /// Violet → Indigo — primary CTA, hero name, logo badge
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNeon, secondaryNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Indigo → Cyan — nav active states, section accents
  static const LinearGradient cyanGradient = LinearGradient(
    colors: [secondaryNeon, accentNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Violet → Cyan — hero JOEL text, full-sweep prismatic
  static const LinearGradient neonPinkGradient = LinearGradient(
    colors: [primaryNeon, accentNeon],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Deep navy → violet panel — card backgrounds, section fills
  static const LinearGradient goldGradient = LinearGradient(
    colors: [darkCard, deepPurpleMid],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Page wash — indigo-black depth ramp
  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [darkCard, darkSurface, darkCard],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Frosted panel glass gradient — top to bottom
  static const LinearGradient glassGradient = LinearGradient(
    colors: [glassWhite, Color(0x04FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ───────────────────────────────────────────────────────────────────────────
  // EXTENDED GRADIENTS (for hero & section moments)
  // ───────────────────────────────────────────────────────────────────────────

  /// Violet → Indigo → Cyan — full spectrum hero sweep
  static const LinearGradient prismaticGradient = LinearGradient(
    colors: [primaryNeon, secondaryNeon, accentNeon],
    stops: [0.0, 0.55, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Subtle dark card shimmer — for elevated cards on hover
  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [deepPurple, deepPurpleCard, deepPurpleMid],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
