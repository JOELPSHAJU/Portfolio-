import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/autovista_service_entity.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_screen_header_banner.dart';

class AutovistaServicesScreen extends StatelessWidget {
  final bool isDesktop;
  final List<AutovistaServiceEntity> detailedServices;

  const AutovistaServicesScreen({
    super.key,
    required this.isDesktop,
    required this.detailedServices,
  });

  IconData _resolveIcon(String iconName) {
    switch (iconName) {
      case 'airline_seat_recline_extra_rounded':
        return Icons.airline_seat_recline_extra_rounded;
      case 'flight_takeoff_rounded':
        return Icons.flight_takeoff_rounded;
      case 'celebration_rounded':
        return Icons.celebration_rounded;
      case 'business_center_rounded':
        return Icons.business_center_rounded;
      case 'home_work_rounded':
        return Icons.home_work_rounded;
      case 'speed_rounded':
        return Icons.speed_rounded;
      default:
        return Icons.miscellaneous_services_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutovistaScreenHeaderBanner(
          tag: 'BESPOKE MOBILITY SOLUTIONS',
          title: 'TAILORED AUTOMOTIVE SERVICES',
          subtitle:
              'From self-drive exotics to executive chauffeur transit and corporate fleet programs, discover mobility designed entirely around your prestige.',
          isDesktop: isDesktop,
        ),

        // Services 6-Card Grid
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 20) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: detailedServices.map((srv) {
                  return SizedBox(
                    width: cardWidth,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.06),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AutovistaColors.primaryRed
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  _resolveIcon(srv.icon),
                                  color: AutovistaColors.primaryRed,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  srv.title,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            srv.sub,
                            style: GoogleFonts.outfit(
                              fontSize: 12.5,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.grey.shade200),
                          const SizedBox(height: 10),
                          ...srv.features.map((feat) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: AutovistaColors.primaryRed,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      feat,
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 14),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Concierge inquiry submitted for ${srv.title}! We will reach out shortly.',
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
                                  color: AutovistaColors.cardDark,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Inquire Service',
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
