import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/stat_glass_card.dart';

class HeroStageThree extends StatelessWidget {
  final bool isDesktop;
  final double opacity;

  const HeroStageThree({
    super.key,
    required this.isDesktop,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: isDesktop ? 70 : 40,
      left: isDesktop ? 64 : 20,
      right: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 680 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 24, height: 2, color: kGold),
                  const SizedBox(width: 8),
                  Text(
                    '02 / SENSORY MASTERY',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'SUBTERRANEAN THALASSO\n& 3-STAR GASTRONOMY',
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 46 : 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'HEALING THERMAL CAVERNS & HAUTE ALCHEMY',
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 14 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Immerse in mineral seawater thermal grottoes deep within natural limestone rock caverns. Ascend at dusk to Michelin-starred feasts and an eighteen-thousand-bottle private sommelier cellar.',
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.88),
                  fontSize: isDesktop ? 15 : 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              const Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  StatGlassCard(
                    number: '3 ★',
                    title: 'MICHELIN GUIDED',
                    subtitle: 'Haute coastal alchemy',
                  ),
                  StatGlassCard(
                    number: '18K',
                    title: 'VINTAGE CELLAR',
                    subtitle: 'Two centuries of rare vintages',
                  ),
                  StatGlassCard(
                    number: '4,000 m²',
                    title: 'THALASSO GROTTO',
                    subtitle: 'Deep mineral rejuvenation',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
