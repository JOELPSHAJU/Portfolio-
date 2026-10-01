import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class SuiteFilterTabs extends StatelessWidget {
  final String selectedCategory;
  final int totalCount;
  final ValueChanged<String> onSelectCategory;

  const SuiteFilterTabs({
    super.key,
    required this.selectedCategory,
    required this.totalCount,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterTab('all', 'ALL SANCTUARIES', totalCount),
          _buildFilterTab('presidential', 'ROYAL & PLATINUM', 2),
          _buildFilterTab('villas', 'OVERWATER & VILLAS', 1),
          _buildFilterTab('oceanfront', 'OCEAN HORIZON', 1),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String id, String label, int count) {
    final isSelected = selectedCategory == id;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => onSelectCategory(id),
        borderRadius: BorderRadius.circular(30),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? kGold : Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? kGold : kGold.withValues(alpha: 0.3),
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: kGold.withValues(alpha: 0.35),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.cinzel(
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? kObsidian : kIvory,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? kObsidian.withValues(alpha: 0.25)
                      : kGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: GoogleFonts.spaceMono(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? kObsidian : kGold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
