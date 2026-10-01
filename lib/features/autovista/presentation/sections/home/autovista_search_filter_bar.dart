import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/autovista_providers.dart';
import '../../theme/autovista_colors.dart';

class AutovistaSearchFilterBar extends ConsumerWidget {
  final bool isDesktop;
  final VoidCallback? onFindRentalCar;

  const AutovistaSearchFilterBar({
    super.key,
    required this.isDesktop,
    this.onFindRentalCar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedType = ref.watch(autovistaSelectedTypeProvider);
    final selectedLocation = ref.watch(autovistaSelectedLocationProvider);
    final selectedDuration = ref.watch(autovistaSelectedDurationProvider);
    final selectedPrice = ref.watch(autovistaSelectedPriceProvider);

    return Transform.translate(
      offset: const Offset(0, -32),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: isDesktop
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              _buildFilterSelector(
                'Vehicle Type',
                selectedType,
                Icons.directions_car_outlined,
                const ['Any Type', 'Sedan', 'Luxury SUV', 'Sports Coupe', 'Electric'],
                (val) =>
                    ref.read(autovistaSelectedTypeProvider.notifier).state = val,
              ),
              if (isDesktop) _buildVerticalDivider(),
              _buildFilterSelector(
                'Pick-up Location',
                selectedLocation,
                Icons.location_on_outlined,
                const [
                  'Any Location',
                  'Kalamasery',
                  'Maradu',
                  'Infopark',
                  'Edapally',
                ],
                (val) => ref
                    .read(autovistaSelectedLocationProvider.notifier)
                    .state = val,
              ),
              if (isDesktop) _buildVerticalDivider(),
              _buildFilterSelector(
                'Rental Duration',
                selectedDuration,
                Icons.calendar_today_outlined,
                const [
                  'Any Duration',
                  'Daily (1-3 Days)',
                  'Weekly (7 Days)',
                  'Monthly (30+ Days)',
                ],
                (val) => ref
                    .read(autovistaSelectedDurationProvider.notifier)
                    .state = val,
              ),
              if (isDesktop) _buildVerticalDivider(),
              _buildFilterSelector(
                'Daily Budget',
                selectedPrice,
                Icons.sell_outlined,
                const [
                  'Any Budget',
                  'Under ₹12000/day',
                  'Under ₹15000/day',
                  'Under ₹25000/day',
                  '₹30000+/day',
                ],
                (val) =>
                    ref.read(autovistaSelectedPriceProvider.notifier).state = val,
              ),
              const SizedBox(width: 16),

              // Find Rental Car Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onFindRentalCar,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AutovistaColors.primaryRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Find Rental Car',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        : Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFilterSelector(
                'Vehicle Type',
                selectedType,
                Icons.directions_car_outlined,
                const ['Any Type', 'Sedan', 'Luxury SUV', 'Sports Coupe', 'Electric'],
                (val) =>
                    ref.read(autovistaSelectedTypeProvider.notifier).state = val,
              ),
              _buildFilterSelector(
                'Pick-up Location',
                selectedLocation,
                Icons.location_on_outlined,
                const [
                  'Any Location',
                  'Kochi Airport',
                  'Marine Drive',
                  'Fort Kochi',
                  'Infopark',
                  'Edapally',
                ],
                (val) =>
                    ref.read(autovistaSelectedLocationProvider.notifier).state = val,
              ),
              _buildFilterSelector(
                'Rental Duration',
                selectedDuration,
                Icons.calendar_today_outlined,
                const [
                  'Any Duration',
                  'Daily (1-3 Days)',
                  'Weekly (7 Days)',
                  'Monthly (30+ Days)',
                ],
                (val) =>
                    ref.read(autovistaSelectedDurationProvider.notifier).state = val,
              ),
              _buildFilterSelector(
                'Price Range',
                selectedPrice,
                Icons.currency_rupee_rounded,
                const [
                  'Any Budget',
                  'Under ₹12000/day',
                  'Under ₹15000/day',
                  'Under ₹25000/day',
                  '₹30000+/day',
                ],
                (val) =>
                    ref.read(autovistaSelectedPriceProvider.notifier).state = val,
              ),
              const SizedBox(height: 16),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: onFindRentalCar,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AutovistaColors.primaryRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Find Rental Car',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSelector(
    String label,
    String currentValue,
    IconData icon,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: Colors.black87,
              ),
              isDense: true,
              items: options.map((opt) {
                return DropdownMenuItem(
                  value: opt,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 15, color: Colors.grey.shade700),
                      const SizedBox(width: 8),
                      Text(
                        opt,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 38, color: Colors.grey.shade200);
  }
}
