import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/autovista/data/datasources/autovista_local_data_source.dart';
import 'package:joel_portfolio/features/autovista/domain/entities/autovista_page_data_entity.dart';
import 'package:joel_portfolio/features/autovista/presentation/providers/autovista_providers.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/pages/autovista_website_screen.dart';

void main() {
  late AutovistaPageDataEntity testData;

  setUpAll(() async {
    final model = await AutovistaLocalDataSourceImpl().getPageData();
    testData = model.toEntity();
  });

  group('Autovista Widget & Interaction Tests', () {
    testWidgets('renders AutovistaPage at desktop size and interacts with tabs',
        (tester) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            autovistaPageDataProvider
                .overrideWith((ref) async => testData),
          ],
          child: const MaterialApp(
            home: AutovistaPage(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Verify Home Screen elements
      expect(find.text('GO DRIVE'), findsWidgets);
      expect(find.text('PORTFOLIO'), findsOneWidget);
      expect(find.text('Popular Rental Fleet'), findsOneWidget);

      // Switch to Fleet tab via top header
      await tester.tap(find.text('Our Fleet').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('EXPLORE OUR LUXURY FLEET'), findsOneWidget);

      // Switch to Deals tab
      await tester.tap(find.text('Rental Deals').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('EXCLUSIVE RENTAL DEALS'), findsOneWidget);

      // Switch to Services tab
      await tester.tap(find.text('Services').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('TAILORED AUTOMOTIVE SERVICES'), findsOneWidget);

      // Switch to Locations tab
      await tester.ensureVisible(find.text('Locations').first);
      await tester.tap(find.text('Locations').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('OUR RENTAL HUBS & HUBS'), findsOneWidget);

      // Switch to About Us tab
      await tester.ensureVisible(find.text('About Us').first);
      await tester.tap(find.text('About Us').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('THE GO DRIVE STORY'), findsOneWidget);

      // Switch to Insurance tab
      await tester.ensureVisible(find.text('Insurance').first);
      await tester.tap(find.text('Insurance').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('COMPREHENSIVE COVERAGE & PROTECTION'), findsOneWidget);

      // Switch to Contact tab
      await tester.ensureVisible(find.text('Contact').first);
      await tester.tap(find.text('Contact').first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('CONNECT WITH OUR CONCIERGE'), findsOneWidget);
    });

    testWidgets('renders AutovistaPage at mobile size with mobile top nav',
        (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            autovistaPageDataProvider
                .overrideWith((ref) async => testData),
          ],
          child: const MaterialApp(
            home: AutovistaPage(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // In mobile mode, sidebar is hidden and horizontal mobile nav is visible
      expect(find.text('GO DRIVE'), findsWidgets);
      expect(find.text('PORTFOLIO'), findsOneWidget);
    });

    testWidgets('GoDriveWebsiteScreen adapter works seamlessly',
        (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            autovistaPageDataProvider
                .overrideWith((ref) async => testData),
          ],
          child: const MaterialApp(
            home: GoDriveWebsiteScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(AutovistaPage), findsOneWidget);
      expect(find.text('GO DRIVE'), findsWidgets);
    });
  });
}
