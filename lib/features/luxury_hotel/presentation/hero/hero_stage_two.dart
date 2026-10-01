import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/stat_glass_card.dart';

class HeroStageTwo extends StatelessWidget {
  final bool isDesktop;
  final double opacity;

  const HeroStageTwo({
    super.key,
    required this.isDesktop,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: isDesktop ? 96 : 64,
      right: isDesktop ? 64 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 620 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDesktop) ...[
                    Container(width: 24, height: 2, color: kGold),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '01 / MONUMENTAL CRAFT',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 8),
                    Container(width: 24, height: 2, color: kGold),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'SCULPTED INTO\nLIVING CLIFFS',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 54 : 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  height: 1.08,
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
                'A BOUNDLESS HORIZON OF LIMESTONE & AZURE',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 14 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'A secluded Mediterranean promontory designed for total privacy. Every suite, terrace, and infinity horizon plunge is cantilevered toward the boundless azure.',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.88),
                  fontSize: isDesktop ? 15 : 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: isDesktop ? WrapAlignment.end : WrapAlignment.start,
                children: const [
                  StatGlassCard(
                    number: '98',
                    title: 'INFINITY POOLS',
                    subtitle: 'Private cliffside plunges',
                  ),
                  StatGlassCard(
                    number: '360°',
                    title: 'OCEAN PANORAMA',
                    subtitle: 'Uninterrupted azure views',
                  ),
                  StatGlassCard(
                    number: '100%',
                    title: 'SECLUDED PRIVACY',
                    subtitle: 'Direct helipad & marina',
                  ),
                  StatGlassCard(
                    number: '24/7',
                    title: 'BUTLER GUILD',
                    subtitle: 'Certified white-glove service',
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
