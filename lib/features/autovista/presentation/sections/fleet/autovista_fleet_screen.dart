import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/autovista_car_entity.dart';
import '../../providers/autovista_providers.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_fleet_car_card.dart';
import '../../widgets/autovista_screen_header_banner.dart';

class AutovistaFleetScreen extends ConsumerWidget {
  final bool isDesktop;
  final List<AutovistaCarEntity> allFleetCars;

  const AutovistaFleetScreen({
    super.key,
    required this.isDesktop,
    required this.allFleetCars,
  });

  static const List<String> categories = [
    'All Vehicles',
    'Luxury Sedans',
    'Performance SUVs',
    'Sports & Exotics',
    'Electric & Hybrid',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(autovistaSelectedFleetFilterProvider);

    final filtered = selectedFilter == 'All Vehicles'
        ? allFleetCars
        : allFleetCars.where((c) => c.category == selectedFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutovistaScreenHeaderBanner(
          tag: 'PRESTIGE FLEET COLLECTION',
          title: 'EXPLORE OUR LUXURY FLEET',
          subtitle:
              'Browse our handpicked fleet of high-performance supercars, executive sedans, and luxury SUVs ready for immediate self-drive or chauffeur dispatch.',
          isDesktop: isDesktop,
        ),

        // Fleet Filter Chips Bar
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 16,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = selectedFilter == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(autovistaSelectedFleetFilterProvider.notifier)
                            .state = cat;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AutovistaColors.primaryRed
                              : const Color(0xFFF1F3F6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? AutovistaColors.primaryRed
                                : Colors.black.withValues(alpha: 0.06),
                          ),
                        ),
                        child: Text(
                          cat,
                          style: GoogleFonts.outfit(
                            fontSize: 12.5,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Fleet Counter & Amenities Info Strip
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${filtered.length} Premium Vehicles',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AutovistaColors.primaryRed,
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '100% Sanitized & Detailed',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Responsive Fleet Cars Grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 2 * 20) / 3
                  : constraints.maxWidth > 700
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: filtered.map((car) {
                  return SizedBox(
                    width: cardWidth,
                    child: AutovistaFleetCarCard(car: car),
                  );
                }).toList(),
              );
            },
          ),
        ),

        const SizedBox(height: 40),

        // Fleet Guarantee Banner
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AutovistaColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isDesktop)
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AutovistaColors.primaryRed
                                .withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            color: AutovistaColors.primaryRed,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Our Certified Fleet Guarantee',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Every vehicle undergoes 150-point diagnostic inspections and comes with complimentary 24/7 roadside assist.',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.65),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AutovistaColors.primaryRed
                              .withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          color: AutovistaColors.primaryRed,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Our Certified Fleet Guarantee',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Every vehicle undergoes 150-point diagnostic inspections and comes with complimentary 24/7 roadside assist.',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.65),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!isDesktop) const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: Colors.white.withValues(alpha: 0.15)),
                  ),
                  child: Text(
                    'Certified Safe',
                    style: GoogleFonts.spaceMono(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}
