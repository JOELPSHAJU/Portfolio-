import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';

class JsConstructionsWebsiteScreen extends StatefulWidget {
  const JsConstructionsWebsiteScreen({super.key});

  @override
  State<JsConstructionsWebsiteScreen> createState() =>
      _JsConstructionsWebsiteScreenState();
}

class _JsConstructionsWebsiteScreenState
    extends State<JsConstructionsWebsiteScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier<double>(0.0);

  // High-Precision Native Scroll-Video Engine
  late VideoPlayerController _forwardController;
  bool _isInitialized = false;
  bool _hasError = false;

  bool _isSeeking = false;
  int _targetMs = 0;
  int _lastSeekedMs = -1;
  Duration? _pendingSeek;
  bool _isAutoTourRunning = false;

  // Selected project category filter
  String _selectedCategory = 'all';

  // Selected earthmoving machinery index (Excavator default, matching reference)
  int _selectedFleetIndex = 2;
  int _fleetNavDirection = 1; // 1 for next (slide left), -1 for prev (slide right)
  final ScrollController _fleetThumbScrollController = ScrollController();

  void _selectFleet(int newIndex, {int? direction}) {
    if (newIndex == _selectedFleetIndex) return;
    final int dir = direction ?? (newIndex > _selectedFleetIndex ? 1 : -1);
    setState(() {
      _fleetNavDirection = dir;
      _selectedFleetIndex = newIndex;
    });

    if (_fleetThumbScrollController.hasClients) {
      const double itemWidth = 142.0; // card width + separator padding
      final double targetOffset = (newIndex * itemWidth - 140.0).clamp(
        0.0,
        _fleetThumbScrollController.position.maxScrollExtent,
      );
      _fleetThumbScrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
      );
    }
  }

  // Welding spark animation controller for realistic active site atmosphere
  late AnimationController _weldingAnimController;

  // Earthmoving Heavy Plant & Machinery Fleet (9 machines matching reference lineup)
  final List<Map<String, dynamic>> _fleetMachinery = [
    {
      'name': 'RIGID FRAME DUMP TRUCK',
      'label': 'Dump Truck',
      'model': 'CATERPILLAR 740B',
      'role': 'Mass Earthwork Haulage & Spoil Removal',
      'image': 'assets/dumper_truck.png',
      'thumb': 'assets/dumper_truck.png',
      'weight': '31,800 KG',
      'power': '440 HP (328 kW)',
      'depth': '23 m³ Body',
      'speed': '55 KM/H Loaded',
      'tag': 'MASS HAULAGE',
      'zone': 'SECTOR 04: SPOIL HAUL',
      'serial': 'JS-CAT-740B-HAUL',
      'desc': 'Articulated hauler for rapid high-volume soil and aggregate logistics across site. Features Caterpillar traction control, automatic retarder and ejector body for confined tipping.',
    },
    {
      'name': 'HEAVY FRONT WHEEL LOADER',
      'label': 'Wheel Loader',
      'model': 'CATERPILLAR 966M',
      'role': 'Aggregate, Gravel & Crushed Granite Logistics',
      'image': 'assets/wheel_loader.png',
      'thumb': 'assets/wheel_loader.png',
      'weight': '23,220 KG',
      'power': '276 HP (206 kW)',
      'depth': '4.2 m³ Bucket',
      'speed': '39.5 KM/H Transport',
      'tag': 'SITE LOGISTICS',
      'zone': 'SECTOR 02: AGGREGATE HAUL',
      'serial': 'JS-CAT-966M-HEAVY',
      'desc': 'Transports high-density sub-base aggregates, crushed granite, and structural drainage gravel from staging portals to villa foundation footings with hydrostatic four-wheel drive.',
    },
    {
      'name': 'TRACKED HYDRAULIC EXCAVATOR',
      'label': 'Excavator',
      'model': 'CATERPILLAR 336D',
      'role': 'Cliffside Foundation & Deep Bore Trenching',
      'image': 'assets/excavator.png',
      'thumb': 'assets/excavator.png',
      'weight': '36,200 KG',
      'power': '275 HP (205 kW)',
      'depth': '7.45 METERS',
      'speed': '0.8s Boom Cycle',
      'tag': 'HEAVY EARTHMOVING',
      'zone': 'SECTOR 01: TERRAFORMING',
      'serial': 'JS-CAT-336D-REV4',
      'desc': 'Primary earth-sculpting powerhouse deployed on rocky coastal villa lots. Engineered with heavy counterweight, breaker hammer attachments for solid bedrock, and laser-guided trench accuracy.',
    },
    {
      'name': 'MOTOR GRADER',
      'label': 'Motor Grader',
      'model': 'CATERPILLAR 140M3',
      'role': 'Road Formation & Fine Subgrade Profiling',
      'image': 'assets/motor_grader.png',
      'thumb': 'assets/motor_grader.png',
      'weight': '15,900 KG',
      'power': '175 HP (130 kW)',
      'depth': '4.27m Moldboard',
      'speed': 'GPS Grade Control ±3mm',
      'tag': 'ROAD FORMATION',
      'zone': 'SECTOR 07: ROADWAYS',
      'serial': 'JS-CAT-140M3-GRD',
      'desc': 'All-wheel drive grader with electro-hydraulic controls and Cat Grade with Slope Assist for precise road crowning, drainage channels and access road formation on residential developments.',
    },
    {
      'name': 'HYDRAULIC BACKHOE LOADER',
      'label': 'Backhoe Loader',
      'model': 'JOHN DEERE 310L',
      'role': 'Underground MEP, Drainage & Utility Trenching',
      'image': 'assets/backhoe_loader.png',
      'thumb': 'assets/backhoe_loader.png',
      'weight': '8,200 KG',
      'power': '110 HP Turbo',
      'depth': '4.32 METERS',
      'speed': '4x4 PowerShift',
      'tag': 'PRECISION UTILITIES',
      'zone': 'SECTOR 08: UTILITY CONDUITS',
      'serial': 'JS-JD-310L-MEP',
      'desc': 'Dual-ended versatility for high-precision underground infrastructure. Excavates trenches for geothermal loops, electrical substations, and storm-water retention vaults on villa grounds.',
    },
    {
      'name': 'VIBRATORY SOIL COMPACTOR',
      'label': 'Roller',
      'model': 'CATERPILLAR CS56B',
      'role': 'Sub-Base & Fill Compaction to Spec',
      'image': 'assets/soil_compactor.png',
      'thumb': 'assets/soil_compactor.png',
      'weight': '11,200 KG',
      'power': '130 HP (97 kW)',
      'depth': '500mm Lift Layer',
      'speed': '56kN Centrifugal Force',
      'tag': 'COMPACTION',
      'zone': 'SECTOR 06: EARTHWORK DENSITY',
      'serial': 'JS-CAT-CS56B-COMP',
      'desc': 'Single-drum vibratory roller with intelligent compaction technology, real-time stiffness mapping and GPS pass-count logging for certified sub-grade density on villa foundation pads.',
    },
    {
      'name': 'HEAVY CRAWLER BULLDOZER',
      'label': 'Bulldozer',
      'model': 'CATERPILLAR D8T',
      'role': 'Slope Terraforming & Foundation Pad Leveling',
      'image': 'assets/bulldozer.png',
      'thumb': 'assets/bulldozer.png',
      'weight': '39,420 KG',
      'power': '310 HP (231 kW)',
      'depth': '8.7 m³ SU Blade',
      'speed': 'Automated Laser Grade',
      'tag': 'PAD TERRAFORMING',
      'zone': 'SECTOR 03: SUB-GRADE LEVELING',
      'serial': 'JS-CAT-D8T-TERRA',
      'desc': 'Equipped with single-shank rippers to fracture hard pan soil and a massive semi-universal blade to sculpt multi-tiered cantilevered villa terraces to exact millimeter architectural grading.',
    },
    {
      'name': 'COMPACT MINI EXCAVATOR',
      'label': 'Mini Excavator',
      'model': 'CATERPILLAR 308E2',
      'role': 'Confined Access & Precision Utility Trenching',
      'image': 'assets/mini_excavator.png',
      'thumb': 'assets/mini_excavator.png',
      'weight': '8,060 KG',
      'power': '47.6 HP (35.5 kW)',
      'depth': '3.69 METERS',
      'speed': 'Zero-Tail Swing',
      'tag': 'PRECISION ACCESS',
      'zone': 'SECTOR 05: CONFINED WORKS',
      'serial': 'JS-CAT-308E2-MINI',
      'desc': 'Compact zero-tail-swing excavator navigating restricted-access villa courtyards, underground garages and landscaped terraces for precision MEP trenching without disturbing finished surfaces.',
    },
    {
      'name': 'COMPACT TRACK SKID STEER',
      'label': 'Skid Steer Loader',
      'model': 'BOBCAT T770',
      'role': 'Courtyard Grading & Confined Terraforming',
      'image': 'assets/skid_steer.png',
      'thumb': 'assets/skid_steer.png',
      'weight': '4,680 KG',
      'power': '92 HP Tier-4',
      'depth': '1,575 KG Lift',
      'speed': 'High-Flow Hydraulics',
      'tag': 'CONFINED MASONRY',
      'zone': 'SECTOR 09: COURTYARD PLAZA',
      'serial': 'JS-BC-T770-COMPACT',
      'desc': 'Compact powerhouse capable of navigating narrow villa courtyard breezeways, underground garage portals, and cantilevered terrace infinity pools for fine sub-grade leveling.',
    },
  ];


  // Section global keys for smooth scrolling navigation through site zones
  final GlobalKey _telemetryKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _fleetKey = GlobalKey();
  final GlobalKey _capabilitiesKey = GlobalKey();
  final GlobalKey _teamKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Scroll distance dedicated to scrubbing the video from 0:00 to end
  static const double kVideoScrollDistance = 2400.0;

  // Ultra-Realistic Architectural Construction Palette
  static const Color kObsidian = Color(0xFF090A0E);
  static const Color kSiteCharcoal = Color(0xFF12141A);
  static const Color kConcreteDark = Color(0xFF1A1D24);
  static const Color kConcreteSurface = Color(0xFF222630);
  static const Color kSteel = Color(0xFFE2E8F0);
  static const Color kSteelMuted = Color(0xFF94A3B8);
  static const Color kSafetyAmber = Color(0xFFFF9F1C);
  static const Color kSafetyAmberGlow = Color(0xFFFBBF24);
  static const Color kBlueprintCyan = Color(0xFF00C0FF);
  static const Color kSiteBorder = Color(0xFF2E3444);

  @override
  void initState() {
    super.initState();
    _weldingAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _initVideo();
    _scrollController.addListener(_handleScrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/about_const_bg.png'), context);
    precacheImage(const AssetImage('assets/construction_hero_cover.jpg'), context);
    precacheImage(const AssetImage('assets/construction_project_tower.jpg'), context);
    precacheImage(const AssetImage('assets/construction_project_cultural.jpg'), context);
    precacheImage(const AssetImage('assets/construction_project_residential.jpg'), context);
    precacheImage(const AssetImage('assets/constuction_fleet_bg.png'), context);
    precacheImage(const AssetImage('assets/foundation_construction_bg.png'), context);
    precacheImage(const AssetImage('assets/technical_leadership_bg.png'), context);
    precacheImage(const AssetImage('assets/construction_footer_bg.png'), context);
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

  Future<void> _initVideo() async {
    try {
      _forwardController = VideoPlayerController.asset(
        'assets/construction_introd.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await _forwardController.initialize();
      await _forwardController.setVolume(0.0);
      await _forwardController.setLooping(false);

      // Prime opening frame at start
      await _forwardController.seekTo(Duration.zero);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _handleScrollListener();
      }
    } catch (e) {
      debugPrint('Construction intro video init error: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _handleScrollListener() {
    if (!_scrollController.hasClients) return;
    final currentOffset = _scrollController.offset;
    _scrollOffsetNotifier.value = currentOffset;

    if (!_isInitialized || _hasError) return;

    final totalDuration = _forwardController.value.duration;
    if (totalDuration == Duration.zero) return;
    final int totalMs = totalDuration.inMilliseconds > 0
        ? totalDuration.inMilliseconds
        : 10000;

    // Linear progress ratio strictly clamped from 0.0 (start) to 1.0 (finish)
    final double progress = (currentOffset / kVideoScrollDistance).clamp(
      0.0,
      1.0,
    );
    _targetMs = (progress * totalMs).round();

    _syncVideoToTarget();
  }

  void _syncVideoToTarget() {
    if (!_isInitialized || _hasError) return;
    final totalDuration = _forwardController.value.duration;
    if (totalDuration == Duration.zero) return;
    final int totalMs = totalDuration.inMilliseconds;

    final int target = _targetMs.clamp(0, totalMs);

    // If a seek is currently in flight, record this as the pending seek target
    if (_isSeeking) {
      _pendingSeek = Duration(milliseconds: target);
      return;
    }

    // Skip redundant seeks if already positioned within fine tolerance (15ms)
    if ((_lastSeekedMs - target).abs() < 15) {
      return;
    }

    _isSeeking = true;
    _lastSeekedMs = target;
    final seekDuration = Duration(milliseconds: target);

    if (_forwardController.value.isPlaying) {
      _forwardController.pause();
    }

    _forwardController.seekTo(seekDuration).then((_) {
      _isSeeking = false;
      if (_pendingSeek != null) {
        final pending = _pendingSeek!;
        _pendingSeek = null;
        if ((pending.inMilliseconds - _lastSeekedMs).abs() >= 15) {
          _targetMs = pending.inMilliseconds;
          _syncVideoToTarget();
        }
      }
    }).catchError((error) {
      _isSeeking = false;
      debugPrint('Video seek error: $error');
    });
  }

  void _toggleAutoTour() {
    if (_isAutoTourRunning) {
      _stopAutoTour();
    } else {
      _startAutoTour();
    }
  }

  void _startAutoTour() {
    if (!_scrollController.hasClients || !_isInitialized || _hasError) return;
    final totalDuration = _forwardController.value.duration;
    final int totalMs = totalDuration.inMilliseconds > 0
        ? totalDuration.inMilliseconds
        : 8000;

    final double currentOffset = _scrollController.offset;
    if (currentOffset >= kVideoScrollDistance) {
      _scrollController.jumpTo(0.0);
    }

    setState(() {
      _isAutoTourRunning = true;
    });

    final double startOffset = _scrollController.offset;
    final double remainingFraction =
        ((kVideoScrollDistance - startOffset) / kVideoScrollDistance)
            .clamp(0.05, 1.0);
    final int animDurationMs = (totalMs * remainingFraction).round();

    _scrollController
        .animateTo(
          kVideoScrollDistance,
          duration: Duration(milliseconds: animDurationMs),
          curve: Curves.linear,
        )
        .then((_) {
          if (mounted) {
            setState(() {
              _isAutoTourRunning = false;
            });
          }
        });
  }

  void _stopAutoTour() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.offset);
    }
    if (mounted) {
      setState(() {
        _isAutoTourRunning = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScrollListener);
    _scrollOffsetNotifier.dispose();
    _scrollController.dispose();
    _weldingAnimController.dispose();
    _fleetThumbScrollController.dispose();
    if (_isInitialized) {
      _forwardController.dispose();
    }
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
      kVideoScrollDistance + screenHeight * 0.95,
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOutCubic,
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SIGNATURE PROJECTS DATA
  // ════════════════════════════════════════════════════════════════════════════
  final List<Map<String, dynamic>> _projects = [
    {
      'id': 'solis_villa_estate',
      'title': 'THE SOLIS CLIFF VILLA SITE',
      'category': 'residential',
      'location': 'Porto Cervo, Costa Smeralda',
      'height': '4 Levels • 4,800 m² Active Site',
      'spec': 'Bored Micro-Piles, Exposed Board-Form Concrete & Steel Formwork',
      'image': 'assets/villa_construction_site.jpg',
      'status': 'ACTIVE VILLA SLAB FORMWORK',
      'year': '2026',
      'budget': '\$95 Million',
      'architect': 'JS Master Villa Atelier',
      'badge': 'VILLA SITE ACTIVE',
      'drawingCode': 'DWG-VIL-2026-A01',
      'elevation': '+48.50M CLIFF GRADE',
      'desc':
          'Multi-tiered architectural luxury villa under active construction. Engineered with retaining earth shoring, seismic concrete columns, cantilevered deck formwork, and heavy machinery grading.',
    },
    {
      'id': 'aethelred_tower',
      'title': 'THE AETHELRED MONOLITH',
      'category': 'commercial',
      'location': 'Financial District, Manhattan',
      'height': '465 Meters • 104 Floors',
      'spec': 'High-Strength ASTM A992 Steel & Unitized Curtain Wall',
      'image': 'assets/construction_project_tower.jpg',
      'status': 'STRUCTURAL TOP-OUT',
      'year': '2026',
      'budget': '\$1.85 Billion',
      'architect': 'Foster + Partners Collaborator',
      'badge': 'SUPERTALL MONOLITH',
      'drawingCode': 'DWG-SUP-2026-T104',
      'elevation': '+465.00M TOP-OUT',
      'desc':
          'A landmark commercial supertall rising 465 meters above the Hudson. Features seismic viscous dampers, high-strength composite concrete core, and hyper-insulated acoustic glass facades.',
    },
    {
      'id': 'civic_arts_pavilion',
      'title': 'CIVIC ARCHITECTURAL PAVILION',
      'category': 'civic',
      'location': 'Cultural District, Lakefront',
      'height': '48m Arch Span • 24,000 m²',
      'spec': 'Post-Tensioned Curved Concrete & Titanium Panels',
      'image': 'assets/construction_project_cultural.jpg',
      'status': 'PRECISION FACADE FINISHING',
      'year': '2025',
      'budget': '\$640 Million',
      'architect': 'Zaha Hadid Design Guild',
      'badge': 'PARAMETRIC CIVIC',
      'drawingCode': 'DWG-CIV-2025-P48',
      'elevation': '+32.00M VAULT CREST',
      'desc':
          'A breathtaking sweeping architectural shell featuring 140-meter post-tensioned double-curved self-consolidating concrete vaults, cantilevered structural glass, and expansive reflecting pools.',
    },
    {
      'id': 'mirage_cliffside',
      'title': 'MIRAGE CLIFFSIDE RESIDENCE',
      'category': 'residential',
      'location': 'Cap Ferrat Peninsula, French Riviera',
      'height': '3 Levels • 3,200 m²',
      'spec': 'Cantilevered Post-Tensioned Slabs & Travertine',
      'image': 'assets/construction_project_residential.jpg',
      'status': 'INTERIOR FIT-OUT',
      'year': '2026',
      'budget': '\$185 Million',
      'architect': 'JS Private Atelier',
      'badge': 'PRIVATE ESTATE',
      'drawingCode': 'DWG-RES-2026-C18',
      'elevation': '+82.00M SEACLIFF',
      'desc':
          'Master-built into a sheer limestone Riviera precipice. Features 18-meter cantilevered concrete terraces, subterranean wine caves, heated horizon infinity edge pool, and helipad landing strip.',
    },
    {
      'id': 'hyperion_spire',
      'title': 'HYPERION SKY TOWER & RESIDENCES',
      'category': 'commercial',
      'location': 'Downtown Financial Center',
      'height': '380 Meters • 88 Floors',
      'spec': 'Carbon-Cured Concrete & Solar Photovoltaic Skin',
      'image': 'assets/construction_hero_cover.jpg',
      'status': 'UNDER CONSTRUCTION',
      'year': '2027',
      'budget': '\$1.42 Billion',
      'architect': 'SOM Architects Associated',
      'badge': 'NET-ZERO SUPERTALL',
      'drawingCode': 'DWG-HYP-2027-S88',
      'elevation': '+380.00M CROWN SPIRE',
      'desc':
          'Next-generation mixed-use supertall engineered with proprietary CO2-mineralized concrete, rooftop vertical wind turbines, and biometric smart vertical transportation.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Scaffold(
      backgroundColor: kObsidian,
      body: Stack(
        children: [
          // ── 1. The Scroll-Driven Video Hero & Construction Site Gate ───────
          ValueListenableBuilder<double>(
            valueListenable: _scrollOffsetNotifier,
            builder: (context, scrollOffset, _) {
              double translateY = 0.0;
              if (scrollOffset > kVideoScrollDistance) {
                translateY = -(scrollOffset - kVideoScrollDistance);
              }

              if (translateY <= -screenSize.height) {
                return const SizedBox.shrink();
              }

              final progress = (scrollOffset / kVideoScrollDistance).clamp(
                0.0,
                1.0,
              );

              return RepaintBoundary(
                child: Transform.translate(
                  offset: Offset(0, translateY),
                  child: SizedBox(
                    width: screenSize.width,
                    height: screenSize.height,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Video Player (High-Precision Native Video Engine)
                        if (_isInitialized && !_hasError)
                          FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: _forwardController.value.size.width > 0
                                  ? _forwardController.value.size.width
                                  : 1280,
                              height: _forwardController.value.size.height > 0
                                  ? _forwardController.value.size.height
                                  : 720,
                              child: VideoPlayer(_forwardController),
                            ),
                          )
                        else
                          Container(
                            color: kObsidian,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: kSafetyAmber,
                                strokeWidth: 2,
                              ),
                            ),
                          ),

                        // Atmospheric Dust & Lighting Shader Overlay
                        CustomPaint(
                          painter: _AtmosphericDustPainter(progress: progress),
                        ),

                        // Architectural Heavy Scrims (Unreal Engine archviz grading)
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.75),
                                Colors.black.withValues(alpha: 0.25),
                                Colors.black.withValues(alpha: 0.88),
                              ],
                              stops: const [0.0, 0.40, 1.0],
                            ),
                          ),
                        ),

                        // Vignette & Peripheral Occlusion
                        Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 1.25,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.65),
                              ],
                              stops: const [0.50, 1.0],
                            ),
                          ),
                        ),

                        // Structural Steel Gantry Perimeter Overlay (Site Entrance Frame)
                        if (isDesktop)
                          Positioned.fill(
                            child: IgnorePointer(
                              child: CustomPaint(
                                painter: _SiteGantryFramePainter(),
                              ),
                            ),
                          ),

                        // Staged Narrative Environmental Overlays
                        _buildTimedOverlays(progress, isDesktop),

                        // Scroll Down & Autoplay Directive Controls
                        if (progress < 0.20)
                          Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Opacity(
                              opacity: (1.0 - progress / 0.20).clamp(0.0, 1.0),
                              child: Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12,
                                  runSpacing: 10,
                                  children: [
                                    InkWell(
                                      onTap: () => _scrollToNextSection(screenSize.height),
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 22,
                                          vertical: 11,
                                        ),
                                        decoration: BoxDecoration(
                                          color: kSiteCharcoal.withValues(alpha: 0.90),
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: kSafetyAmber,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: kSafetyAmber.withValues(alpha: 0.35),
                                              blurRadius: 18,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.engineering_rounded,
                                              color: kSafetyAmber,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'SCROLL TO EXPLORE (START TO FINISH)',
                                              style: GoogleFonts.spaceGrotesk(
                                                color: kSteel,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: kSafetyAmber,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _toggleAutoTour,
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 11,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _isAutoTourRunning
                                              ? kSafetyAmber
                                              : kSiteCharcoal.withValues(alpha: 0.90),
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(
                                            color: kSafetyAmber,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: kSafetyAmber.withValues(
                                                alpha: _isAutoTourRunning ? 0.5 : 0.2,
                                              ),
                                              blurRadius: 16,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _isAutoTourRunning
                                                  ? Icons.pause_rounded
                                                  : Icons.play_arrow_rounded,
                                              color: _isAutoTourRunning
                                                  ? kObsidian
                                                  : kSafetyAmber,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _isAutoTourRunning
                                                  ? 'PAUSE TOUR'
                                                  : 'AUTOPLAY FULL TIMELINE',
                                              style: GoogleFonts.spaceGrotesk(
                                                color: _isAutoTourRunning
                                                    ? kObsidian
                                                    : kSteel,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
                SizedBox(height: kVideoScrollDistance + screenSize.height),

                // ZONE 01: OUR SERVICES & ABOUT SHOWCASE
                RepaintBoundary(
                  child: Container(
                    key: _telemetryKey,
                    child: _buildZone01AboutServices(isDesktop, isTablet),
                  ),
                ),

                // ZONE 02: STRUCTURAL STEEL DECK & ARCHITECTURAL MASTERWORKS
                RepaintBoundary(
                  child: Container(
                    key: _projectsKey,
                    child: _buildZone02Masterworks(isDesktop, isTablet),
                  ),
                ),

                // ZONE 03: ACTIVE TERRAFORMING PIT & HEAVY PLANT FLEET
                RepaintBoundary(
                  child: Container(
                    key: _fleetKey,
                    child: _buildZone03Fleet(isDesktop, isTablet),
                  ),
                ),

                // ZONE 04: ADVANCED ENGINEERING & PROPRIETARY CIVIL SYSTEMS
                RepaintBoundary(
                  child: Container(
                    key: _capabilitiesKey,
                    child: _buildZone04Engineering(isDesktop, isTablet),
                  ),
                ),

                // ZONE 05: FIELD COMMAND & MASTER BUILDER GUILD
                RepaintBoundary(
                  child: Container(
                    key: _teamKey,
                    child: _buildZone05LeadershipGuild(isDesktop, isTablet),
                  ),
                ),

                // ZONE 06: PROJECT MANAGEMENT FIELD OFFICE & TENDER (RFP)
                RepaintBoundary(
                  child: Container(
                    key: _contactKey,
                    child: _buildZone06SiteOfficeTender(isDesktop, isTablet),
                  ),
                ),

                // ZONE 07: SITE EGRESS & SAFETY COMPLIANCE AUDIT FOOTER
                RepaintBoundary(
                  child: _buildZone07EgressFooter(isDesktop, isTablet),
                ),
              ],
            ),
          ),

          // ── Top-Right Floating Back to Portfolio Pill ────────────────────
          Positioned(
            top: 16,
            right: 16,
            child: SafeArea(child: _buildBackToPortfolioPill()),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // TIMED OVERLAYS: SITE ENTRANCE STAGES
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTimedOverlays(double progress, bool isDesktop) {
    final opacity1 = _calculateOverlayOpacity(progress, 0.00, 0.28);
    final opacity2 = _calculateOverlayOpacity(progress, 0.28, 0.58);
    final opacity3 = _calculateOverlayOpacity(progress, 0.58, 0.85);
    final opacity4 = _calculateOverlayOpacity(progress, 0.85, 1.00);

    return Stack(
      children: [
        if (opacity1 > 0.01) _buildStage1Entrance(isDesktop, opacity1),
        if (opacity2 > 0.01) _buildStage2Structural(isDesktop, opacity2),
        if (opacity3 > 0.01) _buildStage3CivilInfrastructure(isDesktop, opacity3),
        if (opacity4 > 0.01) _buildStage4MasterworkGate(isDesktop, opacity4),
      ],
    );
  }

  double _calculateOverlayOpacity(double progress, double start, double end) {
    if (progress < start || progress > end) return 0.0;
    final span = end - start;
    final mid = start + span / 2;

    if (start == 0.0) {
      if (progress <= 0.18) return 1.0;
      return (1.0 - ((progress - 0.18) / 0.10)).clamp(0.0, 1.0);
    }
    if (end == 1.0) {
      return ((progress - start) / (span * 0.4)).clamp(0.0, 1.0);
    }
    if (progress <= mid) {
      return ((progress - start) / (span * 0.3)).clamp(0.0, 1.0);
    } else {
      return (1.0 - ((progress - mid) / (span * 0.5))).clamp(0.0, 1.0);
    }
  }

  // ── Stage 1: SITE ENTRANCE & OFFICIAL PROJECT IDENTIFICATION BOARD ────────
  Widget _buildStage1Entrance(bool isDesktop, double opacity) {
    return Stack(
      children: [
        Positioned(
          top: isDesktop ? 90 : 64,
          left: isDesktop ? 60 : 20,
          right: isDesktop ? null : 20,
          child: Opacity(
            opacity: opacity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 780 : double.infinity,
              ),
              child: _SiteEntranceSignBoard(
                isDesktop: isDesktop,
                badge: isDesktop
                    ? 'GLOBAL EPC CLASS A  •  ZERO-INCIDENT SAFETY  •  EST. 1994'
                    : 'GLOBAL EPC BUILDERS  •  EST. 1994',
                title: 'JS CONSTRUCTIONS\nGROUP',
                subtitle: 'ENGINEERING MONUMENTAL FUTURES',
                body:
                    'Architectural master-builders creating the worlds most daring supertall commercial towers, post-tensioned civil infrastructure, and ultra-prime private estates.',
              ),
            ),
          ),
        ),

        // Bottom-Right Live Site Telemetry HUD
        Positioned(
          bottom: 38,
          right: isDesktop ? 60 : 20,
          child: Opacity(
            opacity: opacity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFieldTelemetryChip(
                  icon: Icons.shield_rounded,
                  label: 'ZERO-INCIDENT OSHA',
                  val: '18M MAN-HOURS',
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 12),
                  _buildFieldTelemetryChip(
                    icon: Icons.corporate_fare_rounded,
                    label: 'ACTIVE CONTRACTS',
                    val: '\$4.8B CONTRACTED',
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Stage 2: STRUCTURAL METALLURGY ERECTION ZONE ──────────────────────────
  Widget _buildStage2Structural(bool isDesktop, double opacity) {
    return Positioned(
      top: isDesktop ? 110 : 80,
      right: isDesktop ? 60 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 660 : double.infinity,
          ),
          child: _SiteErectionNoticeBoard(
            isDesktop: isDesktop,
            alignRight: isDesktop,
            tag: '01 / STRUCTURAL METALLURGY',
            title: 'SUPERTALL TOWERS &\nTITANIUM EXOSKELETONS',
            accent: 'ROBOTIC WELDING & HIGH-TENSILE GRADE 65 STEEL',
            desc:
                'High-tensile Grade 65 structural steel trusses fabricated with robotic automated welding, capable of withstanding Cat 5 hurricane wind loads and seismic shear.',
          ),
        ),
      ),
    );
  }

  // ── Stage 3: MASSIVE CIVIL INFRASTRUCTURE & POST-TENSIONED SLABS ──────────
  Widget _buildStage3CivilInfrastructure(bool isDesktop, double opacity) {
    return Positioned(
      top: isDesktop ? 130 : 80,
      left: isDesktop ? 60 : 20,
      right: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 680 : double.infinity,
          ),
          child: _SiteErectionNoticeBoard(
            isDesktop: isDesktop,
            alignRight: false,
            tag: '02 / MASSIVE INFRASTRUCTURE',
            title: 'POST-TENSIONED CONCRETE &\nPARAMETRIC ARCHITECTURE',
            accent: 'CARBON-CURED CONCRETE & LASER GPS LEVELING',
            desc:
                'Specialized high-density, carbon-cured concrete poured with precision laser GPS leveling, achieving 120-year design life across ports, bridges, and civic landmarks.',
          ),
        ),
      ),
    );
  }

  // ── Stage 4: PORTFOLIO ACCESS PORTAL ──────────────────────────────────────
  Widget _buildStage4MasterworkGate(bool isDesktop, double opacity) {
    return Positioned(
      bottom: isDesktop ? 65 : 40,
      right: isDesktop ? 60 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 640 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment:
                isDesktop ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDesktop) ...[
                    Container(width: 24, height: 3, color: kSafetyAmber),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '03 / MASTERWORK COLLECTION',
                    style: GoogleFonts.spaceGrotesk(
                      color: kSafetyAmber,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 8),
                    Container(width: 24, height: 3, color: kSafetyAmber),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'PRECISION CRAFT\nAT SCALE',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.plusJakartaSans(
                  color: kSteel,
                  fontSize: isDesktop ? 54 : 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isDesktop ? -1.5 : -0.6,
                  height: 1.04,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'EXPLORE COMPLETED & ACTIVE MEGASPACES',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.spaceGrotesk(
                  color: kSafetyAmberGlow,
                  fontSize: isDesktop ? 13 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 18),
              InkWell(
                onTap: () => _scrollToKey(_projectsKey),
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 26 : 18,
                    vertical: isDesktop ? 15 : 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kSafetyAmber, Color(0xFFD97706)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: kSafetyAmber.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'INSPECT ACTIVE SITE WORKS',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: isDesktop ? 12 : 10.5,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 01: OUR SERVICES & ABOUT SHOWCASE (Building Today for a Stronger Tomorrow)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildZone01AboutServices(bool isDesktop, bool isTablet) {
    const goldColor = Color(0xFFDF9B35);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isDesktop ? 760 : (isTablet ? 680 : 580),
      ),
      color: Colors.black,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // 1. Full-bleed background image of excavator, sunset, and construction site
          Positioned.fill(
            child: Image.asset(
              'assets/about_const_bg.png',
              fit: BoxFit.cover,
              alignment: isDesktop ? Alignment.centerRight : Alignment.center,
            ),
          ),

          // 2. High-contrast left-to-right gradient overlay keeping excavator visible
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isDesktop
                      ? [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.74),
                          Colors.black.withValues(alpha: 0.45),
                          Colors.black.withValues(alpha: 0.10),
                          Colors.transparent,
                        ]
                      : (isTablet
                          ? [
                              Colors.black.withValues(alpha: 0.88),
                              Colors.black.withValues(alpha: 0.80),
                              Colors.black.withValues(alpha: 0.52),
                              Colors.black.withValues(alpha: 0.20),
                            ]
                          : [
                              Colors.black.withValues(alpha: 0.92),
                              Colors.black.withValues(alpha: 0.85),
                              Colors.black.withValues(alpha: 0.70),
                              Colors.black.withValues(alpha: 0.45),
                            ]),
                  stops: isDesktop
                      ? const [0.0, 0.35, 0.54, 0.74, 0.92]
                      : (isTablet
                          ? const [0.0, 0.42, 0.72, 1.0]
                          : const [0.0, 0.40, 0.75, 1.0]),
                ),
              ),
            ),
          ),

          // 3. Subtle top and bottom blend vignettes
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.50),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.60),
                  ],
                  stops: const [0.0, 0.10, 0.90, 1.0],
                ),
              ),
            ),
          ),

          // 4. Foreground Content Column (Left Aligned matching mockup)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
              vertical: isDesktop ? 80 : (isTablet ? 60 : 45),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop
                        ? math.min(540.0, screenWidth * 0.46)
                        : (isTablet ? math.min(500.0, screenWidth * 0.75) : double.infinity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Eyebrow: OUR SERVICES —
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'OUR SERVICES',
                            style: GoogleFonts.outfit(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.4,
                              color: goldColor,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Container(
                            width: 32,
                            height: 2,
                            decoration: BoxDecoration(
                              color: goldColor,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Headline: Building Today for a Stronger Tomorrow
                      Text(
                        'Building Today\nfor a Stronger\nTomorrow',
                        style: GoogleFonts.outfit(
                          fontSize: isDesktop ? 48 : (isTablet ? 36 : 28),
                          fontWeight: FontWeight.w800,
                          height: 1.14,
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Paragraph Description
                      Text(
                        'From earthmoving to final finishes, we handle every phase of construction with precision, safety and a commitment to excellence.',
                        style: GoogleFonts.outfit(
                          fontSize: isDesktop ? 15.5 : 14.5,
                          fontWeight: FontWeight.w400,
                          height: 1.58,
                          color: const Color(0xFFCBD5E1),
                          letterSpacing: 0.15,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Feature 1: Earthworks & Excavation
                      _buildAboutServiceFeatureRow(
                        iconPainter: const _ExcavatorIconPainter(),
                        title: 'Earthworks & Excavation',
                        description:
                            'Site preparation and excavation with modern equipment and skilled operators.',
                      ),
                      const SizedBox(height: 22),

                      // Feature 2: Skilled Workforce
                      _buildAboutServiceFeatureRow(
                        iconPainter: const _WorkerIconPainter(),
                        title: 'Skilled Workforce',
                        description:
                            'Experienced professionals dedicated to quality and timely delivery.',
                      ),
                      const SizedBox(height: 22),

                      // Feature 3: Safety First
                      _buildAboutServiceFeatureRow(
                        iconPainter: const _SafetyShieldIconPainter(),
                        title: 'Safety First',
                        description:
                            'We maintain strict safety standards on every site, every day.',
                      ),
                      const SizedBox(height: 38),

                      // Button: OUR SERVICES →
                      _AboutServicesButton(
                        onTap: () => _scrollToKey(_capabilitiesKey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutServiceFeatureRow({
    required CustomPainter iconPainter,
    required String title,
    required String description,
  }) {
    const goldColor = Color(0xFFDF9B35);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF0F1523).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: goldColor.withValues(alpha: 0.75),
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: goldColor.withValues(alpha: 0.10),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 28,
            height: 28,
            child: CustomPaint(
              painter: iconPainter,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: GoogleFonts.outfit(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                  color: const Color(0xFF94A3B8),
                  letterSpacing: 0.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 02: STRUCTURAL STEEL DECK & ARCHITECTURAL MASTERWORKS
  // ════════════════════════════════════════════════════════════════════════════
  // ── Prestige Projects data for the new section design ──────────────────
  final List<Map<String, dynamic>> _prestigeProjects = [
    {
      'title': 'Modern Family Residence',
      'location': 'Kozhikode, Kerala',
      'desc': 'A contemporary home designed for comfort, space and timeless elegance.',
      'image': 'assets/house_stage3_framing.jpg',
      'status': 'IN PROGRESS',
      'statusColor': Color(0xFF3B82F6), // blue
    },
    {
      'title': 'Luxury Villa',
      'location': 'Trivandrum, Kerala',
      'desc': 'A premium villa with modern aesthetics, premium finishes and serene surroundings.',
      'image': 'assets/villa_construction_site.jpg',
      'status': 'COMPLETED',
      'statusColor': Color(0xFF16A34A), // green
    },
    {
      'title': 'Commercial Complex',
      'location': 'Kochi, Kerala',
      'desc': 'A state-of-the-art commercial space built for businesses to grow.',
      'image': 'assets/construction_project_tower.jpg',
      'status': 'COMPLETED',
      'statusColor': Color(0xFF16A34A), // green
    },
    {
      'title': 'Residential Apartments',
      'location': 'Thrissur, Kerala',
      'desc': 'Modern apartments with world-class amenities and sustainable design.',
      'image': 'assets/construction_project_residential.jpg',
      'status': 'IN PROGRESS',
      'statusColor': Color(0xFF3B82F6), // blue
    },
  ];

  Widget _buildZone02Masterworks(bool isDesktop, bool isTablet) {
    return Container(
      color: kObsidian,
      child: Stack(
        fit: StackFit.loose,
        children: [
          // ── Full-bleed construction site background photo ──
          Positioned.fill(
            child: Image.asset(
              'assets/villa_construction_site.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // ── Dark gradient scrim over the photo ──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xCC000000),
                    Color(0xAA000000),
                    Color(0xBB000000),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 120 : (isTablet ? 48 : 24),
              vertical: isDesktop ? 80 : 60,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── "OUR PRESTIGE PROJECTS" label ──
                Text(
                  'OUR PRESTIGE PROJECTS',
                  style: GoogleFonts.spaceGrotesk(
                    color: kSafetyAmber,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.5,
                  ),
                ),
                const SizedBox(height: 16),

                // ── "Building Dreams, Creating Landmarks" headline ──
                Text(
                  'Building Dreams,\nCreating Landmarks',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: isDesktop ? 52 : (isTablet ? 40 : 32),
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 20),

                // ── Subtitle ──
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    'From modern homes to large-scale developments, explore some of our most prestigious projects that showcase our commitment to quality, innovation and excellence.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFFCBD5E1),
                      fontSize: 15,
                      height: 1.6,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // ── 2×2 Project Cards Grid ──
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool twoCol = constraints.maxWidth > 560;
                    const double colGap = 20;
                    final double cardWidth = twoCol
                        ? (constraints.maxWidth - colGap) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: colGap,
                      runSpacing: colGap,
                      alignment: WrapAlignment.center,
                      children: _prestigeProjects.map((proj) {
                        return SizedBox(
                          width: cardWidth,
                          child: _PrestigeProjectCard(project: proj),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 48),

                // ── "VIEW ALL PROJECTS →" CTA button ──
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kSafetyAmber,
                    side: const BorderSide(color: kSafetyAmber, width: 1.5),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  icon: Text(
                    'VIEW ALL PROJECTS',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: kSafetyAmber,
                    ),
                  ),
                  label: const Icon(Icons.arrow_forward, size: 16, color: kSafetyAmber),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecFilterTab(String id, String label, int count) {
    final isSelected = _selectedCategory == id;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = id),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? kSafetyAmber : kConcreteDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? kSafetyAmber : kSiteBorder,
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: kSafetyAmber.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  letterSpacing: 0.5,
                  fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                  color: isSelected ? Colors.black : kSteel,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.black.withValues(alpha: 0.25)
                      : kSafetyAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$count',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: isSelected ? Colors.black : kSafetyAmber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 03: ACTIVE TERRAFORMING PIT & HEAVY PLANT FLEET
  // ════════════════════════════════════════════════════════════════════════════
  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 03: POWERFUL MACHINERY FLEET SHOWCASE
  // ════════════════════════════════════════════════════════════════════════════
  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 03: POWERFUL MACHINERY FLEET SHOWCASE (100% DITTO REFERENCE REPLICA)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildZone03Fleet(bool isDesktop, bool isTablet) {
    final m = _fleetMachinery[_selectedFleetIndex];

    return Container(
      color: const Color(0xFF090A0E),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          // Maintain the 16:9 cinematic aspect ratio from the reference mockup
          final height = isDesktop
              ? (width * 9 / 16).clamp(640.0, 920.0)
              : (isTablet ? 720.0 : 820.0);

          return SizedBox(
            width: width,
            height: height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // ── 1. Full-bleed dramatic fleet background with circular stage & spotlight ──
                Positioned.fill(
                  child: Image.asset(
                    'assets/constuction_fleet_bg.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),

                // Subtle dark tint overlay to deepen the background and maximize machinery pop
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),

                // ── 2. Layout (Desktop vs Mobile) ──
                if (isDesktop)
                  _buildFleetDesktopView(m, width, height)
                else
                  _buildFleetMobileView(m, width, height),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMachineryTransition(Widget child, Animation<double> anim) {
    final bool isIncoming =
        (child.key == ValueKey(_fleetMachinery[_selectedFleetIndex]['image']));

    if (isIncoming) {
      final slideAnim = Tween<Offset>(
        begin: Offset(_fleetNavDirection * 0.35, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: anim,
        curve: Curves.easeOutCubic,
      ));

      final scaleAnim = Tween<double>(
        begin: 0.90,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: anim,
        curve: Curves.easeOutCubic,
      ));

      return SlideTransition(
        position: slideAnim,
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: anim,
            curve: const Interval(0.0, 0.85, curve: Curves.easeOut),
          ),
          child: ScaleTransition(
            scale: scaleAnim,
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        ),
      );
    } else {
      final slideAnim = Tween<Offset>(
        begin: Offset(-_fleetNavDirection * 0.35, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: anim,
        curve: Curves.easeInCubic,
      ));

      final scaleAnim = Tween<double>(
        begin: 0.90,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: anim,
        curve: Curves.easeInCubic,
      ));

      return SlideTransition(
        position: slideAnim,
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: anim,
            curve: const Interval(0.15, 1.0, curve: Curves.easeIn),
          ),
          child: ScaleTransition(
            scale: scaleAnim,
            alignment: Alignment.bottomCenter,
            child: child,
          ),
        ),
      );
    }
  }

  Widget _buildFleetDesktopView(Map<String, dynamic> m, double width, double height) {
    return Stack(
      children: [
        // ── TOP LEFT: Title & Description ──
        Positioned(
          top: height * 0.08,
          left: width * 0.045,
          width: width * 0.32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 34,
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5A93B),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'OUR FLEET',
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFE5A93B),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'POWERFUL MACHINERY.',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: (width * 0.022).clamp(24.0, 36.0),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  height: 1.12,
                ),
              ),
              Text(
                'BUILT FOR BIGGER GOALS.',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFE5A93B),
                  fontSize: (width * 0.022).clamp(24.0, 36.0),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: Text(
                  'Our modern fleet of heavy equipment is designed to handle every challenge, from earthmoving to material handling, ensuring efficiency, safety and superior performance on every project.',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF94A3B8),
                    fontSize: (width * 0.009).clamp(11.5, 13.5),
                    height: 1.55,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── TOP RIGHT: 3 Feature Badges ──
        Positioned(
          top: height * 0.08,
          right: width * 0.045,
          width: width * 0.22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              _FleetFeatureItem(
                icon: Icons.settings_outlined,
                title: 'High Performance',
                subtitle: 'Maximum productivity in every condition.',
              ),
              SizedBox(height: 22),
              _FleetFeatureItem(
                icon: Icons.shield_outlined,
                title: 'Safety First',
                subtitle: 'Built with advanced safety features.',
              ),
              SizedBox(height: 22),
              _FleetFeatureItem(
                icon: Icons.access_time_outlined,
                title: 'Well Maintained',
                subtitle: 'Regular servicing for reliable performance.',
              ),
            ],
          ),
        ),

        // ── CENTER: Hero Machinery sitting on the glowing ground platform ──
        Positioned(
          left: width * 0.22,
          right: width * 0.22,
          bottom: height * 0.24,
          height: height * 0.54,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              // Subtle ground contact shadow on circular platform
              Positioned(
                bottom: 12,
                child: Container(
                  width: (width * 0.32).clamp(240.0, 480.0),
                  height: 22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(width * 0.32, 22)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.65),
                        blurRadius: 22,
                        spreadRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
              // Animated Machinery Display with continuation momentum
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 460),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                layoutBuilder: (currentChild, previousChildren) => Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                ),
                transitionBuilder: _buildMachineryTransition,
                child: Image.asset(
                  m['image'] as String,
                  key: ValueKey(m['image']),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
        ),

        // ── LEFT NAV ARROW ──
        Positioned(
          left: width * 0.035,
          top: height * 0.48,
          child: _FleetCircleArrow(
            icon: Icons.chevron_left,
            onTap: () {
              _selectFleet(
                (_selectedFleetIndex - 1 + _fleetMachinery.length) % _fleetMachinery.length,
                direction: -1,
              );
            },
          ),
        ),

        // ── RIGHT NAV ARROW ──
        Positioned(
          right: width * 0.035,
          top: height * 0.48,
          child: _FleetCircleArrow(
            icon: Icons.chevron_right,
            onTap: () {
              _selectFleet(
                (_selectedFleetIndex + 1) % _fleetMachinery.length,
                direction: 1,
              );
            },
          ),
        ),

        // ── BOTTOM: Thumbnail Selector Carousel & Indicator Pills ──
        Positioned(
          bottom: height * 0.045,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SingleChildScrollView(
                  controller: _fleetThumbScrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_fleetMachinery.length, (i) {
                      final item = _fleetMachinery[i];
                      final bool isSelected = i == _selectedFleetIndex;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => _selectFleet(i),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: 122,
                                height: 78,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.black.withOpacity(0.45)
                                      : Colors.black.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(9),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFE5A93B)
                                        : Colors.white.withOpacity(0.08),
                                    width: isSelected ? 1.6 : 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFFE5A93B).withOpacity(0.32),
                                            blurRadius: 16,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        item['thumb'] as String,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      item['label'] as String,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.spaceGrotesk(
                                        color: isSelected
                                            ? const Color(0xFFE5A93B)
                                            : const Color(0xFFCBD5E1),
                                        fontSize: 11,
                                        fontWeight:
                                            isSelected ? FontWeight.w700 : FontWeight.w500,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (i < _fleetMachinery.length - 1)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: 3.5,
                                height: 3.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.18),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // 3 Dynamic Indicator Pills beneath the cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (pillIdx) {
                  final bool isActive = pillIdx == (_selectedFleetIndex ~/ 3).clamp(0, 2);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      width: isActive ? 28 : 14,
                      height: 3.5,
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFE5A93B) : const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFE5A93B).withOpacity(0.4),
                                  blurRadius: 6,
                                  spreadRadius: 0.5,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFleetMobileView(Map<String, dynamic> m, double width, double height) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 2,
                  color: const Color(0xFFE5A93B),
                ),
                const SizedBox(width: 8),
                Text(
                  'OUR FLEET',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFE5A93B),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'POWERFUL MACHINERY.',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                height: 1.15,
              ),
            ),
            Text(
              'BUILT FOR BIGGER GOALS.',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFE5A93B),
                fontSize: 22,
                fontWeight: FontWeight.w900,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Our modern fleet of heavy equipment is designed to handle every challenge, ensuring efficiency, safety and superior performance.',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF94A3B8),
                fontSize: 12,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            // Hero machinery with arrows
            SizedBox(
              height: 260,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 12,
                    child: Container(
                      width: 240,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.elliptical(240, 18)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.6),
                            blurRadius: 18,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 460),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    layoutBuilder: (currentChild, previousChildren) => Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    ),
                    transitionBuilder: _buildMachineryTransition,
                    child: Image.asset(
                      m['image'] as String,
                      key: ValueKey(m['image']),
                      height: 220,
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: _FleetCircleArrow(
                      icon: Icons.chevron_left,
                      onTap: () => _selectFleet(
                        (_selectedFleetIndex - 1 + _fleetMachinery.length) % _fleetMachinery.length,
                        direction: -1,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: _FleetCircleArrow(
                      icon: Icons.chevron_right,
                      onTap: () => _selectFleet(
                        (_selectedFleetIndex + 1) % _fleetMachinery.length,
                        direction: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 3 Badges horizontally or vertically
            const _FleetFeatureItem(
              icon: Icons.settings_outlined,
              title: 'High Performance',
              subtitle: 'Maximum productivity in every condition.',
            ),
            const SizedBox(height: 14),
            const _FleetFeatureItem(
              icon: Icons.shield_outlined,
              title: 'Safety First',
              subtitle: 'Built with advanced safety features.',
            ),
            const SizedBox(height: 14),
            const _FleetFeatureItem(
              icon: Icons.access_time_outlined,
              title: 'Well Maintained',
              subtitle: 'Regular servicing for reliable performance.',
            ),
            const SizedBox(height: 24),
            // Thumbnail strip
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(_fleetMachinery.length, (i) {
                  final item = _fleetMachinery[i];
                  final bool isSelected = i == _selectedFleetIndex;
                  return GestureDetector(
                    onTap: () => _selectFleet(i),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 100,
                      height: 68,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.black.withOpacity(0.5)
                            : Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFE5A93B) : Colors.white.withOpacity(0.08),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Image.asset(item['thumb'] as String, fit: BoxFit.contain)),
                          const SizedBox(height: 3),
                          Text(
                            item['label'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              color: isSelected ? const Color(0xFFE5A93B) : const Color(0xFFCBD5E1),
                              fontSize: 9.5,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // ════════════════════════════════════════════════════════════════════════════

  // ZONE 04: ADVANCED ENGINEERING & PROPRIETARY CIVIL SYSTEMS
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildZone04Engineering(bool isDesktop, bool isTablet) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 16),
      vertical: 60,
    );

    return Container(
      color: kObsidian,
      child: Stack(
        children: [
          // 1. Realistic Construction Background Image with Worker, Scaffolding & Cranes
          Positioned.fill(
            child: Image.asset(
              'assets/foundation_construction_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
          ),

          // 2. Atmospheric vignette & gradient scrim to ensure cards & text pop
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.90),
                    Colors.black.withValues(alpha: 0.72),
                    Colors.black.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.78, 1.0],
                ),
              ),
            ),
          ),

          // 3. Subtle edge blend into obsidian background for adjacent sections
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kObsidian.withValues(alpha: 0.70),
                    Colors.transparent,
                    Colors.transparent,
                    kObsidian.withValues(alpha: 0.75),
                  ],
                  stops: const [0.0, 0.08, 0.92, 1.0],
                ),
              ),
            ),
          ),

          // 4. Content Area
          Padding(
            padding: padding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // On desktop, keep the content container to ~68% of section width
                // so the construction worker and atmospheric background stay visible on the right
                final double contentWidth = isDesktop
                    ? (constraints.maxWidth * 0.68).clamp(620.0, 920.0)
                    : double.infinity;

                return Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Section Eyebrow & Main Title ──
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9F1C),
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '03 / PROPRIETARY ENGINEERING PATENTS',
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFFFF9F1C),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ZONE 04 / CIVIL & STRUCTURAL SYSTEMS',
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF64748B),
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'FOUNDATION & ADVANCED\n',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: isDesktop ? 34 : (isTablet ? 28 : 22),
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                  height: 1.15,
                                ),
                              ),
                              TextSpan(
                                text: 'ARCHITECTURAL SYSTEMS',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: isDesktop ? 34 : (isTablet ? 28 : 22),
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFF9F1C),
                                  letterSpacing: -0.5,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Innovative structural solutions built for strength, precision and long-term performance.',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF94A3B8),
                            fontSize: isDesktop ? 14.5 : 13,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── 2x2 Tech Blueprint Cards Grid ──
                        if (isDesktop || constraints.maxWidth >= 640)
                          Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: const [
                                    Expanded(
                                      child: _StructuralBlueprintSystemTile(
                                        num: '01',
                                        code: 'SYS-BIM-LIDAR',
                                        title: 'Autonomous Drone LiDAR & Digital Twin',
                                        desc:
                                            'Daily centimeter-accurate point-cloud scans integrated with BIM Level 3 D timeline simulation.',
                                        icon: Icons.track_changes_rounded,
                                        spec: 'TOLERANCE ±2mm · RTK GPS',
                                        corner: _TechCardCorner.topLeft,
                                        hasOrangeAccent: false,
                                      ),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: _StructuralBlueprintSystemTile(
                                        num: '02',
                                        code: 'SYS-STL-METALLURGY',
                                        title: 'High-Tensile Structural Steelwork',
                                        desc:
                                            'Robotic flux-cored arc welding and automated ultrasonic non-destructive testing for supertall nodes.',
                                        icon: Icons.handyman_rounded,
                                        spec: 'GRADE 65 · ASTM A992 SPEC',
                                        corner: _TechCardCorner.topRight,
                                        hasOrangeAccent: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: const [
                                    Expanded(
                                      child: _StructuralBlueprintSystemTile(
                                        num: '03',
                                        code: 'SYS-CNC-POST-TENSION',
                                        title: 'Post-Tensioned Concrete & Pre-Cast',
                                        desc:
                                            'Self-consolidating high-performance concrete with internal fiber reinforcement for 100+ year design life.',
                                        icon: Icons.view_in_ar_rounded,
                                        spec: 'C50/60 · CO2-MINERALIZED',
                                        corner: _TechCardCorner.topLeft,
                                        hasOrangeAccent: false,
                                      ),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: _StructuralBlueprintSystemTile(
                                        num: '04',
                                        code: 'SYS-HYD-SEISMIC',
                                        title: 'Seismic Viscous & Tuned Mass Dampers',
                                        desc:
                                            'Advanced hydraulic sway mitigation absorbing wind drift on towers up to 600m height.',
                                        icon: Icons.monitor_heart_rounded,
                                        spec: 'CAT 5 HURRICANE · ZONE 4',
                                        corner: _TechCardCorner.topRight,
                                        hasOrangeAccent: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: const [
                              _StructuralBlueprintSystemTile(
                                num: '01',
                                code: 'SYS-BIM-LIDAR',
                                title: 'Autonomous Drone LiDAR & Digital Twin',
                                desc:
                                    'Daily centimeter-accurate point-cloud scans integrated with BIM Level 3 D timeline simulation.',
                                icon: Icons.track_changes_rounded,
                                spec: 'TOLERANCE ±2mm · RTK GPS',
                                corner: _TechCardCorner.topLeft,
                                hasOrangeAccent: false,
                              ),
                              SizedBox(height: 16),
                              _StructuralBlueprintSystemTile(
                                num: '02',
                                code: 'SYS-STL-METALLURGY',
                                title: 'High-Tensile Structural Steelwork',
                                desc:
                                    'Robotic flux-cored arc welding and automated ultrasonic non-destructive testing for supertall nodes.',
                                icon: Icons.handyman_rounded,
                                spec: 'GRADE 65 · ASTM A992 SPEC',
                                corner: _TechCardCorner.topRight,
                                hasOrangeAccent: true,
                              ),
                              SizedBox(height: 16),
                              _StructuralBlueprintSystemTile(
                                num: '03',
                                code: 'SYS-CNC-POST-TENSION',
                                title: 'Post-Tensioned Concrete & Pre-Cast',
                                desc:
                                    'Self-consolidating high-performance concrete with internal fiber reinforcement for 100+ year design life.',
                                icon: Icons.view_in_ar_rounded,
                                spec: 'C50/60 · CO2-MINERALIZED',
                                corner: _TechCardCorner.topLeft,
                                hasOrangeAccent: false,
                              ),
                              SizedBox(height: 16),
                              _StructuralBlueprintSystemTile(
                                num: '04',
                                code: 'SYS-HYD-SEISMIC',
                                title: 'Seismic Viscous & Tuned Mass Dampers',
                                desc:
                                    'Advanced hydraulic sway mitigation absorbing wind drift on towers up to 600m height.',
                                icon: Icons.monitor_heart_rounded,
                                spec: 'CAT 5 HURRICANE · ZONE 4',
                                corner: _TechCardCorner.topRight,
                                hasOrangeAccent: true,
                              ),
                            ],
                          ),

                        const SizedBox(height: 24),

                        // ── Bottom Pagination / HUD Blueprint Accents ──
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9F1C),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF64748B),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF334155),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomPaint(
                          size: const Size(50, 20),
                          painter: _DiagonalAccentPainter(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 05: FIELD COMMAND & MASTER BUILDER GUILD
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildZone05LeadershipGuild(bool isDesktop, bool isTablet) {
    final leaders = [
      {
        'name': 'Marcus Vance, PE, CEng',
        'role': 'CHIEF STRUCTURAL ENGINEER',
        'cred': 'Ex-Arup Lead • 32 Supertalls Delivered',
        'badgeId': 'CORPS-PE-01',
        'icon': Icons.engineering_rounded,
      },
      {
        'name': 'Elena Rostova, Ph.D.',
        'role': 'HEAD OF ADVANCED METALLURGY',
        'cred': 'High-Tensile Alloy & Fatigue Specialist',
        'badgeId': 'CORPS-MET-02',
        'icon': Icons.psychology_rounded,
      },
      {
        'name': 'Devon Sterling',
        'role': 'VP OF GLOBAL PROCUREMENT & LOGISTICS',
        'cred': 'Heavy Maritime Heavy-Lift Operations',
        'badgeId': 'CORPS-LOG-03',
        'icon': Icons.local_shipping_rounded,
      },
      {
        'name': 'Tariq Al-Mansoor',
        'role': 'DIRECTOR OF CIVIL MEGAPROJECTS',
        'cred': 'Mega-Tunneling & Deep Harbor Infrastructure',
        'badgeId': 'CORPS-CIV-04',
        'icon': Icons.domain_rounded,
      },
    ];

    return Container(
      color: kObsidian,
      child: Stack(
        children: [
          // 1. Dramatic Engineering Background with Tablet Engineer & Twilight Cranes
          Positioned.fill(
            child: Image.asset(
              'assets/technical_leadership_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
            ),
          ),

          // 2. Atmospheric vignette: allow engineer to shine on left, darken center & right for cards
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.78),
                    Colors.black.withValues(alpha: 0.90),
                  ],
                  stops: const [0.0, 0.26, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // 3. Subtle edge blend into obsidian background for adjacent sections
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kObsidian.withValues(alpha: 0.75),
                    Colors.transparent,
                    Colors.transparent,
                    kObsidian.withValues(alpha: 0.75),
                  ],
                  stops: const [0.0, 0.08, 0.92, 1.0],
                ),
              ),
            ),
          ),

          // 4. Content Area
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1024;
              final isMedium =
                  constraints.maxWidth >= 640 && constraints.maxWidth < 1024;

              // On desktop, indent the content so the engineer with tablet on the left remains visible
              final double leftPad = isWide
                  ? (constraints.maxWidth * 0.27).clamp(260.0, 420.0)
                  : (isMedium ? 30.0 : 16.0);
              final double rightPad = isWide ? 40.0 : (isMedium ? 30.0 : 16.0);

              return Padding(
                padding: EdgeInsets.fromLTRB(leftPad, 60, rightPad, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header: Warning Badge + Extended Hazard Stripe Bar ──
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3.5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9F1C),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.black,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '04 / TECHNICAL LEADERSHIP & SUPERINTENDENTS',
                                style: GoogleFonts.spaceGrotesk(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: const CustomPaint(
                                painter: _HazardStripePainter(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // ── Eyebrow Tag ──
                    Text(
                      'ZONE 05 / SITE CORPS & COMMAND',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFFF9F1C),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── Main Heading ──
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'THE ON-SITE ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isWide ? 34 : (isMedium ? 28 : 22),
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          ),
                          TextSpan(
                            text: 'MASTER BUILDER GUILD',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isWide ? 34 : (isMedium ? 28 : 22),
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFF9F1C),
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── 4 Dossier Cards (4 columns on wide screens, 2x2 on medium, 1 column on small) ──
                    if (isWide)
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (int i = 0; i < leaders.length; i++) ...[
                              if (i > 0) const SizedBox(width: 14),
                              Expanded(
                                child: _FieldSuperintendentDossierCard(
                                  name: leaders[i]['name'] as String,
                                  role: leaders[i]['role'] as String,
                                  cred: leaders[i]['cred'] as String,
                                  badgeId: leaders[i]['badgeId'] as String,
                                  icon: leaders[i]['icon'] as IconData,
                                ),
                              ),
                            ],
                          ],
                        ),
                      )
                    else if (isMedium)
                      Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _FieldSuperintendentDossierCard(
                                    name: leaders[0]['name'] as String,
                                    role: leaders[0]['role'] as String,
                                    cred: leaders[0]['cred'] as String,
                                    badgeId: leaders[0]['badgeId'] as String,
                                    icon: leaders[0]['icon'] as IconData,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _FieldSuperintendentDossierCard(
                                    name: leaders[1]['name'] as String,
                                    role: leaders[1]['role'] as String,
                                    cred: leaders[1]['cred'] as String,
                                    badgeId: leaders[1]['badgeId'] as String,
                                    icon: leaders[1]['icon'] as IconData,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _FieldSuperintendentDossierCard(
                                    name: leaders[2]['name'] as String,
                                    role: leaders[2]['role'] as String,
                                    cred: leaders[2]['cred'] as String,
                                    badgeId: leaders[2]['badgeId'] as String,
                                    icon: leaders[2]['icon'] as IconData,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _FieldSuperintendentDossierCard(
                                    name: leaders[3]['name'] as String,
                                    role: leaders[3]['role'] as String,
                                    cred: leaders[3]['cred'] as String,
                                    badgeId: leaders[3]['badgeId'] as String,
                                    icon: leaders[3]['icon'] as IconData,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          for (int i = 0; i < leaders.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: _FieldSuperintendentDossierCard(
                                name: leaders[i]['name'] as String,
                                role: leaders[i]['role'] as String,
                                cred: leaders[i]['cred'] as String,
                                badgeId: leaders[i]['badgeId'] as String,
                                icon: leaders[i]['icon'] as IconData,
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 06: PROJECT MANAGEMENT FIELD OFFICE & TENDER (RFP)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildZone06SiteOfficeTender(bool isDesktop, bool isTablet) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 16),
      vertical: isDesktop ? 70 : 50,
    );

    return Container(
      color: kObsidian,
      padding: padding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1260),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. Ambient warm gold glow behind the card and machine
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: isDesktop
                          ? const Alignment(0.55, 0.20)
                          : Alignment.center,
                      radius: 0.85,
                      colors: [
                        const Color(0xFFFF9F1C).withValues(alpha: 0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // 2. The Main Monolith Field Office Card
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF131926),
                      Color(0xFF0E131E),
                      Color(0xFF090D14),
                    ],
                    stops: [0.0, 0.55, 1.0],
                  ),
                  border: Border.all(
                    color: const Color(0xFFFF9F1C).withValues(alpha: 0.65),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.85),
                      blurRadius: 45,
                      offset: const Offset(0, 18),
                    ),
                    BoxShadow(
                      color: const Color(0xFFFF9F1C).withValues(alpha: 0.10),
                      blurRadius: 30,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(19),
                  child: Stack(
                    children: [
                      // Layer 1: Engineering Blueprint Drafting Grid
                      Positioned.fill(
                        child: CustomPaint(
                          painter: const _DraftingGridPainter(opacity: 0.16),
                        ),
                      ),

                      // Layer 2: Tech Corner Brackets
                      Positioned.fill(
                        child: const CustomPaint(
                          painter: _TechCornerBracketPainter(),
                        ),
                      ),

                      // Layer 3: Top Hazard Caution Stripe
                      Positioned(
                        top: 0,
                        left: 20,
                        right: 20,
                        child: SizedBox(
                          height: 4.5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(2),
                            ),
                            child: const CustomPaint(
                              painter: _HazardStripePainter(),
                            ),
                          ),
                        ),
                      ),

                      // Layer 4: Content Column
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          isDesktop ? 48 : (isTablet ? 32 : 20),
                          isDesktop ? 44 : (isTablet ? 32 : 24),
                          isDesktop ? 48 : (isTablet ? 32 : 20),
                          isDesktop ? 46 : (isTablet ? 32 : 24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Top Header Row ──
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 16,
                              runSpacing: 10,
                              children: [
                                // Left: Eyebrow with gold dash
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 2.5,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF9F1C),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'ZONE 06 / SITE OFFICE • PROJECT ESTIMATION & TENDER COMMENCEMENT',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: const Color(0xFFFF9F1C),
                                        fontSize: 11,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),

                                // Right: Live Status Pill
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 11,
                                    vertical: 4.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0x1A22C55E),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFF22C55E)
                                          .withValues(alpha: 0.4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF22C55E),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      Text(
                                        'FAST-TRACK ESTIMATION LIVE · 72-HR SLA',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.5,
                                          color: const Color(0xFF4ADE80),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18),

                            // ── Headline ──
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isDesktop ? 780 : double.infinity,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'INITIATE YOUR MASTER PROJECT WITH ',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Colors.white,
                                        fontSize: isDesktop
                                            ? 34
                                            : (isTablet ? 26 : 20),
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.6,
                                        height: 1.15,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'JS CONSTRUCTIONS',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFFFF9F1C),
                                        fontSize: isDesktop
                                            ? 34
                                            : (isTablet ? 26 : 20),
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.6,
                                        height: 1.15,
                                        shadows: [
                                          Shadow(
                                            color: const Color(0xFFFF9F1C)
                                                .withValues(alpha: 0.4),
                                            blurRadius: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // ── Subtitle Description ──
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isDesktop ? 680 : double.infinity,
                              ),
                              child: Text(
                                'Submit architectural schematic drawings or RFP documentation. Our executive engineering estimators deliver preliminary feasibility studies and site survey assessments within 72 hours.',
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFF94A3B8),
                                  fontSize: isDesktop ? 15 : 14,
                                  height: 1.55,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),

                            // ── 3 Feasibility Trust Badges / Telemetry Chips ──
                            Wrap(
                              spacing: 12,
                              runSpacing: 10,
                              children: [
                                _buildTenderTrustChip(
                                  icon: Icons.bolt_rounded,
                                  label: '72-HR FEASIBILITY',
                                  spec: 'Rapid Preliminary BOQ & Site Scan',
                                ),
                                _buildTenderTrustChip(
                                  icon: Icons.verified_user_rounded,
                                  label: 'BONDED EPC MONOLITH',
                                  spec: 'Fixed-Price & 0 Lost-Time Safety',
                                ),
                                _buildTenderTrustChip(
                                  icon: Icons.architecture_rounded,
                                  label: 'BIM LEVEL 3 READY',
                                  spec: 'PE-Stamped Drawings & 4D Simulation',
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),

                            // ── Action Buttons ──
                            Wrap(
                              spacing: 16,
                              runSpacing: 12,
                              children: [
                                _TenderPrimaryButton(
                                  onTap: () => _openTenderDialog(context),
                                ),
                                _TenderSecondaryButton(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            const Color(0xFFFF9F1C),
                                        content: Text(
                                          'JS Constructions Corporate Capability Profile (PDF) downloading.',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.1,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                            // On Mobile / Narrow screens, display the bulldozer centered below
                            if (!isDesktop) ...[
                              const SizedBox(height: 26),
                              Center(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      width: 240,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.elliptical(120, 11),
                                        ),
                                        gradient: RadialGradient(
                                          colors: [
                                            Colors.black.withValues(alpha: 0.8),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/bulldozer.png',
                                      width: isTablet ? 300 : 250,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Heavy Bulldozer positioned at bottom-right on Desktop
              if (isDesktop)
                Positioned(
                  right: -25,
                  bottom: -35,
                  child: IgnorePointer(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        // Ambient amber backlight behind the machine
                        Positioned(
                          bottom: 30,
                          right: 40,
                          child: Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFFFF9F1C).withValues(alpha: 0.22),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Realistic Ground Contact Shadow
                        Positioned(
                          bottom: 0,
                          left: 20,
                          right: 20,
                          child: Container(
                            height: 28,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.elliptical(170, 14),
                              ),
                              gradient: RadialGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.90),
                                  Colors.black.withValues(alpha: 0.40),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Heavy Bulldozer image with high presence
                        Image.asset(
                          'assets/bulldozer.png',
                          width: 390,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTenderTrustChip({
    required IconData icon,
    required String label,
    required String spec,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1523).withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFFF9F1C).withValues(alpha: 0.35),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFFF9F1C), size: 16),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              Text(
                spec,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF64748B),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // ZONE 07: SITE EGRESS & SAFETY COMPLIANCE AUDIT FOOTER
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildZone07EgressFooter(bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── 1. Panoramic Sunset Construction Horizon Banner ──
        SizedBox(
          height: isDesktop ? 260 : (isTablet ? 200 : 150),
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/construction_footer_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              // Subtle darkening scrim at bottom to meet the technical border cleanly
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.40),
                    ],
                    stops: const [0.70, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── 2. Technical Top Border Line ──
        CustomPaint(
          size: const Size(double.infinity, 16),
          painter: const _FooterTopBorderPainter(),
        ),

        // ── 3. Dark Industrial HUD Footer Panel ──
        Container(
          color: const Color(0xFF07090E),
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 60 : (isTablet ? 30 : 20),
            32,
            isDesktop ? 60 : (isTablet ? 30 : 20),
            24,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1024;
              final isMedium =
                  constraints.maxWidth >= 640 && constraints.maxWidth < 1024;

              return Column(
                children: [
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Column 1: Brand & Logo
                        Expanded(flex: 32, child: _buildFooterBrandCol()),
                        const SizedBox(width: 36),
                        // Column 2: Quick Links
                        Expanded(flex: 18, child: _buildFooterQuickLinksCol()),
                        const SizedBox(width: 28),
                        // Column 3: Our Services
                        Expanded(flex: 22, child: _buildFooterServicesCol()),
                        const SizedBox(width: 28),
                        // Column 4: Contact Us
                        Expanded(flex: 26, child: _buildFooterContactCol()),
                        const SizedBox(width: 28),
                        // Column 5: Follow Us
                        Expanded(flex: 20, child: _buildFooterFollowCol()),
                      ],
                    )
                  else if (isMedium)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildFooterBrandCol()),
                            const SizedBox(width: 32),
                            Expanded(child: _buildFooterQuickLinksCol()),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildFooterServicesCol()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildFooterContactCol()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildFooterFollowCol()),
                          ],
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFooterBrandCol(),
                        const SizedBox(height: 28),
                        _buildFooterQuickLinksCol(),
                        const SizedBox(height: 28),
                        _buildFooterServicesCol(),
                        const SizedBox(height: 28),
                        _buildFooterContactCol(),
                        const SizedBox(height: 28),
                        _buildFooterFollowCol(),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Divider
                  Container(
                    height: 1,
                    color: const Color(0xFF1E2636),
                  ),
                  const SizedBox(height: 16),

                  // Bottom Copyright Row + Hazard Accent
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '© 2025 Aeon Construction Group. All rights reserved.',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 11,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                        height: 10,
                        child: CustomPaint(
                          painter: _FooterBottomHazardPainter(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFooterBrandCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 36,
              height: 32,
              child: CustomPaint(
                painter: _AeonLogoPainter(),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AEON',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.2,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'CONSTRUCTION GROUP',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF94A3B8),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Building tomorrow, today. Delivering excellence in construction, infrastructure and engineering solutions across every terrain.',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 24,
          height: 3.5,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9F1C),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterHeader(String title) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 2.5,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9F1C),
            borderRadius: BorderRadius.circular(1.5),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFFFF9F1C),
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterQuickLinksCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('QUICK LINKS'),
        const SizedBox(height: 16),
        _FooterNavLink(
          label: 'Home',
          onTap: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOutCubic,
            );
          },
        ),
        const SizedBox(height: 9),
        _FooterNavLink(
          label: 'About Us',
          onTap: () => _scrollToKey(_telemetryKey),
        ),
        const SizedBox(height: 9),
        _FooterNavLink(
          label: 'Services',
          onTap: () => _scrollToKey(_capabilitiesKey),
        ),
        const SizedBox(height: 9),
        _FooterNavLink(
          label: 'Projects',
          onTap: () => _scrollToKey(_projectsKey),
        ),
        const SizedBox(height: 9),
        _FooterNavLink(
          label: 'Contact Us',
          onTap: () => _scrollToKey(_contactKey),
        ),
      ],
    );
  }

  Widget _buildFooterServicesCol() {
    final services = [
      'Earthmoving & Site Preparation',
      'Civil & Structural Works',
      'Infrastructure Development',
      'Equipment Rental',
      'Project Management',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('OUR SERVICES'),
        const SizedBox(height: 16),
        for (int i = 0; i < services.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          Text(
            services[i],
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFooterContactCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('CONTACT US'),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Color(0xFFFF9F1C),
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '123 Construction Avenue,\nIndustrial Area, Kochi, India – 682017',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(
              Icons.call_outlined,
              color: Color(0xFFFF9F1C),
              size: 16,
            ),
            const SizedBox(width: 10),
            Text(
              '+91 98765 43210',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFCBD5E1),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(
              Icons.mail_outline_rounded,
              color: Color(0xFFFF9F1C),
              size: 16,
            ),
            const SizedBox(width: 10),
            Text(
              'info@aeonconstruction.com',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFCBD5E1),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterFollowCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('FOLLOW US'),
        const SizedBox(height: 16),
        Row(
          children: [
            _FooterSocialButton(
              child: Text(
                'f',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _FooterSocialButton(
              child: Text(
                'in',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const _FooterSocialButton(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Color(0xFFCBD5E1),
                size: 14,
              ),
            ),
            const SizedBox(width: 8),
            const _FooterSocialButton(
              child: Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFFCBD5E1),
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            _FooterSocialButton(
              child: Text(
                '𝕏',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'STRONGER FOUNDATIONS\nFOR A BRIGHTER FUTURE',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF64748B),
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            height: 1.4,
          ),
        ),
      ],
    );
  }



  Widget _buildBackToPortfolioPill() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: kSiteCharcoal.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kSafetyAmber.withValues(alpha: 0.4), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back_rounded,
                      color: kSafetyAmber,
                      size: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'PORTFOLIO',
                      style: GoogleFonts.spaceGrotesk(
                        color: kSteel,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldTelemetryChip({
    required IconData icon,
    required String label,
    required String val,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kSiteBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: kSafetyAmber, size: 14),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.spaceGrotesk(
                      color: kSteelMuted,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    val,
                    style: GoogleFonts.spaceGrotesk(
                      color: kSteel,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // INTERACTIVE PROJECT MODAL (ARCHITECTURAL SPECIFICATION DOSSIER)
  // ════════════════════════════════════════════════════════════════════════════
  void _openProjectModal(BuildContext context, Map<String, dynamic> proj) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Dialog(
            backgroundColor: kSiteCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: kSafetyAmber, width: 1.5),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 740, maxHeight: 720),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: kSafetyAmber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: kSafetyAmber),
                          ),
                          child: Text(
                            proj['badge'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              color: kSafetyAmber,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          proj['drawingCode'] ?? 'DWG-SPEC-ACTIVE',
                          style: GoogleFonts.spaceGrotesk(
                            color: kBlueprintCyan,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: kSteelMuted),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      proj['title'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        color: kSteel,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${proj['location']} • ${proj['height']}',
                      style: GoogleFonts.spaceGrotesk(
                        color: kSafetyAmber,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: AppImage(
                          assetPath: proj['image'] as String,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      proj['desc'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        color: kSteel,
                        fontSize: 14,
                        height: 1.6,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: kObsidian,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kSiteBorder),
                      ),
                      child: Column(
                        children: [
                          _buildModalSpecRow('STRUCTURAL SPECIFICATION', proj['spec'] as String),
                          const SizedBox(height: 8),
                          _buildModalSpecRow('TOTAL CONTRACT VALUE', proj['budget'] as String),
                          const SizedBox(height: 8),
                          _buildModalSpecRow('CURRENT SITE STATUS', proj['status'] as String),
                          const SizedBox(height: 8),
                          _buildModalSpecRow('ARCHITECTURAL ATELIER', proj['architect'] as String),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            'CLOSE DOSSIER',
                            style: GoogleFonts.spaceGrotesk(
                              color: kSteelMuted,
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            _openTenderDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSafetyAmber,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            'INQUIRE SIMILAR BUILD',
                            style: GoogleFonts.spaceGrotesk(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalSpecRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: kSafetyAmber,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.plusJakartaSans(
              color: kSteel,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // INTERACTIVE TENDER (RFP) DIALOG
  // ════════════════════════════════════════════════════════════════════════════
  void _openTenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            backgroundColor: kSiteCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: kSafetyAmber, width: 1.5),
            ),
            title: Row(
              children: [
                const Icon(Icons.assignment_rounded, color: kSafetyAmber, size: 22),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'SUBMIT PROJECT TENDER (RFP)',
                    style: GoogleFonts.spaceGrotesk(
                      color: kSteel,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tier-1 Global EPC Construction Services:',
                    style: GoogleFonts.spaceGrotesk(
                      color: kSafetyAmber,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTenderBullet('Complete Architectural & Structural Engineering'),
                  _buildTenderBullet('Turnkey Procurement & Heavy Equipment Fleet'),
                  _buildTenderBullet('Zero-Incident OSHA & ISO 45001 Compliance'),
                  _buildTenderBullet('BIM Level 3 4D Digital Twin Schedule Guarantee'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kObsidian,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kSafetyAmber.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ESTIMATION DESK ACTIVE',
                              style: GoogleFonts.spaceGrotesk(
                                color: kSafetyAmber,
                                fontWeight: FontWeight.w800,
                                fontSize: 11,
                                letterSpacing: 0.3,
                              ),
                            ),
                            Text(
                              'Average RFP Turnaround: 72 Hours',
                              style: GoogleFonts.plusJakartaSans(
                                color: kSteelMuted,
                                fontSize: 12,
                                letterSpacing: -0.1,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.speed_rounded, color: kSafetyAmber, size: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'CANCEL',
                  style: GoogleFonts.spaceGrotesk(
                    color: kSteelMuted,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kSafetyAmber,
                      content: Text(
                        'Your project tender documentation request is lodged. Our Chief Estimator will contact you within 24 hours.',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.1,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSafetyAmber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'CONFIRM TENDER LODGEMENT',
                  style: GoogleFonts.spaceGrotesk(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTenderBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: kSafetyAmber,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                color: kSteel,
                fontSize: 13,
                letterSpacing: -0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SITE SIGNBOARDS & CARDS DESIGNED AS REAL CONSTRUCTION OBJECTS
// ════════════════════════════════════════════════════════════════════════════



/// Monumental Site Entrance Board mounted to structural posts
class _SiteEntranceSignBoard extends StatelessWidget {
  final bool isDesktop;
  final String badge;
  final String title;
  final String subtitle;
  final String body;

  const _SiteEntranceSignBoard({
    required this.isDesktop,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : 20),
      decoration: BoxDecoration(
        color: _JsConstructionsWebsiteScreenState.kSiteCharcoal.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _JsConstructionsWebsiteScreenState.kSafetyAmber.withValues(alpha: 0.7),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 36,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Corner mounting hex rivets
          _buildCornerBolt(top: 0, left: 0),
          _buildCornerBolt(top: 0, right: 0),
          _buildCornerBolt(bottom: 0, left: 0),
          _buildCornerBolt(bottom: 0, right: 0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_rounded,
                      color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      badge,
                      style: GoogleFonts.spaceGrotesk(
                        color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                        fontSize: isDesktop ? 10.5 : 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: _JsConstructionsWebsiteScreenState.kSteel,
                  fontSize: isDesktop ? 70 : 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isDesktop ? -1.8 : -0.8,
                  height: 1.02,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 36,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: GoogleFonts.spaceGrotesk(
                  color: _JsConstructionsWebsiteScreenState.kSafetyAmberGlow,
                  fontSize: isDesktop ? 15 : 12.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                body,
                style: GoogleFonts.plusJakartaSans(
                  color: _JsConstructionsWebsiteScreenState.kSteel.withValues(alpha: 0.92),
                  fontSize: isDesktop ? 15.5 : 13.5,
                  height: 1.6,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCornerBolt({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF4B5563),
          border: Border.all(
            color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
            width: 1,
          ),
        ),
      ),
    );
  }
}

/// Site Erection Notice Board for Stages 2 & 3
class _SiteErectionNoticeBoard extends StatelessWidget {
  final bool isDesktop;
  final bool alignRight;
  final String tag;
  final String title;
  final String accent;
  final String desc;

  const _SiteErectionNoticeBoard({
    required this.isDesktop,
    required this.alignRight,
    required this.tag,
    required this.title,
    required this.accent,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!alignRight) ...[
              Container(
                width: 24,
                height: 3,
                color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              tag,
              style: GoogleFonts.spaceGrotesk(
                color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
            if (alignRight) ...[
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 3,
                color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            color: _JsConstructionsWebsiteScreenState.kSteel,
            fontSize: isDesktop ? 50 : 28,
            fontWeight: FontWeight.w900,
            letterSpacing: isDesktop ? -1.2 : -0.5,
            height: 1.05,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.95),
                blurRadius: 30,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          accent,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.spaceGrotesk(
            color: _JsConstructionsWebsiteScreenState.kSafetyAmberGlow,
            fontSize: isDesktop ? 13 : 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          desc,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            color: _JsConstructionsWebsiteScreenState.kSteelMuted,
            fontSize: isDesktop ? 15 : 13,
            height: 1.6,
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }
}

/// Interactive "OUR SERVICES →" Button with Amber Glow & Micro-animation
class _AboutServicesButton extends StatefulWidget {
  final VoidCallback onTap;
  const _AboutServicesButton({required this.onTap});

  @override
  State<_AboutServicesButton> createState() => _AboutServicesButtonState();
}

class _AboutServicesButtonState extends State<_AboutServicesButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFDF9B35);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? goldColor.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.40),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _isHovered ? goldColor : goldColor.withValues(alpha: 0.85),
              width: 1.4,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: goldColor.withValues(alpha: 0.25),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'OUR SERVICES',
                style: GoogleFonts.outfit(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.0,
                  color: goldColor,
                ),
              ),
              const SizedBox(width: 14),
              AnimatedSlide(
                duration: const Duration(milliseconds: 220),
                offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: goldColor,
                  size: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Vector Painter for Excavator / Heavy Earthmoving Icon
class _ExcavatorIconPainter extends CustomPainter {
  final Color color;
  const _ExcavatorIconPainter({this.color = const Color(0xFFDF9B35)});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scaleX = size.width / 28.0;
    final scaleY = size.height / 28.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    // 1. Crawler Tracks
    final trackRRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(2.5, 19.5, 13.0, 5.0),
      const Radius.circular(2.5),
    );
    canvas.drawRRect(trackRRect, strokePaint);

    // Track rollers / wheels inside
    canvas.drawCircle(const Offset(5.5, 22.0), 0.9, fillPaint);
    canvas.drawCircle(const Offset(9.0, 22.0), 0.9, fillPaint);
    canvas.drawCircle(const Offset(12.5, 22.0), 0.9, fillPaint);

    // 2. Cab & Body
    final cabPath = Path()
      ..moveTo(4.0, 19.5)
      ..lineTo(4.0, 14.0)
      ..lineTo(7.5, 11.5)
      ..lineTo(13.5, 11.5)
      ..lineTo(13.5, 19.5);
    canvas.drawPath(cabPath, strokePaint);

    // Cab window
    final windowPath = Path()
      ..moveTo(7.5, 13.0)
      ..lineTo(12.0, 13.0)
      ..lineTo(12.0, 16.5)
      ..lineTo(6.5, 16.5)
      ..close();
    canvas.drawPath(windowPath, strokePaint);

    // 3. Boom & Stick
    final boomPath = Path()
      ..moveTo(12.5, 16.0)
      ..lineTo(17.0, 7.5)
      ..lineTo(21.5, 12.0)
      ..lineTo(22.0, 18.5);
    canvas.drawPath(boomPath, strokePaint);

    // Hydraulic piston line
    canvas.drawLine(const Offset(13.0, 13.5), const Offset(16.0, 9.5), strokePaint);

    // 4. Bucket scoop
    final bucketPath = Path()
      ..moveTo(22.0, 18.5)
      ..lineTo(25.5, 20.0)
      ..lineTo(24.5, 24.0)
      ..lineTo(20.0, 23.5)
      ..lineTo(20.5, 19.5);
    canvas.drawPath(bucketPath, strokePaint);

    // Bucket teeth
    canvas.drawLine(const Offset(24.5, 24.0), const Offset(23.0, 25.5), strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ExcavatorIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Vector Painter for Skilled Construction Worker with Hardhat Icon
class _WorkerIconPainter extends CustomPainter {
  final Color color;
  const _WorkerIconPainter({this.color = const Color(0xFFDF9B35)});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 28.0;
    final scaleY = size.height / 28.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    // 1. Hardhat dome
    final helmetPath = Path()
      ..moveTo(7.5, 9.0)
      ..cubicTo(7.5, 4.0, 20.5, 4.0, 20.5, 9.0);
    canvas.drawPath(helmetPath, strokePaint);

    // Helmet center crest
    canvas.drawLine(const Offset(14.0, 4.0), const Offset(14.0, 8.5), strokePaint);

    // 2. Helmet brim
    final brimPath = Path()
      ..moveTo(5.0, 9.5)
      ..lineTo(23.0, 9.5);
    canvas.drawPath(brimPath, strokePaint);

    // 3. Head & neck outline
    final facePath = Path()
      ..moveTo(9.0, 10.5)
      ..lineTo(9.0, 14.0)
      ..cubicTo(9.0, 17.0, 19.0, 17.0, 19.0, 14.0)
      ..lineTo(19.0, 10.5);
    canvas.drawPath(facePath, strokePaint);

    // 4. Shoulders & upper torso
    final bodyPath = Path()
      ..moveTo(3.5, 24.5)
      ..cubicTo(5.5, 18.5, 9.5, 18.0, 12.0, 18.0)
      ..lineTo(16.0, 18.0)
      ..cubicTo(18.5, 18.0, 22.5, 18.5, 24.5, 24.5);
    canvas.drawPath(bodyPath, strokePaint);

    // Collar V
    final collarPath = Path()
      ..moveTo(12.0, 18.0)
      ..lineTo(14.0, 21.5)
      ..lineTo(16.0, 18.0);
    canvas.drawPath(collarPath, strokePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WorkerIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Vector Painter for Safety Shield with Checkmark Icon
class _SafetyShieldIconPainter extends CustomPainter {
  final Color color;
  const _SafetyShieldIconPainter({this.color = const Color(0xFFDF9B35)});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final scaleX = size.width / 28.0;
    final scaleY = size.height / 28.0;
    canvas.save();
    canvas.scale(scaleX, scaleY);

    // 1. Shield outline
    final shieldPath = Path()
      ..moveTo(14.0, 3.5)
      ..lineTo(22.5, 6.0)
      ..lineTo(22.5, 13.5)
      ..cubicTo(22.5, 19.0, 18.0, 23.0, 14.0, 25.0)
      ..cubicTo(10.0, 23.0, 5.5, 19.0, 5.5, 13.5)
      ..lineTo(5.5, 6.0)
      ..close();
    canvas.drawPath(shieldPath, strokePaint);

    // 2. Checkmark inside
    final checkPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path()
      ..moveTo(9.5, 14.0)
      ..lineTo(12.8, 17.5)
      ..lineTo(18.5, 10.5);
    canvas.drawPath(checkPath, checkPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SafetyShieldIconPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Interactive Tender Primary RFP Button with Amber Glow & Micro-animation
class _TenderPrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  const _TenderPrimaryButton({required this.onTap});

  @override
  State<_TenderPrimaryButton> createState() => _TenderPrimaryButtonState();
}

class _TenderPrimaryButtonState extends State<_TenderPrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 17),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFB300), Color(0xFFFF9F1C)],
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF9F1C).withValues(
                  alpha: _isHovered ? 0.45 : 0.20,
                ),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SUBMIT PROJECT TENDER (RFP)',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              AnimatedSlide(
                duration: const Duration(milliseconds: 200),
                offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Interactive Tender Secondary Prospectus Download Button
class _TenderSecondaryButton extends StatefulWidget {
  final VoidCallback onTap;
  const _TenderSecondaryButton({required this.onTap});

  @override
  State<_TenderSecondaryButton> createState() => _TenderSecondaryButtonState();
}

class _TenderSecondaryButtonState extends State<_TenderSecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.15)
                : const Color(0xFF0F1420).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFF9F1C)
                  : const Color(0xFFFF9F1C).withValues(alpha: 0.60),
              width: 1.4,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF9F1C).withValues(alpha: 0.20),
                      blurRadius: 14,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.download_rounded,
                color: Color(0xFFFF9F1C),
                size: 16,
              ),
              const SizedBox(width: 9),
              Text(
                'DOWNLOAD 2026 CAPABILITY PROSPECTUS',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Architectural Drafting Grid with Coordinate Crosshairs
class _DraftingGridPainter extends CustomPainter {
  final double opacity;
  const _DraftingGridPainter({this.opacity = 0.20});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF223041).withValues(alpha: opacity)
      ..strokeWidth = 0.8;

    final tickPaint = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: opacity * 1.5)
      ..strokeWidth = 1.0;

    const double step = 48.0;

    for (double x = step; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = step; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (double x = step * 2; x < size.width - 20; x += step * 2) {
      for (double y = step * 2; y < size.height - 20; y += step * 2) {
        canvas.drawLine(Offset(x - 3, y), Offset(x + 3, y), tickPaint);
        canvas.drawLine(Offset(x, y - 3), Offset(x, y + 3), tickPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DraftingGridPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}

/// Precision Tech Corner Brackets in Safety Amber
class _TechCornerBracketPainter extends CustomPainter {
  final Color color;
  const _TechCornerBracketPainter({this.color = const Color(0xFFFF9F1C)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const double arm = 14.0;
    const double inset = 12.0;

    // Top-Left bracket
    canvas.drawLine(
        const Offset(inset, inset + arm), const Offset(inset, inset), paint);
    canvas.drawLine(
        const Offset(inset, inset), const Offset(inset + arm, inset), paint);

    // Bottom-Left bracket
    canvas.drawLine(Offset(inset, size.height - inset - arm),
        Offset(inset, size.height - inset), paint);
    canvas.drawLine(Offset(inset, size.height - inset),
        Offset(inset + arm, size.height - inset), paint);

    // Top-Right bracket
    canvas.drawLine(Offset(size.width - inset - arm, inset),
        Offset(size.width - inset, inset), paint);
    canvas.drawLine(Offset(size.width - inset, inset),
        Offset(size.width - inset, inset + arm), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Prestige Project Card — full-bleed image with bottom fade overlay ────
/// Image fills the entire card. Content (title, location, desc, arrow) fades
/// in from the bottom over a dark gradient. Status badge sits top-left.
class _PrestigeProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  const _PrestigeProjectCard({required this.project});

  @override
  State<_PrestigeProjectCard> createState() => _PrestigeProjectCardState();
}

class _PrestigeProjectCardState extends State<_PrestigeProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final proj = widget.project;
    final Color statusColor = proj['statusColor'] as Color;
    final String status = proj['status'] as String;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hovered ? 0.65 : 0.3),
              blurRadius: _hovered ? 32 : 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Full-bleed project photo ──
              AnimatedScale(
                scale: _hovered ? 1.06 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                child: Image.asset(
                  proj['image'] as String,
                  fit: BoxFit.cover,
                ),
              ),

              // ── Bottom-to-top dark gradient fade ──
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        const Color(0xFF0D0F14).withValues(
                          alpha: _hovered ? 0.92 : 0.82,
                        ),
                      ],
                      stops: const [0.0, 0.35, 1.0],
                    ),
                  ),
                ),
              ),

              // ── Status badge — top left ──
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0D12).withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusColor,
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withValues(alpha: 0.6),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Content overlay — slides up on hover ──
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSlide(
                  offset: _hovered ? Offset.zero : const Offset(0, 0.06),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Title + location + description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                proj['title'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  height: 1.25,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFFCBD5E1),
                                    size: 12,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    proj['location'] as String,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFFCBD5E1),
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                proj['desc'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(0xFFCBD5E1)
                                      .withValues(alpha: 0.80),
                                  fontSize: 12,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Circular arrow button
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _hovered
                                  ? const Color(0xFFFF9F1C)
                                  : Colors.white.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                            color: _hovered
                                ? const Color(0xFFFF9F1C).withValues(alpha: 0.2)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: _hovered
                                ? const Color(0xFFFF9F1C)
                                : Colors.white.withValues(alpha: 0.8),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
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

/// Architectural Blueprint Project Card (Technical Drafting Table Concept)
class _ArchitecturalBlueprintCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onInspect;

  const _ArchitecturalBlueprintCard({
    required this.project,
    required this.isDesktop,
    required this.isTablet,
    required this.onInspect,
  });

  @override
  State<_ArchitecturalBlueprintCard> createState() =>
      _ArchitecturalBlueprintCardState();
}

class _ArchitecturalBlueprintCardState
    extends State<_ArchitecturalBlueprintCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final double cardHeight = widget.isDesktop
        ? 510.0
        : (widget.isTablet ? 490.0 : 470.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: _JsConstructionsWebsiteScreenState.kSafetyAmber.withValues(
                alpha: _isHovered ? 0.35 : 0.08,
              ),
              blurRadius: _isHovered ? 30 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // High-Res Architectural Photograph
              AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                child: AppImage(
                  assetPath: p['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // Architectural Blueprint Drafting Table Grid Overlay
              Positioned.fill(
                child: CustomPaint(
                  painter: _BlueprintGridPainter(
                    lineColor: Color(_isHovered ? 0x2200C0FF : 0x12FFFFFF),
                    step: 28.0,
                  ),
                ),
              ),

              // Architectural Darkening Scrim
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.70),
                      Colors.black.withValues(alpha: 0.15),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                      _JsConstructionsWebsiteScreenState.kObsidian.withValues(
                        alpha: 0.98,
                      ),
                    ],
                    stops: const [0.0, 0.20, 0.45, 0.70, 1.0],
                  ),
                ),
              ),

              // Galvanized Outer Metal Border
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isHovered
                        ? _JsConstructionsWebsiteScreenState.kSafetyAmber
                        : _JsConstructionsWebsiteScreenState.kSiteBorder,
                    width: _isHovered ? 1.8 : 1.2,
                  ),
                ),
              ),

              // Corner Drafting Table Rivets
              _buildCornerRivet(top: 8, left: 8),
              _buildCornerRivet(top: 8, right: 8),
              _buildCornerRivet(bottom: 8, left: 8),
              _buildCornerRivet(bottom: 8, right: 8),

              // Bottom Hazard Warning Stripe
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 3,
                child: CustomPaint(
                  painter: _HazardStripePainter(),
                ),
              ),

              // Top Technical Drawing Headers & Drawing Set Tag
              Positioned(
                top: 14,
                left: 14,
                right: 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: _JsConstructionsWebsiteScreenState.kSafetyAmber
                                    .withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.domain_rounded,
                                  size: 11,
                                  color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    p['badge'] as String,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _JsConstructionsWebsiteScreenState.kSiteBorder,
                            ),
                          ),
                          child: Text(
                            p['drawingCode'] ?? p['year'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              color: _JsConstructionsWebsiteScreenState.kBlueprintCyan,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Blueprint Architectural Specs Pedestal
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(widget.isDesktop ? 22.0 : 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 14,
                                height: 2,
                                color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                p['location'] as String,
                                style: GoogleFonts.spaceGrotesk(
                                  color: _JsConstructionsWebsiteScreenState.kSafetyAmberGlow,
                                  fontSize: widget.isDesktop ? 10 : 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            p['height'] as String,
                            style: GoogleFonts.spaceGrotesk(
                              color: _JsConstructionsWebsiteScreenState.kSteelMuted,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p['title'] as String,
                        style: GoogleFonts.plusJakartaSans(
                          color: _JsConstructionsWebsiteScreenState.kSteel,
                          fontSize: widget.isDesktop ? 22 : 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p['desc'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: _JsConstructionsWebsiteScreenState.kSteelMuted,
                          fontSize: 12.5,
                          height: 1.45,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onInspect,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: _JsConstructionsWebsiteScreenState.kSteel,
                                side: BorderSide(
                                  color: _JsConstructionsWebsiteScreenState.kSafetyAmber
                                      .withValues(alpha: 0.5),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 11),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Text(
                                'VIEW ARCHITECTURAL SPECS',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCornerRivet({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF3A3F50),
          border: Border.all(
            color: _JsConstructionsWebsiteScreenState.kSafetyAmber.withValues(
              alpha: 0.5,
            ),
            width: 0.8,
          ),
        ),
      ),
    );
  }
}

/// Heavy Industrial Plant Spotlight Dock
class _HeavyMachineSpotlightDock extends StatelessWidget {
  final Map<String, dynamic> machine;
  final bool isDesktop;
  final bool isTablet;

  const _HeavyMachineSpotlightDock({
    required this.machine,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 36 : 20),
      decoration: BoxDecoration(
        color: _JsConstructionsWebsiteScreenState.kConcreteSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _JsConstructionsWebsiteScreenState.kSafetyAmber.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Hazard caution line across top of dock
          SizedBox(
            height: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: const CustomPaint(
                painter: _HazardStripePainter(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 768;

              final machineVisual = Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: isWide ? 380 : 260,
                    height: isWide ? 300 : 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          _JsConstructionsWebsiteScreenState.kSafetyAmber
                              .withValues(alpha: 0.25),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    machine['image'] as String,
                    height: isWide ? 320 : 220,
                    fit: BoxFit.contain,
                  ),
                ],
              );

              final machineDetails = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _JsConstructionsWebsiteScreenState.kSafetyAmber
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                          ),
                        ),
                        child: Text(
                          machine['tag'] as String,
                          style: GoogleFonts.spaceGrotesk(
                            color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFF22C55E),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'TELEMETRY: OPERATIONAL',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFF22C55E),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    machine['name'] as String,
                    style: GoogleFonts.plusJakartaSans(
                      color: _JsConstructionsWebsiteScreenState.kSteel,
                      fontSize: isDesktop ? 26 : 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MODEL: ${machine['model']} • ${machine['role']}',
                    style: GoogleFonts.spaceGrotesk(
                      color: _JsConstructionsWebsiteScreenState.kSafetyAmberGlow,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    machine['desc'] as String,
                    style: GoogleFonts.plusJakartaSans(
                      color: _JsConstructionsWebsiteScreenState.kSteelMuted,
                      fontSize: 13.5,
                      height: 1.55,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Heavy Spec Pillars
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _JsConstructionsWebsiteScreenState.kObsidian,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: _JsConstructionsWebsiteScreenState.kSiteBorder,
                      ),
                    ),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 12,
                      children: [
                        _buildSpecPill('OPERATING WEIGHT', machine['weight'] as String),
                        _buildSpecPill('POWERTRAIN', machine['power'] as String),
                        _buildSpecPill('DIG / BUCKET CAPACITY', machine['depth'] as String),
                        _buildSpecPill('CYCLE VELOCITY', machine['speed'] as String),
                      ],
                    ),
                  ),
                ],
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: machineVisual),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: machineDetails),
                  ],
                );
              } else {
                return Column(
                  children: [
                    machineVisual,
                    const SizedBox(height: 20),
                    machineDetails,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecPill(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: _JsConstructionsWebsiteScreenState.kSafetyAmber,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: GoogleFonts.spaceGrotesk(
            color: _JsConstructionsWebsiteScreenState.kSteel,
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

/// Corner style for the Zone 04 Technical Blueprint Cards
enum _TechCardCorner { topLeft, topRight }

/// Path generator for the chamfered tech card geometry
Path _buildTechCardPath(
  Size size,
  _TechCardCorner corner,
  double chamfer,
  double r,
) {
  final path = Path();
  final w = size.width;
  final h = size.height;

  if (corner == _TechCardCorner.topLeft) {
    path.moveTo(chamfer, 0);
    path.lineTo(w - r, 0);
    path.arcToPoint(Offset(w, r), radius: Radius.circular(r));
    path.lineTo(w, h - r);
    path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    path.lineTo(r, h);
    path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    path.lineTo(0, chamfer);
    path.lineTo(chamfer, 0);
    path.close();
  } else {
    path.moveTo(r, 0);
    path.lineTo(w - chamfer, 0);
    path.lineTo(w, chamfer);
    path.lineTo(w, h - r);
    path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
    path.lineTo(r, h);
    path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
    path.lineTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
    path.close();
  }

  return path;
}

/// Custom painter for the tech card chamfer, border and orange corner accent
class _TechCardBackgroundPainter extends CustomPainter {
  final _TechCardCorner corner;
  final double chamfer;
  final double cornerRadius;
  final Color borderColor;
  final Color fillColor;
  final bool hasOrangeAccent;
  final bool isHovered;

  _TechCardBackgroundPainter({
    required this.corner,
    this.chamfer = 24.0,
    this.cornerRadius = 6.0,
    required this.borderColor,
    required this.fillColor,
    this.hasOrangeAccent = false,
    this.isHovered = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildTechCardPath(size, corner, chamfer, cornerRadius);

    // 1. Hover ambient glow
    if (isHovered) {
      final glowPaint = Paint()
        ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);
      canvas.drawPath(path, glowPaint);
    }

    // 2. Background fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Crisp tech stroke border
    final strokePaint = Paint()
      ..color = isHovered
          ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
          : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? 1.5 : 1.2;
    canvas.drawPath(path, strokePaint);

    // 4. Solid Orange Corner Triangle (matching the top-right corner notch on Cards 02 & 04)
    if (hasOrangeAccent && corner == _TechCardCorner.topRight) {
      final accentPath = Path()
        ..moveTo(size.width - chamfer, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, chamfer)
        ..close();

      final accentPaint = Paint()
        ..color = const Color(0xFFFF9F1C)
        ..style = PaintingStyle.fill;
      canvas.drawPath(accentPath, accentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _TechCardBackgroundPainter oldDelegate) =>
      oldDelegate.corner != corner ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.hasOrangeAccent != hasOrangeAccent ||
      oldDelegate.isHovered != isHovered;
}

/// Diagonal 45-degree Blueprint Hazard accent painter
class _DiagonalAccentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.45)
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Structural Blueprint System Tile (Zone 04 Engineering)
class _StructuralBlueprintSystemTile extends StatefulWidget {
  final String num;
  final String code;
  final String title;
  final String desc;
  final String spec;
  final IconData icon;
  final _TechCardCorner corner;
  final bool hasOrangeAccent;

  const _StructuralBlueprintSystemTile({
    super.key,
    required this.num,
    required this.code,
    required this.title,
    required this.desc,
    required this.spec,
    required this.icon,
    this.corner = _TechCardCorner.topLeft,
    this.hasOrangeAccent = false,
  });

  @override
  State<_StructuralBlueprintSystemTile> createState() =>
      _StructuralBlueprintSystemTileState();
}

class _StructuralBlueprintSystemTileState
    extends State<_StructuralBlueprintSystemTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        child: CustomPaint(
          painter: _TechCardBackgroundPainter(
            corner: widget.corner,
            chamfer: 24.0,
            cornerRadius: 6.0,
            borderColor: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
                : const Color(0xFF223041),
            fillColor: const Color(0xF00A0E17),
            hasOrangeAccent: widget.hasOrangeAccent,
            isHovered: _isHovered,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row: Icon Box + (Number & Code)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Box
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0x24FF9F1C),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _isHovered
                              ? const Color(0xFFFF9F1C)
                              : const Color(0xFFFF9F1C).withValues(alpha: 0.55),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.icon,
                          color: const Color(0xFFFF9F1C),
                          size: 22,
                        ),
                      ),
                    ),
                    // Number + Code
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.num,
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF64748B),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.code,
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF64748B),
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Card Title
                Text(
                  widget.title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  widget.desc,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF94A3B8),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom Tag / Spec Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4.5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1017),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: const Color(0xFFFF9F1C).withValues(alpha: 0.55),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    widget.spec,
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFFF9F1C),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Path generator for the tabbed military dossier folder card geometry
Path _buildDossierCardPath(
  Size size, {
  double tabWidth = 64.0,
  double stepDown = 12.0,
  double cornerRadius = 8.0,
}) {
  final path = Path();
  final w = size.width;
  final h = size.height;
  final r = cornerRadius;

  path.moveTo(r, 0);
  path.lineTo(tabWidth, 0);
  path.lineTo(tabWidth + stepDown, stepDown);
  path.lineTo(w - r, stepDown);
  path.arcToPoint(Offset(w, stepDown + r), radius: Radius.circular(r));
  path.lineTo(w, h - r);
  path.arcToPoint(Offset(w - r, h), radius: Radius.circular(r));
  path.lineTo(r, h);
  path.arcToPoint(Offset(0, h - r), radius: Radius.circular(r));
  path.lineTo(0, r);
  path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
  path.close();

  return path;
}

/// Custom painter for the tabbed dossier card background, glow and technical border
class _DossierCardBackgroundPainter extends CustomPainter {
  final double tabWidth;
  final double stepDown;
  final double cornerRadius;
  final Color borderColor;
  final Color fillColor;
  final bool isHovered;

  _DossierCardBackgroundPainter({
    this.tabWidth = 64.0,
    this.stepDown = 12.0,
    this.cornerRadius = 8.0,
    required this.borderColor,
    required this.fillColor,
    this.isHovered = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final effectiveTabWidth = (size.width * 0.38).clamp(56.0, 78.0);
    final path = _buildDossierCardPath(
      size,
      tabWidth: effectiveTabWidth,
      stepDown: stepDown,
      cornerRadius: cornerRadius,
    );

    // 1. Ambient outer glow when hovered
    if (isHovered) {
      final glowPaint = Paint()
        ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.18)
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);
      canvas.drawPath(path, glowPaint);
    }

    // 2. Translucent dark fill
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 3. Technical stroke border
    final strokePaint = Paint()
      ..color = isHovered
          ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
          : borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = isHovered ? 1.5 : 1.2;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _DossierCardBackgroundPainter oldDelegate) =>
      oldDelegate.tabWidth != tabWidth ||
      oldDelegate.stepDown != stepDown ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.isHovered != isHovered;
}

/// Field Superintendent Dossier Badge Card (Zone 05 Leadership)
class _FieldSuperintendentDossierCard extends StatefulWidget {
  final String name;
  final String role;
  final String cred;
  final String badgeId;
  final IconData icon;

  const _FieldSuperintendentDossierCard({
    super.key,
    required this.name,
    required this.role,
    required this.cred,
    required this.badgeId,
    this.icon = Icons.engineering_rounded,
  });

  @override
  State<_FieldSuperintendentDossierCard> createState() =>
      _FieldSuperintendentDossierCardState();
}

class _FieldSuperintendentDossierCardState
    extends State<_FieldSuperintendentDossierCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        child: CustomPaint(
          painter: _DossierCardBackgroundPainter(
            stepDown: 12.0,
            cornerRadius: 8.0,
            borderColor: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
                : const Color(0xFF223548),
            fillColor: const Color(0xF0070B12),
            isHovered: _isHovered,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row: Circular Avatar nestled on left + Corps ID Badge on right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Avatar Container
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0x28FF9F1C),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isHovered
                              ? const Color(0xFFFF9F1C)
                              : const Color(0xFFFF9F1C).withValues(alpha: 0.55),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.icon,
                          color: const Color(0xFFFF9F1C),
                          size: 20,
                        ),
                      ),
                    ),
                    // Corps ID Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF090D14),
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: const Color(0xFFFF9F1C).withValues(alpha: 0.55),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        widget.badgeId,
                        style: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFFFF9F1C),
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  widget.name,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),

                // Role (Safety Amber)
                Text(
                  widget.role,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFFF9F1C),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),

                // Credentials / Specialty
                Text(
                  widget.cred,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF94A3B8),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// HIGH-END CUSTOM CONSTRUCTION PAINTERS (MATERIALS, STEEL, & ATMOSPHERE)
// ════════════════════════════════════════════════════════════════════════════

/// Structural Steel Gantry Perimeter Overlay (Hero Entrance Frame)
class _SiteGantryFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final steelPaint = Paint()
      ..color = const Color(0xFF1E232E).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final yellowLine = Paint()
      ..color = const Color(0xFFFF9F1C).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Left steel I-Beam column
    canvas.drawLine(const Offset(24, 0), Offset(24, size.height), steelPaint);
    canvas.drawLine(const Offset(31, 0), Offset(31, size.height), yellowLine);

    // Right steel I-Beam column
    canvas.drawLine(Offset(size.width - 24, 0), Offset(size.width - 24, size.height), steelPaint);
    canvas.drawLine(Offset(size.width - 31, 0), Offset(size.width - 31, size.height), yellowLine);

    // Cross Truss Braces
    final trussPaint = Paint()
      ..color = const Color(0xFF283040).withValues(alpha: 0.35)
      ..strokeWidth = 3;

    for (double y = 80; y < size.height; y += 180) {
      canvas.drawLine(Offset(24, y), Offset(100, y + 90), trussPaint);
      canvas.drawLine(Offset(100, y), Offset(24, y + 90), trussPaint);
      canvas.drawLine(Offset(size.width - 24, y), Offset(size.width - 100, y + 90), trussPaint);
      canvas.drawLine(Offset(size.width - 100, y), Offset(size.width - 24, y + 90), trussPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Atmospheric Dust & Haze Particles
class _AtmosphericDustPainter extends CustomPainter {
  final double progress;

  const _AtmosphericDustPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final dustPaint = Paint()..style = PaintingStyle.fill;

    final random = math.Random(42);
    for (int i = 0; i < 45; i++) {
      final x = (random.nextDouble() * size.width + progress * 60) % size.width;
      final y = (random.nextDouble() * size.height - progress * 100) % size.height;
      final radius = 1.0 + random.nextDouble() * 2.2;
      final alpha = (0.15 + random.nextDouble() * 0.35).clamp(0.0, 1.0);

      dustPaint.color = const Color(0xFFFFE0A0).withValues(alpha: alpha);
      canvas.drawCircle(Offset(x, y), radius, dustPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AtmosphericDustPainter oldDelegate) =>
      oldDelegate.progress != progress;
}



// ── Fleet circular chevron arrow button (< and >) ───────────────────────────
class _FleetCircleArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _FleetCircleArrow({
    required this.icon,
    required this.onTap,
  });

  @override
  State<_FleetCircleArrow> createState() => _FleetCircleArrowState();
}

class _FleetCircleArrowState extends State<_FleetCircleArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? const Color(0xFFE5A93B).withValues(alpha: 0.22)
                : Colors.black.withValues(alpha: 0.45),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFFE5A93B)
                  : Colors.white.withValues(alpha: 0.20),
              width: 1.2,
            ),
          ),
          child: Icon(
            widget.icon,
            color: _hovered ? const Color(0xFFE5A93B) : Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}

// ── Right-side fleet feature badge item ──────────────────────────────────────
class _FleetFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FleetFeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE5A93B),
              width: 1.5,
            ),
            color: Colors.black.withValues(alpha: 0.35),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFE5A93B),
            size: 20,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF94A3B8),
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


/// Precision Architectural Blueprint Millimeter Grid
class _BlueprintGridPainter extends CustomPainter {
  final Color lineColor;
  final double step;

  const _BlueprintGridPainter({
    this.lineColor = const Color(0x12FF9F1C),
    this.step = 36.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 0.8;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// High-Precision Hazard Warning Chevron Stripe Painter
class _HazardStripePainter extends CustomPainter {
  const _HazardStripePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFF161922);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final stripePaint =
        Paint()..color = const Color(0xFFFF9F1C).withValues(alpha: 0.90);
    const stripeWidth = 14.0;
    for (
      double x = -size.height;
      x < size.width + size.height;
      x += stripeWidth * 2
    ) {
      final path =
          Path()
            ..moveTo(x, size.height)
            ..lineTo(x + stripeWidth, size.height)
            ..lineTo(x + stripeWidth + size.height, 0)
            ..lineTo(x + size.height, 0)
            ..close();
      canvas.drawPath(path, stripePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Aeon Architectural Stylized Logo Painter
class _AeonLogoPainter extends CustomPainter {
  const _AeonLogoPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final orangePaint = Paint()
      ..color = const Color(0xFFFF9F1C)
      ..style = PaintingStyle.fill;

    // Left chevron beam
    final leftBeam = Path()
      ..moveTo(w * 0.38, 0)
      ..lineTo(w * 0.54, 0)
      ..lineTo(w * 0.18, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(leftBeam, orangePaint);

    // Right chevron upper beam
    final rightBeam = Path()
      ..moveTo(w * 0.40, 0)
      ..lineTo(w * 0.56, 0)
      ..lineTo(w * 0.86, h * 0.65)
      ..lineTo(w * 0.70, h * 0.65)
      ..close();
    canvas.drawPath(rightBeam, orangePaint);

    // White lower right wedge
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final whiteWedge = Path()
      ..moveTo(w * 0.52, h)
      ..lineTo(w * 0.80, h * 0.60)
      ..lineTo(w, h * 0.60)
      ..lineTo(w * 0.72, h)
      ..close();
    canvas.drawPath(whiteWedge, whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Technical yellow/amber top border line for the footer panel
class _FooterTopBorderPainter extends CustomPainter {
  final Color lineColor;
  final double strokeWidth;

  const _FooterTopBorderPainter({
    this.lineColor = const Color(0xFFFF9F1C),
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    const stepY = 12.0;
    final leftStepX = (w * 0.10).clamp(50.0, 130.0);
    final rightStepX = w - (w * 0.14).clamp(60.0, 160.0);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(leftStepX, 0)
      ..lineTo(leftStepX + stepY, stepY)
      ..lineTo(rightStepX - 24.0, stepY)
      ..lineTo(rightStepX - 16.0, stepY + 6.0)
      ..lineTo(rightStepX + 16.0, stepY + 6.0)
      ..lineTo(rightStepX + 24.0, 0)
      ..lineTo(w, 0);

    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(path, paint);

    // Corner tech accent ticks
    final tickPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(leftStepX + stepY, stepY + 4),
      Offset(leftStepX + stepY + 12, stepY + 4),
      tickPaint,
    );
    canvas.drawLine(
      Offset(rightStepX - 24.0, stepY + 4),
      Offset(rightStepX - 12.0, stepY + 4),
      tickPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FooterTopBorderPainter oldDelegate) => false;
}

/// Hazard warning diagonal slashes for the bottom-right of the copyright bar
class _FooterBottomHazardPainter extends CustomPainter {
  const _FooterBottomHazardPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF9F1C)
      ..style = PaintingStyle.fill;

    const barW = 5.0;
    const gap = 3.5;
    const count = 4;

    for (int i = 0; i < count; i++) {
      final x = i * (barW + gap);
      final path = Path()
        ..moveTo(x + size.height * 0.7, 0)
        ..lineTo(x + size.height * 0.7 + barW, 0)
        ..lineTo(x + barW, size.height)
        ..lineTo(x, size.height)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Interactive quick link in the footer with smooth hover transition
class _FooterNavLink extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const _FooterNavLink({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  State<_FooterNavLink> createState() => _FooterNavLinkState();
}

class _FooterNavLinkState extends State<_FooterNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.translationValues(_isHovered ? 3 : 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.plusJakartaSans(
                  color: _isHovered
                      ? const Color(0xFFFF9F1C)
                      : const Color(0xFFE2E8F0),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: _isHovered
                    ? const Color(0xFFFF9F1C)
                    : const Color(0xFF64748B),
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular social media button with hover effect
class _FooterSocialButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _FooterSocialButton({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  State<_FooterSocialButton> createState() => _FooterSocialButtonState();
}

class _FooterSocialButtonState extends State<_FooterSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.15)
                : const Color(0x331E293B),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFF9F1C)
                  : const Color(0xFF334155),
              width: 1.0,
            ),
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
