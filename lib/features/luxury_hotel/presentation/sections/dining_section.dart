import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../domain/entities/dining_venue.dart';
import '../theme/luxury_hotel_assets.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/dining_card.dart';

class DiningSection extends StatelessWidget {
  final GlobalKey? diningKey;
  final bool isDesktop;
  final bool isTablet;
  final List<DiningVenue> venues;
  final void Function(String name) onReserveTable;

  const DiningSection({
    super.key,
    this.diningKey,
    required this.isDesktop,
    required this.isTablet,
    required this.venues,
    required this.onReserveTable,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 60,
    );

    return Container(
      key: diningKey,
      color: kCharcoal.withValues(alpha: 0.6),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: kGold),
              const SizedBox(width: 12),
              Text(
                'GASTRONOMY & SOMMELIER',
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
            'EPICUREAN HAUTE CUISINE',
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 38 : (isTablet ? 30 : 24),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              "Led by Master Chef Alexandre Valmont, our three Michelin-starred culinary venues marry rare wild Mediterranean catch with ancestral French techniques and an underground cellar of 18,000 vintage crus.",
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: 520,
                          width: double.infinity,
                          child: AppImage(
                            assetPath: LuxuryHotelAssets.diningMichelin,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  kObsidian.withValues(alpha: 0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 28,
                          left: 28,
                          right: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: kGold,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '3 MICHELIN STARS • CHEF ALEXANDRE VALMONT',
                                  style: GoogleFonts.cinzel(
                                    color: kObsidian,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "L'Étoile Céeste",
                                style: GoogleFonts.cinzel(
                                  color: kIvory,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Candlelit terraces hovering over the moonlit Mediterranean with sommelier flights and coastal caviar degustation.",
                                style: GoogleFonts.outfit(
                                  color: kIvory.withValues(alpha: 0.85),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: venues.map((v) {
                      return DiningCard(
                        venue: v,
                        isDesktop: true,
                        onReserveTable: onReserveTable,
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: AppImage(
                      assetPath: LuxuryHotelAssets.diningMichelin,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...venues.map((v) {
                  return DiningCard(
                    venue: v,
                    isDesktop: false,
                    onReserveTable: onReserveTable,
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }
}
