import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/core/widgets/scroll_video_hero.dart';
import '../../domain/entities/hotel_page_data.dart';
import '../dialogs/booking_dialog.dart';
import '../dialogs/reserve_suite_dialog.dart';
import '../dialogs/spa_reservation_dialog.dart';
import '../dialogs/suite_details_dialog.dart';
import '../dialogs/table_reservation_dialog.dart';
import '../providers/luxury_hotel_providers.dart';
import '../sections/accolades_section.dart';
import '../sections/booking_section.dart';
import '../sections/concierge_section.dart';
import '../sections/dining_section.dart';
import '../sections/hotel_video_hero_section.dart';
import '../sections/luxury_footer_section.dart';
import '../sections/spa_section.dart';
import '../sections/suites_section.dart';
import '../theme/luxury_hotel_assets.dart';
import '../theme/luxury_hotel_colors.dart';
import '../theme/luxury_hotel_dimensions.dart';
import '../utils/luxury_hotel_responsive.dart';
import '../widgets/luxury_navbar.dart';

class LuxuryHotelPage extends ConsumerStatefulWidget {
  const LuxuryHotelPage({super.key});

  @override
  ConsumerState<LuxuryHotelPage> createState() => _LuxuryHotelPageState();
}

class _LuxuryHotelPageState extends ConsumerState<LuxuryHotelPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollVideoHeroController _videoHeroController =
      ScrollVideoHeroController();

  final GlobalKey _suitesKey = GlobalKey();
  final GlobalKey _diningKey = GlobalKey();
  final GlobalKey _spaKey = GlobalKey();
  final GlobalKey _conciergeKey = GlobalKey();
  final GlobalKey _bookingKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (final asset in LuxuryHotelAssets.precacheImageList) {
      precacheImage(AssetImage(asset), context);
    }
  }

  @override
  void dispose() {
    _videoHeroController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToNextSection(double screenHeight) {
    _scrollController.animateTo(
      LuxuryHotelDimensions.videoScrollDistance + screenHeight,
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hotelDataAsync = ref.watch(luxuryHotelDataProvider);

    return hotelDataAsync.when(
      loading: () => const Scaffold(
        backgroundColor: kObsidian,
        body: Center(
          child: CircularProgressIndicator(color: kGold, strokeWidth: 2),
        ),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: kObsidian,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'UNABLE TO LOAD SANCTUARY EXPERIENCES',
                style: GoogleFonts.cinzel(
                  color: kGold,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.invalidate(luxuryHotelDataProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: kObsidian,
                ),
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      ),
      data: (data) => _buildPageContent(context, data),
    );
  }

  Widget _buildPageContent(BuildContext context, HotelPageData data) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = LuxuryHotelResponsive.isDesktop(context);
    final isTablet = LuxuryHotelResponsive.isTablet(context);
    final selectedCategory = ref.watch(selectedSuiteCategoryProvider);

    return Scaffold(
      backgroundColor: kObsidian,
      body: Stack(
        children: [
          // ── 1. The Scroll-Driven Video Hero ───────────────────────────────
          HotelVideoHeroSection(
            scrollController: _scrollController,
            videoHeroController: _videoHeroController,
            isDesktop: isDesktop,
            onScrollToNextSection: () => _scrollToNextSection(screenSize.height),
            onExploreSuites: () => _scrollToKey(_suitesKey),
          ),

          // ── 2. The Main Page Scrollable Content ───────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Perfect geometric spacer: guarantees zero overlap with video
                SizedBox(
                  height:
                      LuxuryHotelDimensions.videoScrollDistance + screenSize.height,
                ),

                // SECTION 1: DIRECT RESERVATION BAR
                RepaintBoundary(
                  child: BookingSection(
                    bookingKey: _bookingKey,
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    bookingInfo: data.booking,
                    onOpenBooking: () => BookingDialog.show(
                      context,
                      privilegeInclusions: data.booking.privilegeInclusions,
                      sampleDates: data.booking.sampleDates,
                      sampleSummary: data.booking.sampleSummary,
                      samplePrice: data.booking.samplePrice,
                    ),
                  ),
                ),

                // SECTION 2: THE SUITE COLLECTION (Rooms & Real High-Res Images)
                RepaintBoundary(
                  child: SuitesSection(
                    suitesKey: _suitesKey,
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    allSuites: data.suites,
                    selectedCategory: selectedCategory,
                    onSelectCategory: (cat) => ref
                        .read(selectedSuiteCategoryProvider.notifier)
                        .state = cat,
                    onReserveSuite: (suite) =>
                        ReserveSuiteDialog.show(context, suite),
                    onExploreSuite: (suite) => SuiteDetailsDialog.show(
                      context,
                      suite,
                      onReserveThisSuite: () =>
                          ReserveSuiteDialog.show(context, suite),
                    ),
                  ),
                ),

                // SECTION 3: EPICUREAN DINING & GASTRONOMY
                RepaintBoundary(
                  child: DiningSection(
                    diningKey: _diningKey,
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    venues: data.diningVenues,
                    onReserveTable: (restaurantName) =>
                        TableReservationDialog.show(context, restaurantName),
                  ),
                ),

                // SECTION 4: THE SOMA THALASSO SPA & WELLNESS
                RepaintBoundary(
                  child: SpaSection(
                    spaKey: _spaKey,
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    treatments: data.spaTreatments,
                    onOpenSpaMenu: () => SpaReservationDialog.show(context),
                  ),
                ),

                // SECTION 5: BESPOKE CONCIERGE & FLEET PRIVILEGES
                RepaintBoundary(
                  child: ConciergeSection(
                    conciergeKey: _conciergeKey,
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    privileges: data.conciergePrivileges,
                  ),
                ),

                // SECTION 6: WORLD ACCOLADES & FORBES RATINGS
                RepaintBoundary(
                  child: AccoladesSection(
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                    accolades: data.accolades,
                  ),
                ),

                // SECTION 7: GRAND LUXURY EDITORIAL FOOTER
                RepaintBoundary(
                  child: LuxuryFooterSection(
                    isDesktop: isDesktop,
                    isTablet: isTablet,
                  ),
                ),
              ],
            ),
          ),

          // ── 3. Sticky Top Floating Navigation Bar ─────────────────────────
          LuxuryNavbar(
            isDesktop: isDesktop,
            onSuitesTap: () => _scrollToKey(_suitesKey),
            onDiningTap: () => _scrollToKey(_diningKey),
            onSpaTap: () => _scrollToKey(_spaKey),
            onPrivilegesTap: () => _scrollToKey(_conciergeKey),
            onReserveTap: () => BookingDialog.show(
              context,
              privilegeInclusions: data.booking.privilegeInclusions,
              sampleDates: data.booking.sampleDates,
              sampleSummary: data.booking.sampleSummary,
              samplePrice: data.booking.samplePrice,
            ),
          ),
        ],
      ),
    );
  }
}
