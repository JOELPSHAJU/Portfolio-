import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class HeroStageOne extends StatelessWidget {
  final bool isDesktop;
  final double opacity;

  const HeroStageOne({
    super.key,
    required this.isDesktop,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isDesktop ? 96 : 64,
      left: isDesktop ? 64 : 20,
      right: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 740 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kGold, width: 1.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: kGold, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          isDesktop
                              ? 'FORBES 5-STAR WORLD RESORT • EST. 1928'
                              : 'FORBES 5-STAR RESORT • EST. 1928',
                          style: GoogleFonts.spaceMono(
                            color: kGold,
                            fontSize: isDesktop ? 10 : 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: isDesktop ? 2.2 : 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'THE LUMINA\nPALACE',
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 76 : 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  height: 1.04,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 36,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'FRENCH RIVIERA PRIVATE SANCTUARY',
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 16 : 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Where Mediterranean heritage meets azure immensity. Sculpted into the limestone promontory of Côte d\'Azur with 98 cliffside infinity suites, three-star Michelin dining, and subterranean thalasso grottos.',
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.92),
                  fontSize: isDesktop ? 16 : 13,
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Text(
                  '43°42\'12"N • 7°25\'08"E | CAP-FERRAT • PRIVATE HELIPAD & MARINA',
                  style: GoogleFonts.spaceMono(
                    color: kIvory.withValues(alpha: 0.75),
                    fontSize: isDesktop ? 10 : 8.5,
                    letterSpacing: isDesktop ? 1.8 : 1.0,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
