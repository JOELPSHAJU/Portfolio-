import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joel_portfolio/core/widgets/scroll_video_hero.dart';
import '../sections/about_services/js_about_services_section.dart';
import '../sections/engineering/js_engineering_section.dart';
import '../sections/fleet/js_fleet_section.dart';
import '../sections/footer/js_footer_section.dart';
import '../sections/hero/js_construction_hero.dart';
import '../sections/leadership/js_leadership_section.dart';
import '../sections/projects/js_projects_section.dart';
import '../theme/js_construction_theme.dart';
import '../widgets/common/back_to_portfolio_pill.dart';

/// JS Constructions Masterwork Website Page (Clean Architecture Orchestrator)
class JsConstructionsPage extends ConsumerStatefulWidget {
  const JsConstructionsPage({super.key});

  @override
  ConsumerState<JsConstructionsPage> createState() =>
      _JsConstructionsPageState();
}

class _JsConstructionsPageState extends ConsumerState<JsConstructionsPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _telemetryKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _fleetKey = GlobalKey();
  final GlobalKey _capabilitiesKey = GlobalKey();
  final GlobalKey _teamKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  final ScrollVideoHeroController _videoHeroController =
      ScrollVideoHeroController();

  // Welding spark animation controller for realistic active site atmosphere
  late AnimationController _weldingAnimController;

  @override
  void initState() {
    super.initState();
    _weldingAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/about_const_bg.png'), context);
    precacheImage(
      const AssetImage('assets/construction_hero_cover.jpg'),
      context,
    );
    precacheImage(
      const AssetImage('assets/construction_project_tower.jpg'),
      context,
    );
    precacheImage(
      const AssetImage('assets/construction_project_cultural.jpg'),
      context,
    );
    precacheImage(
      const AssetImage('assets/construction_project_residential.jpg'),
      context,
    );
    precacheImage(const AssetImage('assets/constuction_fleet_bg.png'), context);
    precacheImage(
      const AssetImage('assets/foundation_construction_bg.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/technical_leadership_bg.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/construction_footer_bg.png'),
      context,
    );
    precacheImage(const AssetImage('assets/excavator.png'), context);
    precacheImage(const AssetImage('assets/wheel_loader.png'), context);
    precacheImage(const AssetImage('assets/dumper_truck.png'), context);
    precacheImage(const AssetImage('assets/motor_grader.png'), context);
    precacheImage(const AssetImage('assets/backhoe_loader.png'), context);
    precacheImage(const AssetImage('assets/soil_compactor.png'), context);
    precacheImage(const AssetImage('assets/bulldozer.png'), context);
    precacheImage(const AssetImage('assets/mini_excavator.png'), context);
    precacheImage(const AssetImage('assets/skid_steer.png'), context);
    precacheImage(const AssetImage('assets/worker_painting.png'), context);
    precacheImage(const AssetImage('assets/worker_engineer.png'), context);
    precacheImage(const AssetImage('assets/worker_welder.png'), context);
  }

  @override
  void dispose() {
    _videoHeroController.dispose();
    _scrollController.dispose();
    _weldingAnimController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToNextSection(double screenHeight) {
    _scrollController.animateTo(
      JsConstructionTheme.kVideoScrollDistance + screenHeight * 0.95,
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Scaffold(
      backgroundColor: JsConstructionTheme.kObsidian,
      body: Stack(
        children: [
          // ── 1. The Scroll-Driven Video Hero & Construction Site Gate ───────
          JsConstructionHero(
            scrollController: _scrollController,
            videoHeroController: _videoHeroController,
            onScrollToNext: () => _scrollToNextSection(screenSize.height),
            onExploreProjects: () => _scrollToKey(_projectsKey),
          ),

          // ── 2. The Continuous Construction Site Progression ───────────────
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height:
                      JsConstructionTheme.kVideoScrollDistance +
                      screenSize.height,
                ),

                // ZONE 01: OUR SERVICES & ABOUT SHOWCASE
                RepaintBoundary(
                  child: Container(
                    key: _telemetryKey,
                    child: JsAboutServicesSection(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      onOurServicesTap: () => _scrollToKey(_capabilitiesKey),
                    ),
                  ),
                ),

                // ZONE 02: STRUCTURAL STEEL DECK & ARCHITECTURAL MASTERWORKS
                RepaintBoundary(
                  child: Container(
                    key: _projectsKey,
                    child: JsProjectsSection(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                  ),
                ),

                // ZONE 03: ACTIVE TERRAFORMING PIT & HEAVY PLANT FLEET
                RepaintBoundary(
                  child: Container(
                    key: _fleetKey,
                    child: JsFleetSection(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                  ),
                ),

                // ZONE 04: ADVANCED ENGINEERING & PROPRIETARY CIVIL SYSTEMS
                RepaintBoundary(
                  child: Container(
                    key: _capabilitiesKey,
                    child: JsEngineeringSection(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                  ),
                ),

                // ZONE 05: FIELD COMMAND & MASTER BUILDER GUILD
                RepaintBoundary(
                  child: Container(
                    key: _teamKey,
                    child: JsLeadershipSection(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                    ),
                  ),
                ),

                // ZONE 06: SITE EGRESS & SAFETY COMPLIANCE AUDIT FOOTER
                RepaintBoundary(
                  child: Container(
                    key: _contactKey,
                    child: JsFooterSection(
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      onHomeTap: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                      onAboutUsTap: () => _scrollToKey(_telemetryKey),
                      onServicesTap: () => _scrollToKey(_capabilitiesKey),
                      onProjectsTap: () => _scrollToKey(_projectsKey),
                      onContactTap: () => _scrollToKey(_contactKey),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Top-Right Floating Back to Portfolio Pill ────────────────────
          const Positioned(
            top: 16,
            right: 16,
            child: SafeArea(child: BackToPortfolioPill()),
          ),
        ],
      ),
    );
  }
}
