import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/accolade.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/booking.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/concierge_privilege.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/dining_venue.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/hotel_page_data.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/navigation_item.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/spa_treatment.dart';
import 'package:joel_portfolio/features/luxury_hotel/domain/entities/suite.dart';
import 'package:joel_portfolio/features/luxury_hotel/presentation/pages/luxury_hotel_page.dart';
import 'package:joel_portfolio/features/luxury_hotel/presentation/providers/luxury_hotel_providers.dart';
import 'package:joel_portfolio/features/luxury_hotel/presentation/widgets/booking_bar.dart';
import 'package:joel_portfolio/features/luxury_hotel/presentation/widgets/suite_filter_tabs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final mockPageData = HotelPageData(
    suites: const [
      Suite(
        id: 'royal_penthouse',
        category: 'presidential',
        title: 'The Royal Imperial Penthouse',
        tagline: '450 m² • 360° Ocean Vista • Private Plunge Pool & Helipad Pier',
        price: '\$4,800',
        period: '/ night',
        badge: 'PREMIER MASTERWORK',
        image: 'assets/hotel_suite_penthouse.jpg',
        sqm: '450 m²',
        guests: 'Up to 6 Guests',
        view: 'Panoramic Azure Horizon',
        features: ['Private heated cliffside infinity plunge pool'],
        description: 'Suspended between azure sea and open sky.',
      ),
      Suite(
        id: 'lagoon_villa',
        category: 'villas',
        title: 'The Azure Lagoon Villa',
        tagline: '320 m² • Direct Overwater Access',
        price: '\$3,400',
        period: '/ night',
        badge: 'PRIVATE OVERWATER',
        image: 'assets/hotel_suite_villa.jpg',
        sqm: '320 m²',
        guests: 'Up to 4 Guests',
        view: 'Private Lagoon & Coral Garden',
        features: ['Private teak boardwalk'],
        description: 'Tucked along our private crystalline cove.',
      ),
    ],
    diningVenues: const [
      DiningVenue(
        name: "L'Étoile Céeste",
        stars: '★★★ MICHELIN GUIDE',
        chef: 'Chef Patron Alexandre Valmont',
        cuisine: 'Haute French Coastal Gastronomy',
        hours: '18:30 – 23:00 • Formal Attire',
        highlight: '18,000 Vintage Wine Vault',
      ),
    ],
    spaTreatments: const [
      SpaTreatment(
        title: 'Swiss Cellular Bio-Regeneration',
        time: '90 MIN',
        price: '\$550',
        desc: 'Targeted cellular infusion.',
      ),
    ],
    conciergePrivileges: const [
      ConciergePrivilege(
        icon: 'airplanemode_active_rounded',
        title: 'AgustaWestland Helipad',
        desc: 'Direct private landing strip.',
      ),
    ],
    accolades: const [
      Accolade(
        issuer: 'FORBES TRAVEL GUIDE',
        grade: '★ ★ ★ ★ ★',
        award: 'FIVE-STAR VERIFIED 2026',
      ),
    ],
    booking: const BookingInfo(
      checkIn: 'Oct 14, 2026',
      checkInSubtitle: 'From 15:00',
      checkOut: 'Oct 21, 2026',
      checkOutSubtitle: '7 Nights Stay',
      guests: '2 Adults, 1 Suite',
      guestsSubtitle: 'Private Butler Concierge',
      tier: 'Imperial Penthouse',
      tierSubtitle: 'Complimentary Yacht Transfer',
      datesCompact: 'Oct 14 – 21, 2026',
      datesSubtitleCompact: '7 Nights',
      guestsCompact: '2 Adults',
      guestsSubtitleCompact: 'Butler Concierge',
      privilegeInclusions: ['Complimentary AgustaWestland or Yacht Transfer'],
      sampleDates: 'OCTOBER 14 – 21, 2026',
      sampleSummary: '7 Nights • 2 Guests • Royal Imperial Penthouse',
      samplePrice: '\$33,600',
    ),
    navigationItems: const [
      NavigationItem(label: 'SUITES', target: 'suites'),
    ],
  );

  testWidgets('renders LuxuryHotelPage with Riverpod provider override', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          luxuryHotelDataProvider.overrideWith((ref) => Future.value(mockPageData)),
        ],
        child: const MaterialApp(
          home: LuxuryHotelPage(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(BookingBar), findsOneWidget);
    expect(find.byType(SuiteFilterTabs), findsOneWidget);
    expect(find.text('DIRECT SANCTUARY RESERVATION'), findsOneWidget);
    expect(find.text('THE SUITE & VILLA COLLECTION'), findsOneWidget);
    expect(find.text("EPICUREAN HAUTE CUISINE"), findsOneWidget);
  });
}
