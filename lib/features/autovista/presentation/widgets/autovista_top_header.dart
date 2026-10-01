import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/autovista_colors.dart';
import 'autovista_brand_speedometer_icon.dart';

class AutovistaTopHeader extends StatelessWidget {
  final bool isDesktop;
  final List<String> topNavLinks;
  final int selectedTopNavIdx;
  final ValueChanged<int> onSelectTopNav;

  const AutovistaTopHeader({
    super.key,
    required this.isDesktop,
    required this.topNavLinks,
    required this.selectedTopNavIdx,
    required this.onSelectTopNav,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AutovistaColors.headerDark,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 28 : 16,
        vertical: 14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // If not desktop, show logo on header
          if (!isDesktop)
            Row(
              children: [
                const AutovistaBrandSpeedometerIcon(),
                const SizedBox(width: 8),
                Text(
                  'GO DRIVE',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

          // Center Horizontal Navigation Links
          if (isDesktop)
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: topNavLinks.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final title = entry.value;
                    final isActive = idx == selectedTopNavIdx;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onSelectTopNav(idx),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isActive
                                  ? AutovistaColors.primaryRed
                                  : Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: isActive ? 20 : 0,
                            color: AutovistaColors.primaryRed,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

          // Right "Rent a Car Now" CTA Button
          Flexible(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onSelectTopNav(1),
                child: Container(
                  margin: EdgeInsets.only(
                    right: isDesktop ? 120 : 0,
                  ), // gap for floating portfolio btn on desktop
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.vpn_key_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Rent a Car Now',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
