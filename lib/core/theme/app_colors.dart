import 'package:flutter/material.dart';

/// Dual-palette token system — access via `context.palette`.
///
/// Fixed brand accents (terracotta, sage, etc.) live in [BrandColors].
/// This class holds only tokens that differ between dark and light mode.
@immutable
class AppPalette {
  final Color textPrimary;
  final Color warmBrown;   // labels, secondary copy
  final Color card;
  final Color surface;
  final Color warmCream;   // subtle tile/container surface
  final LinearGradient glassGradient;
  final Color glassBorder;

  const AppPalette({
    required this.textPrimary,
    required this.warmBrown,
    required this.card,
    required this.surface,
    required this.warmCream,
    required this.glassGradient,
    required this.glassBorder,
  });

  // ── Dark Mode: Mono Charcoal ─────────────────────────────────────────────
  static const dark = AppPalette(
    textPrimary: Color(0xFFFFFFFF),       // pure white headings
    warmBrown: Color(0xFFA1A1A1),          // light grey body
    card: Color(0xFF1C1C1C),              // charcoal card
    surface: Color(0xFF141414),           // content surface
    warmCream: Color(0xFF242424),         // elevated container
    glassGradient: LinearGradient(
      colors: [Color(0x14FFFFFF), Color(0x05FFFFFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    glassBorder: Color(0x14FFFFFF),
  );

  // ── Light Mode: Mono Paper ───────────────────────────────────────────────
  static const light = AppPalette(
    textPrimary: Color(0xFF0A0A0A),       // near-black ink
    warmBrown: Color(0xFF5C5C5C),          // mid grey
    card: Color(0xFFFFFFFF),              // white card
    surface: Color(0xFFF2F2F2),           // section surface
    warmCream: Color(0xFFEBEBEB),         // subtle container / divider
    glassGradient: LinearGradient(
      colors: [Color(0xFFFFFFFF), Color(0xFFF2F2F2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    glassBorder: Color(0x14FFFFFF),       // subtle lime border
  );
}

/// `final pal = context.palette;`
extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).brightness == Brightness.dark
          ? AppPalette.dark
          : AppPalette.light;
}
