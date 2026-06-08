import 'package:flutter/material.dart';

/// App theme color constants representing a professional, clean, Vercel/Linear dark slate theme.
class BrandColors {
  const BrandColors._();

  // Dark Theme Base Colors
  static const Color darkBackground = Color(0xFF0A0F18); // Cool Slate Blue-Gray
  static const Color darkSurface = Color(0xFF121B26);    // Cool Arctic Charcoal
  static const Color darkCard = Color(0xFF182535);       // Muted Arctic Blue Card

  // Premium Cooler Glacial Accents (Green, Blue, White, Grey)
  static const Color primaryNeon = Color(0xFF10B981);    // Emerald Mint Green
  static const Color secondaryNeon = Color(0xFF06B6D4);  // Cyan Ice Blue
  static const Color accentNeon = Color(0xFF94A3B8);     // Cool Platinum Slate Grey
  static const Color successNeon = Color(0xFF34D399);    // Soft Mint
  static const Color warningNeon = Color(0xFFFBBF24);    // Muted Gold

  // Glassmorphic Overlays (with translucency)
  static const Color glassWhite = Color(0x02FFFFFF);     // White with 2% opacity
  static const Color glassBorder = Color(0x14FFFFFF);    // White with 8% opacity
  static const Color glassBlack = Color(0xD90A0F18);     // Cool Slate Blue-Gray with 85% opacity

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNeon, Color(0xFF06B6D4)], // Green to Blue
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [secondaryNeon, Color(0xFF94A3B8)], // Blue to Grey
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonPinkGradient = LinearGradient(
    colors: [Colors.white, Color(0xFF94A3B8)], // White to Grey
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [primaryNeon, Color(0xFF06B6D4)], // Green to Blue
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cosmicGradient = LinearGradient(
    colors: [
      Color(0xFF0A0F18),
      Color(0xFF121B26),
      Color(0xFF0A0F18),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0xF2121B26), // 95% opacity Slate Navy
      Color(0xFA0A0F18), // 98% opacity Dark Charcoal
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
