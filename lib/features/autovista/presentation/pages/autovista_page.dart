import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/autovista_page_data_entity.dart';
import '../providers/autovista_providers.dart';
import '../sections/about/autovista_about_screen.dart';
import '../sections/contact/autovista_contact_screen.dart';
import '../sections/deals/autovista_deals_screen.dart';
import '../sections/fleet/autovista_fleet_screen.dart';
import '../sections/home/autovista_home_screen.dart';
import '../sections/insurance/autovista_insurance_screen.dart';
import '../sections/locations/autovista_locations_screen.dart';
import '../sections/services/autovista_services_screen.dart';
import '../theme/autovista_colors.dart';
import '../widgets/autovista_floating_back_button.dart';
import '../widgets/autovista_footer.dart';
import '../widgets/autovista_mobile_top_nav.dart';
import '../widgets/autovista_sidebar.dart';
import '../widgets/autovista_top_header.dart';

class AutovistaPage extends ConsumerStatefulWidget {
  const AutovistaPage({super.key});

  @override
  ConsumerState<AutovistaPage> createState() => _AutovistaPageState();
}

class _AutovistaPageState extends ConsumerState<AutovistaPage> {
  final ScrollController _scrollController = ScrollController();

  static const List<String> _topNavLinks = [
    'Home',
    'Our Fleet',
    'Rental Deals',
    'Services',
    'Locations',
    'About Us',
    'Insurance',
    'Contact',
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _selectTopNav(int idx) {
    ref.read(autovistaSelectedTopNavIdxProvider.notifier).state = idx;

    int sidebarIdx = ref.read(autovistaSelectedSidebarIdxProvider);
    if (idx == 0) {
      sidebarIdx = 0;
    } else if (idx == 1) {
      sidebarIdx = 1;
    } else if (idx == 2) {
      sidebarIdx = 5;
    } else if (idx == 3) {
      sidebarIdx = 6;
    } else if (idx == 4) {
      sidebarIdx = 7;
    } else if (idx == 7) {
      sidebarIdx = 8;
    }
    ref.read(autovistaSelectedSidebarIdxProvider.notifier).state = sidebarIdx;

    _scrollToTop();
  }

  void _selectSidebar(int idx) {
    int targetNav = 0;
    if (idx == 0) {
      targetNav = 0;
    } else if (idx >= 1 && idx <= 4) {
      targetNav = 1;
    } else if (idx == 5) {
      targetNav = 2;
    } else if (idx == 6) {
      targetNav = 3;
    } else if (idx == 7) {
      targetNav = 4;
    } else if (idx == 8) {
      targetNav = 7;
    }

    ref.read(autovistaSelectedSidebarIdxProvider.notifier).state = idx;
    ref.read(autovistaSelectedTopNavIdxProvider.notifier).state = targetNav;

    if (idx == 2) {
      ref.read(autovistaSelectedFleetFilterProvider.notifier).state =
          'Luxury Sedans';
    } else if (idx == 3) {
      ref.read(autovistaSelectedFleetFilterProvider.notifier).state =
          'Performance SUVs';
    } else if (idx == 4) {
      ref.read(autovistaSelectedFleetFilterProvider.notifier).state =
          'Electric & Hybrid';
    } else if (idx == 1) {
      ref.read(autovistaSelectedFleetFilterProvider.notifier).state =
          'All Vehicles';
    }

    _scrollToTop();
  }

  Widget _buildActiveContent(
    Size size,
    bool isDesktop,
    int selectedTopNavIdx,
    AutovistaPageDataEntity data,
  ) {
    switch (selectedTopNavIdx) {
      case 1:
        return AutovistaFleetScreen(
          isDesktop: isDesktop,
          allFleetCars: data.fleetCars,
        );
      case 2:
        return AutovistaDealsScreen(
          isDesktop: isDesktop,
          dealsCars: data.dealsCars,
          coupons: data.coupons,
        );
      case 3:
        return AutovistaServicesScreen(
          isDesktop: isDesktop,
          detailedServices: data.detailedServices,
        );
      case 4:
        return AutovistaLocationsScreen(
          isDesktop: isDesktop,
          hubs: data.hubs,
        );
      case 5:
        return AutovistaAboutScreen(isDesktop: isDesktop);
      case 6:
        return AutovistaInsuranceScreen(
          isDesktop: isDesktop,
          insurancePlans: data.insurancePlans,
        );
      case 7:
        return AutovistaContactScreen(isDesktop: isDesktop);
      case 0:
      default:
        return AutovistaHomeScreen(
          isDesktop: isDesktop,
          pageData: data,
          onNavigateToFleet: () => _selectTopNav(1),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1100;

    final selectedSidebarIdx = ref.watch(autovistaSelectedSidebarIdxProvider);
    final selectedTopNavIdx = ref.watch(autovistaSelectedTopNavIdxProvider);
    final pageDataAsync = ref.watch(autovistaPageDataProvider);

    return Scaffold(
      backgroundColor: AutovistaColors.scaffoldDark,
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Sidebar (Visible on Desktop)
              if (isDesktop)
                Container(
                  width: 230,
                  height: size.height,
                  color: AutovistaColors.headerDark,
                  child: AutovistaSidebar(
                    selectedSidebarIdx: selectedSidebarIdx,
                    onSelectSidebar: _selectSidebar,
                    onHelpClick: () => _selectTopNav(7),
                  ),
                ),

              // Main Content Viewport
              Expanded(
                child: Container(
                  color: AutovistaColors.viewportLight,
                  height: size.height,
                  child: pageDataAsync.when(
                    data: (data) => SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutovistaTopHeader(
                            isDesktop: isDesktop,
                            topNavLinks: _topNavLinks,
                            selectedTopNavIdx: selectedTopNavIdx,
                            onSelectTopNav: _selectTopNav,
                          ),
                          if (!isDesktop)
                            AutovistaMobileTopNav(
                              topNavLinks: _topNavLinks,
                              selectedIdx: selectedTopNavIdx,
                              onSelect: _selectTopNav,
                            ),
                          _buildActiveContent(
                            size,
                            isDesktop,
                            selectedTopNavIdx,
                            data,
                          ),
                          AutovistaFooter(isDesktop: isDesktop),
                        ],
                      ),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AutovistaColors.primaryRed,
                        ),
                      ),
                    ),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),

          // Floating Go Back to Portfolio Button (Top-Right)
          const Positioned(
            top: 16,
            right: 24,
            child: AutovistaFloatingBackButton(),
          ),
        ],
      ),
    );
  }
}
