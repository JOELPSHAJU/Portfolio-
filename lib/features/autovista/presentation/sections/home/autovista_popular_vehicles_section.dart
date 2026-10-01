import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/autovista_car_entity.dart';
import '../../../domain/entities/autovista_service_entity.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_vehicle_card.dart';
import 'autovista_ready_to_hit_road_banner.dart';
import 'autovista_services_block.dart';

class AutovistaPopularVehiclesSection extends StatelessWidget {
  final bool isDesktop;
  final List<AutovistaCarEntity> cars;
  final List<AutovistaServiceEntity> services;
  final VoidCallback onViewEntireFleet;
  final VoidCallback onRentNow;

  const AutovistaPopularVehiclesSection({
    super.key,
    required this.isDesktop,
    required this.cars,
    required this.services,
    required this.onViewEntireFleet,
    required this.onRentNow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title & "View Entire Fleet" Link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Popular Rental Fleet',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onViewEntireFleet,
                  child: Row(
                    children: [
                      Text(
                        'View Entire Fleet',
                        style: GoogleFonts.outfit(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AutovistaColors.primaryRed,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: AutovistaColors.primaryRed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4 Vehicle Cards Row
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
                children: cars.map((car) {
                  return SizedBox(
                    width: cardWidth,
                    child: AutovistaVehicleCard(car: car),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 36),

          // Split Row: "Ready to Hit the Road?" & "Our Services"
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ready To Hit The Road Banner Card
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: AutovistaReadyToHitRoadBanner(onRentNow: onRentNow),
              ),

              if (isDesktop)
                const SizedBox(width: 24)
              else
                const SizedBox(height: 24),

              // Our Services 4-card Row
              Expanded(
                flex: isDesktop ? 7 : 0,
                child: AutovistaServicesBlock(services: services),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
