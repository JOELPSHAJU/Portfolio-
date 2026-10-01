import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/autovista_insurance_plan_entity.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_screen_header_banner.dart';

class AutovistaInsuranceScreen extends StatelessWidget {
  final bool isDesktop;
  final List<AutovistaInsurancePlanEntity> insurancePlans;

  const AutovistaInsuranceScreen({
    super.key,
    required this.isDesktop,
    required this.insurancePlans,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutovistaScreenHeaderBanner(
          tag: 'ZERO WORRIES ON THE ROAD',
          title: 'COMPREHENSIVE COVERAGE & PROTECTION',
          subtitle:
              'Drive with ultimate confidence. Choose the protection tier tailored to your peace of mind with crystal-clear coverage terms.',
          isDesktop: isDesktop,
        ),

        // 3-Tier Protection Plans
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 2 * 20) / 3
                  : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: insurancePlans.map((p) {
                  final isFeatured = p.isFeatured;
                  return SizedBox(
                    width: cardWidth,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color:
                            isFeatured ? AutovistaColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isFeatured
                              ? AutovistaColors.primaryRed
                              : Colors.black.withValues(alpha: 0.06),
                          width: isFeatured ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isFeatured)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: AutovistaColors.primaryRed,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'RECOMMENDED CHOICE',
                                style: GoogleFonts.spaceMono(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Text(
                            p.tier,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isFeatured ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            p.cost,
                            style: GoogleFonts.anton(
                              fontSize: 24,
                              color: AutovistaColors.primaryRed,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            p.excess,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isFeatured
                                  ? Colors.white.withValues(alpha: 0.7)
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Divider(
                            color: isFeatured
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.grey.shade200,
                          ),
                          const SizedBox(height: 12),
                          ...p.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: AutovistaColors.primaryRed,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        color: isFeatured
                                            ? Colors.white
                                                .withValues(alpha: 0.85)
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Selected ${p.tier} protection plan for your journey!',
                                    ),
                                    backgroundColor: AutovistaColors.primaryRed,
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isFeatured
                                      ? AutovistaColors.primaryRed
                                      : AutovistaColors.cardDark,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Select Plan',
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
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
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}
