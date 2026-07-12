import 'package:flutter/material.dart';
import 'brand_colors.dart';

class AppTheme {
  const AppTheme._();

  // ── Light: Warm Editorial ─────────────────────────────────────────────────
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: BrandColors.lightBackground,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF0F172A),
        secondary: Color(0xFF475569),
        surface: BrandColors.lightCard,
        error: BrandColors.errorRed,
      ),
      cardTheme: CardThemeData(
        color: BrandColors.lightCard,
        elevation: 0,
        shadowColor: const Color(0x18000000),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: BrandColors.borderLight, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: BrandColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
        iconTheme: IconThemeData(color: BrandColors.textPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColors.primaryNeon,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: BrandColors.textPrimary,
          letterSpacing: -0.5,
          height: 1.15,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: BrandColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BrandColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: BrandColors.textSecondary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: BrandColors.textMuted,
          height: 1.5,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: BrandColors.borderLight,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BrandColors.lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: BrandColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: BrandColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0F172A), width: 1.5),
        ),
        hintStyle: const TextStyle(color: BrandColors.textMuted),
      ),
    );
  }

  // ── Dark: Warm Charcoal ───────────────────────────────────────────────────
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: BrandColors.darkBackground,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFF8FAFC),
        secondary: Color(0xFFCBD5E1),
        surface: BrandColors.darkSurface,
        error: BrandColors.errorRed,
      ),
      cardTheme: CardThemeData(
        color: BrandColors.darkCard,
        elevation: 0,
        shadowColor: const Color(0x22000000),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFF3A3530), width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: BrandColors.textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        iconTheme: IconThemeData(color: BrandColors.textDark),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: BrandColors.primaryNeon,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 48),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: BrandColors.textDark,
          letterSpacing: -0.5,
          height: 1.15,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: BrandColors.textDark,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: BrandColors.textDark,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: BrandColors.textOnDark,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: BrandColors.textMuted,
          height: 1.5,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF3A3530),
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: BrandColors.darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF3A3530)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF3A3530)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFF8FAFC), width: 1.5),
        ),
        hintStyle: const TextStyle(color: Color(0xFF78716C)),
      ),
    );
  }
}
