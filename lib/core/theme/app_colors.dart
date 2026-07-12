import 'package:flutter/material.dart';

/// Dual-palette token system — access via `context.palette`.
///
/// Fixed brand accents live in [BrandColors].
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

  // ── Light Mode: Carbon & Slate ─────────────────────────────────────────────
  static const light = AppPalette(
    textPrimary: Color(0xFF0F172A),       // Slate-900 (near-black warm ink)
    warmBrown: Color(0xFF334155),          // Slate-700 (warm charcoal body)
    card: Color(0xFFFFFFFF),              // white card
    surface: Color(0xFFF1F5F9),           // Slate-100 surface
    warmCream: Color(0xFFE2E8F0),         // Slate-200 container
    glassGradient: LinearGradient(
      colors: [Color(0xEEFFFFFF), Color(0xCCF8FAFC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    glassBorder: Color(0x18000000),       // subtle dark border
  );

  // ── Dark Mode: Carbon Slate ───────────────────────────────────────────────
  static const dark = AppPalette(
    textPrimary: Color(0xFFF8FAFC),       // Slate-50 off-white headings
    warmBrown: Color(0xFFCBD5E1),          // Slate-300 warm grey body
    card: Color(0xFF1E293B),              // Slate-800 dark card
    surface: Color(0xFF0B0F19),           // deep slate/black surface
    warmCream: Color(0xFF0F172A),         // Slate-900 container
    glassGradient: LinearGradient(
      colors: [Color(0x1AFFFFFF), Color(0x08FFFFFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    glassBorder: Color(0x1AFFFFFF),       // subtle white border
  );
}

/// `final pal = context.palette;`
extension AppPaletteContext on BuildContext {
  AppPalette get palette =>
      Theme.of(this).brightness == Brightness.dark
          ? AppPalette.dark
          : AppPalette.light;
}
