import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../domain/entities/spa_treatment.dart';
import '../theme/luxury_hotel_assets.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/spa_card.dart';

class SpaSection extends StatelessWidget {
  final GlobalKey? spaKey;
  final bool isDesktop;
  final bool isTablet;
  final List<SpaTreatment> treatments;
  final VoidCallback onOpenSpaMenu;

  const SpaSection({
    super.key,
    this.spaKey,
    required this.isDesktop,
    required this.isTablet,
    required this.treatments,
    required this.onOpenSpaMenu,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 60,
    );

    return Container(
      key: spaKey,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: kGold),
              const SizedBox(width: 12),
              Text(
                'WELLNESS & CELLULAR THERAPY',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'THE SOMA THALASSO SANCTUARY',
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 38 : (isTablet ? 30 : 24),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Descend into 4,000 m² of natural subterranean limestone grottoes. Featuring geothermal mineral lagoons, Swiss anti-aging cellular rituals, and pure sensory deprivation sanctuaries.',
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                SizedBox(
                  height: isDesktop ? 480 : (isTablet ? 400 : 390),
                  width: double.infinity,
                  child: const AppImage(
                    assetPath: LuxuryHotelAssets.spaWellness,
                    fit: BoxFit.cover,
                  ),
                ),
                // Dual-side horizontal fade blending both left and right edges into the background
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          kObsidian,
                          kObsidian.withValues(alpha: 0.95),
                          kObsidian.withValues(alpha: 0.70),
                          kObsidian.withValues(alpha: 0.15),
                          Colors.transparent,
                          Colors.transparent,
                          kObsidian.withValues(alpha: 0.20),
                          kObsidian.withValues(alpha: 0.75),
                          kObsidian.withValues(alpha: 0.95),
                          kObsidian,
                        ],
                        stops: const [
                          0.0,
                          0.08,
                          0.22,
                          0.38,
                          0.48,
                          0.60,
                          0.72,
                          0.85,
                          0.94,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ),
                // Subtle vertical top and bottom vignette blend
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kObsidian.withValues(alpha: 0.5),
                          Colors.transparent,
                          Colors.transparent,
                          kObsidian.withValues(alpha: 0.65),
                        ],
                        stops: const [0.0, 0.18, 0.82, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: isDesktop ? 40 : 20,
                  right: isDesktop ? null : 20,
                  top: isDesktop ? 40 : 24,
                  bottom: isDesktop ? 40 : null,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 480 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kGold.withValues(alpha: 0.2),
                            border: Border.all(color: kGold),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isDesktop
                                ? 'SUBTERRANEAN HYDROTHERMAL GROTTO'
                                : 'HYDROTHERMAL GROTTO',
                            style: GoogleFonts.spaceMono(
                              color: kGold,
                              fontSize: isDesktop ? 10 : 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: isDesktop ? 1.5 : 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Natural Limestone Salt Cave Thermal Circuit',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: isDesktop ? 28 : 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Filtered seawater drawn directly from 80 meters deep, enriched with marine magnesium and ionized sea salts at 38°C.',
                          style: GoogleFonts.outfit(
                            color: kIvory.withValues(alpha: 0.8),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: onOpenSpaMenu,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGold,
                            foregroundColor: kObsidian,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'VIEW RITUALS & RESERVE',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: treatments.map((t) {
              return SpaCard(
                treatment: t,
                isDesktop: isDesktop,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
