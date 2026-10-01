import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/autovista_coupon_entity.dart';
import '../../../domain/entities/autovista_deal_entity.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_deal_car_card.dart';
import '../../widgets/autovista_screen_header_banner.dart';

class AutovistaDealsScreen extends StatelessWidget {
  final bool isDesktop;
  final List<AutovistaDealEntity> dealsCars;
  final List<AutovistaCouponEntity> coupons;

  const AutovistaDealsScreen({
    super.key,
    required this.isDesktop,
    required this.dealsCars,
    required this.coupons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutovistaScreenHeaderBanner(
          tag: 'SPECIAL OFFERS & PROMOTIONS',
          title: 'EXCLUSIVE RENTAL DEALS',
          subtitle:
              'Unlock handpicked luxury driving experiences at premier seasonal rates. Includes complimentary insurance upgrades and door-to-door delivery.',
          isDesktop: isDesktop,
        ),

        // Deals Grid
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured Limited-Time Specials',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 18),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isDesktop
                      ? (constraints.maxWidth - 3 * 16) / 4
                      : constraints.maxWidth > 650
                          ? (constraints.maxWidth - 16) / 2
                          : constraints.maxWidth;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: dealsCars.map((deal) {
                      return SizedBox(
                        width: cardWidth,
                        child: AutovistaDealCarCard(deal: deal),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),

        // Limited Time Promo Codes Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Privilege Promo Codes',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isDesktop
                      ? (constraints.maxWidth - 2 * 16) / 3
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: coupons.map((c) {
                      return SizedBox(
                        width: cardWidth,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AutovistaColors.primaryRed
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      c.discount,
                                      style: GoogleFonts.spaceMono(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: AutovistaColors.primaryRed,
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Promo code ${c.code} copied to clipboard!',
                                            ),
                                            backgroundColor:
                                                AutovistaColors.primaryRed,
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.copy_rounded,
                                            size: 13,
                                            color: AutovistaColors.primaryRed,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            c.code,
                                            style: GoogleFonts.spaceMono(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                c.title,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                c.desc,
                                style: GoogleFonts.outfit(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}
