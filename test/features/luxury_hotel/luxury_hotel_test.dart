import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/luxury_hotel/data/datasources/luxury_hotel_json_data_source.dart';
import 'package:joel_portfolio/features/luxury_hotel/data/repositories/luxury_hotel_repository_impl.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/usecases/get_hotel_page_data.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/usecases/get_suites.dart';
import 'package:joel_portfolio/features/luxury_hotel/presentation/utils/hero_opacity_calculator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HeroOpacityCalculator', () {
    test('calculates correct opacity at start and progress milestones', () {
      expect(HeroOpacityCalculator.calculate(0.0, 0.0, 0.28), 1.0);
      expect(HeroOpacityCalculator.calculate(0.18, 0.0, 0.28), 1.0);
      expect(HeroOpacityCalculator.calculate(0.28, 0.0, 0.28), 0.0);
      expect(HeroOpacityCalculator.calculate(0.5, 0.0, 0.28), 0.0);
      expect(HeroOpacityCalculator.calculate(1.0, 0.85, 1.0), 1.0);
    });
  });

  group('LuxuryHotel Clean Architecture & Repository', () {
    test('loads and converts hotel page data correctly', () async {
      const dataSource = LuxuryHotelJsonDataSource();
      final repository = LuxuryHotelRepositoryImpl(dataSource);
      final getHotelPageData = GetHotelPageData(repository);
      final getSuites = GetSuites(repository);

      final pageData = await getHotelPageData();
      expect(pageData.suites.length, 4);
      expect(pageData.diningVenues.length, 3);
      expect(pageData.spaTreatments.length, 3);
      expect(pageData.conciergePrivileges.length, 4);
      expect(pageData.accolades.length, 4);
      expect(pageData.booking.checkIn, 'Oct 14, 2026');

      final suites = await getSuites();
      expect(suites.length, 4);
      expect(suites.first.id, 'royal_penthouse');
      expect(suites.first.category, 'presidential');
    });
  });
}
