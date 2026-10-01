import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/autovista_service_entity.dart';

class AutovistaServicesBlock extends StatelessWidget {
  final List<AutovistaServiceEntity> services;

  const AutovistaServicesBlock({super.key, required this.services});

  IconData _resolveIcon(String iconName) {
    switch (iconName) {
      case 'flight_takeoff_rounded':
        return Icons.flight_takeoff_rounded;
      case 'airline_seat_recline_extra_rounded':
        return Icons.airline_seat_recline_extra_rounded;
      case 'home_work_outlined':
        return Icons.home_work_outlined;
      case 'calendar_month_outlined':
        return Icons.calendar_month_outlined;
      default:
        return Icons.miscellaneous_services_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental Services',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: services.map((srv) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _resolveIcon(srv.icon),
                      color: Colors.black87,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      srv.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      srv.sub,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.outfit(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
