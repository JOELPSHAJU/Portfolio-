import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/suite.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/suite_card.dart';
import '../widgets/suite_filter_tabs.dart';

class SuitesSection extends StatelessWidget {
  final GlobalKey? suitesKey;
  final bool isDesktop;
  final bool isTablet;
  final List<Suite> allSuites;
  final String selectedCategory;
  final ValueChanged<String> onSelectCategory;
  final void Function(Suite suite) onReserveSuite;
  final void Function(Suite suite) onExploreSuite;

  const SuitesSection({
    super.key,
    this.suitesKey,
    required this.isDesktop,
    required this.isTablet,
    required this.allSuites,
    required this.selectedCategory,
    required this.onSelectCategory,
    required this.onReserveSuite,
    required this.onExploreSuite,
  });

  @override
  Widget build(BuildContext context) {
    final filteredSuites = selectedCategory == 'all'
        ? allSuites
        : allSuites.where((s) => s.category == selectedCategory).toList();

    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 40,
    );

    return Container(
      key: suitesKey,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 28, height: 2, color: kGold),
              const SizedBox(width: 10),
              Text(
                '01 / PRIVATE SANCTUARIES',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 11,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'THE SUITE & VILLA COLLECTION',
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 34 : (isTablet ? 28 : 22),
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Handcrafted architectural pavilions carved into private Riviera limestone promontories, featuring heated infinity plunge pools, dedicated 24/7 royal butler guilds, and subterranean sommelier vaults.',
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Category Filter Tabs
          SuiteFilterTabs(
            selectedCategory: selectedCategory,
            totalCount: allSuites.length,
            onSelectCategory: onSelectCategory,
          ),
          const SizedBox(height: 28),

          // Compact Haute Luxury Sanctuary Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = isDesktop
                  ? (constraints.maxWidth - 24) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: filteredSuites.asMap().entries.map((entry) {
                  final index = entry.key;
                  final suite = entry.value;
                  return SizedBox(
                    width: cardWidth,
                    child: SuiteCard(
                      suite: suite,
                      sanctuaryNumber: '0${index + 1}',
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      onReserve: () => onReserveSuite(suite),
                      onExplore: () => onExploreSuite(suite),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
