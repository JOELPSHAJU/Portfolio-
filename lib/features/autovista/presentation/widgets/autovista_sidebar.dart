import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/autovista_colors.dart';
import 'autovista_brand_speedometer_icon.dart';

class AutovistaSidebarItem {
  final String title;
  final IconData icon;

  const AutovistaSidebarItem({required this.title, required this.icon});
}

class AutovistaSidebar extends StatelessWidget {
  final int selectedSidebarIdx;
  final ValueChanged<int> onSelectSidebar;
  final VoidCallback onHelpClick;

  const AutovistaSidebar({
    super.key,
    required this.selectedSidebarIdx,
    required this.onSelectSidebar,
    required this.onHelpClick,
  });

  static const List<AutovistaSidebarItem> sidebarItems = [
    AutovistaSidebarItem(title: 'Home', icon: Icons.home_rounded),
    AutovistaSidebarItem(title: 'Rental Fleet', icon: Icons.directions_car_rounded),
    AutovistaSidebarItem(title: 'Luxury Collection', icon: Icons.stars_rounded),
    AutovistaSidebarItem(title: 'SUVs & Vans', icon: Icons.airport_shuttle_rounded),
    AutovistaSidebarItem(title: 'Electric Fleet', icon: Icons.bolt_rounded),
    AutovistaSidebarItem(title: 'Rental Deals', icon: Icons.local_offer_outlined),
    AutovistaSidebarItem(
      title: 'Chauffeur Service',
      icon: Icons.airline_seat_recline_extra_rounded,
    ),
    AutovistaSidebarItem(title: 'Rental Locations', icon: Icons.location_on_outlined),
    AutovistaSidebarItem(title: 'Contact & Help', icon: Icons.support_agent_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Brand Logo
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          child: Row(
            children: [
              const AutovistaBrandSpeedometerIcon(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GO DRIVE',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'PREMIUM CAR RENTAL',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceMono(
                        fontSize: 7.5,
                        fontWeight: FontWeight.bold,
                        color: AutovistaColors.primaryRed,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Navigation Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: sidebarItems.length,
            itemBuilder: (context, idx) {
              final item = sidebarItems[idx];
              final isSelected = selectedSidebarIdx == idx;

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onSelectSidebar(idx),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AutovistaColors.primaryRed
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 18,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withValues(alpha: 0.75),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Need Help Box at Bottom
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AutovistaColors.primaryRed.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.headset_mic_rounded,
                        color: AutovistaColors.primaryRed,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '24/7 Rental Help',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "We're here for your trip!",
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton.icon(
                    onPressed: onHelpClick,
                    icon: const Icon(Icons.support_agent_rounded, size: 14),
                    label: Text(
                      'Rental Support',
                      style: GoogleFonts.outfit(fontSize: 11),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AutovistaColors.primaryRed,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
