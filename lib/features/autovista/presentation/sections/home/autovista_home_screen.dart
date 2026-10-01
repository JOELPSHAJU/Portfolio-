import 'package:flutter/material.dart';
import '../../../domain/entities/autovista_page_data_entity.dart';
import 'autovista_hero_section.dart';
import 'autovista_newsletter_banner.dart';
import 'autovista_popular_vehicles_section.dart';
import 'autovista_search_filter_bar.dart';
import 'autovista_value_props_bar.dart';

class AutovistaHomeScreen extends StatelessWidget {
  final bool isDesktop;
  final AutovistaPageDataEntity pageData;
  final VoidCallback onNavigateToFleet;

  const AutovistaHomeScreen({
    super.key,
    required this.isDesktop,
    required this.pageData,
    required this.onNavigateToFleet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Hero Section
        AutovistaHeroSection(
          isDesktop: isDesktop,
          onBookRental: onNavigateToFleet,
        ),

        // 2. Search Filter Floating Bar
        AutovistaSearchFilterBar(
          isDesktop: isDesktop,
          onFindRentalCar: onNavigateToFleet,
        ),

        // 3. Value Propositions Bar
        AutovistaValuePropsBar(
          isDesktop: isDesktop,
          props: pageData.valueProps,
        ),

        const SizedBox(height: 36),

        // 4. Popular Vehicles & Side Banners
        AutovistaPopularVehiclesSection(
          isDesktop: isDesktop,
          cars: pageData.popularCars,
          services: pageData.services,
          onViewEntireFleet: onNavigateToFleet,
          onRentNow: onNavigateToFleet,
        ),

        const SizedBox(height: 48),

        // 5. Newsletter "Stay in the Loop" Banner
        AutovistaNewsletterBanner(isDesktop: isDesktop),

        const SizedBox(height: 50),
      ],
    );
  }
}
