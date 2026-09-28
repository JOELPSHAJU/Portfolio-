import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';

/// ════════════════════════════════════════════════════════════════════════════
/// THE LUMINA PALACE & RESORT — Ultra-Luxury 5-Star Hospitality Experience UI
///
/// Features:
/// - Smooth-as-butter scroll playback: when the user scrolls down, the video
///   plays forward smoothly at 60fps; when the user scrolls up, it reverses.
/// - Decoupled hardware video playback prevents stutter and dropped frames.
/// - Dynamic staged editorial overlays that progress as the user scrubs
///   (Grand Catching Hero -> Architecture/Numbers -> Spa & Gastronomy -> Transition).
/// - Clean presentation with NO player controls.
/// - Once the video finishes (at the end of the scroll track), as the user continues
///   scrolling, the video seamlessly moves UP and exits, and the following sections
///   scroll in normally directly below it without any overlapping.
/// - Full luxury suite collection with high-res architectural images, booking bar,
///   epicurean dining, thalasso spa, VIP concierge privileges, and editorial footer.
/// ════════════════════════════════════════════════════════════════════════════
class LuxuryHotelWebsiteScreen extends StatefulWidget {
  const LuxuryHotelWebsiteScreen({super.key});

  @override
  State<LuxuryHotelWebsiteScreen> createState() =>
      _LuxuryHotelWebsiteScreenState();
}

class _LuxuryHotelWebsiteScreenState extends State<LuxuryHotelWebsiteScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier<double>(
    0.0,
  );

  // Dual-Video Native 60FPS Hardware Engine (Forward + True Hardware Reverse)
  late VideoPlayerController _forwardController;
  late VideoPlayerController _reverseController;
  final ValueNotifier<bool> _isReversingNotifier = ValueNotifier<bool>(false);
  bool _isInitialized = false;
  bool _hasError = false;

  double _lastScrollOffset = 0.0;
  int _targetMs = 0;
  Timer? _scrollDebounceTimer;
  bool _isAutoTourRunning = false;

  // Selected suite filter
  String _selectedCategory = 'all';

  // Section global keys for smooth scrolling navigation
  final GlobalKey _suitesKey = GlobalKey();
  final GlobalKey _diningKey = GlobalKey();
  final GlobalKey _spaKey = GlobalKey();
  final GlobalKey _conciergeKey = GlobalKey();
  final GlobalKey _bookingKey = GlobalKey();

  // Scroll distance dedicated to scrubbing the video from 0:00 to end
  static const double kVideoScrollDistance = 2400.0;

  // Color Palette - Ultra Luxury Haute Hospitality
  static const Color kGold = Color(0xFFC5A059);
  static const Color kGoldLight = Color(0xFFE5C583);
  static const Color kObsidian = Color(0xFF08090D);
  static const Color kCharcoal = Color(0xFF11141D);
  static const Color kCardDark = Color(0xFF161A26);
  static const Color kIvory = Color(0xFFF6F4EE);
  static const Color kMuted = Color(0xFF9BA3AF);

  @override
  void initState() {
    super.initState();
    _initVideo();
    _scrollController.addListener(_handleScrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/hotel_cover.jpg'), context);
    precacheImage(
      const AssetImage('assets/hotel_suite_penthouse.jpg'),
      context,
    );
    precacheImage(const AssetImage('assets/hotel_suite_platinum.jpg'), context);
    precacheImage(const AssetImage('assets/hotel_suite_villa.jpg'), context);
    precacheImage(
      const AssetImage('assets/hotel_dining_michelin.jpg'),
      context,
    );
    precacheImage(const AssetImage('assets/hotel_spa_wellness.jpg'), context);
  }

  Future<void> _initVideo() async {
    try {
      _forwardController = VideoPlayerController.asset(
        'assets/hotel_intro.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      _reverseController = VideoPlayerController.asset(
        'assets/hotel_intro_reversed.mp4',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await Future.wait([
        _forwardController.initialize(),
        _reverseController.initialize(),
      ]);

      await Future.wait([
        _forwardController.setVolume(0.0),
        _reverseController.setVolume(0.0),
        _forwardController.setLooping(false),
        _reverseController.setLooping(false),
      ]);

      // Prime opening frames
      await _forwardController.play();
      await Future.delayed(const Duration(milliseconds: 30));
      await _forwardController.pause();
      await _forwardController.seekTo(Duration.zero);

      final totalRev = _reverseController.value.duration;
      await _reverseController.seekTo(totalRev);

      _forwardController.addListener(_onForwardTick);
      _reverseController.addListener(_onReverseTick);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _handleScrollListener();
      }
    } catch (e) {
      debugPrint('Hotel intro video init error: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _onForwardTick() {
    if (!_forwardController.value.isInitialized) return;
    if (_isReversingNotifier.value) return;
    if (!_forwardController.value.isPlaying) return;

    final current = _forwardController.value.position.inMilliseconds;
    if (current >= _targetMs - 15) {
      _forwardController.pause();
    }
  }

  void _onReverseTick() {
    if (!_reverseController.value.isInitialized) return;
    if (!_isReversingNotifier.value) return;
    if (!_reverseController.value.isPlaying) return;

    final totalMs = _forwardController.value.duration.inMilliseconds > 0
        ? _forwardController.value.duration.inMilliseconds
        : 10000;
    final current = _reverseController.value.position.inMilliseconds;
    final revTargetMs = (totalMs - _targetMs).clamp(0, totalMs);
    if (current >= revTargetMs - 15) {
      _reverseController.pause();
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

    final double progress = (currentOffset / kVideoScrollDistance).clamp(
      0.0,
      1.0,
    );
    final int newTargetMs = (totalMs * progress).round().clamp(0, totalMs);
    final bool isScrollingDown = currentOffset >= _lastScrollOffset;
    _lastScrollOffset = currentOffset;
    _targetMs = newTargetMs;

    if (isScrollingDown) {
      // ── Scrolling Forward (Down) ──────────────────────────────────────────
      if (_isReversingNotifier.value) {
        // Was reversing -> switch seamlessly to forward from EXACT current position
        _reverseController.pause();
        final currentRev = _reverseController.value.position.inMilliseconds;
        final currentFwd = (totalMs - currentRev).clamp(0, totalMs);
        _forwardController.seekTo(Duration(milliseconds: currentFwd));
        _isReversingNotifier.value = false;
      }

      final currentFwd = _forwardController.value.position.inMilliseconds;
      final diff = _targetMs - currentFwd;

      if (diff > 2500) {
        // Large jump or scrollbar drag: fast seek
        _forwardController.seekTo(Duration(milliseconds: _targetMs));
        _forwardController.pause();
      } else if (diff > 25) {
        // Native 60 FPS hardware playback glides to target
        final double speed = (diff / 220.0).clamp(1.0, 3.5);
        _forwardController.setPlaybackSpeed(speed);
        if (!_forwardController.value.isPlaying) {
          _forwardController.play();
        }
      } else if (diff <= 0) {
        // Reached or passed target
      }
    } else {
      // ── Scrolling Backward (Up) ───────────────────────────────────────────
      final revTargetMs = (totalMs - _targetMs).clamp(0, totalMs);

      if (!_isReversingNotifier.value) {
        // Was forwarding -> switch seamlessly to reverse from EXACT current position
        _forwardController.pause();
        final currentFwd = _forwardController.value.position.inMilliseconds;
        final currentRev = (totalMs - currentFwd).clamp(0, totalMs);
        _reverseController.seekTo(Duration(milliseconds: currentRev));
        _isReversingNotifier.value = true;
      }

      final currentRev = _reverseController.value.position.inMilliseconds;
      final diff = revTargetMs - currentRev;

      if (diff > 2500) {
        // Large jump or scrollbar drag: fast seek
        _reverseController.seekTo(Duration(milliseconds: revTargetMs));
        _reverseController.pause();
      } else if (diff > 25) {
        // Native 60 FPS hardware playback glides in reverse to target
        final double speed = (diff / 220.0).clamp(1.0, 3.5);
        _reverseController.setPlaybackSpeed(speed);
        if (!_reverseController.value.isPlaying) {
          _reverseController.play();
        }
      } else if (diff <= 0) {
        _reverseController.pause();
      }
    }

    _scheduleDebounceCheck(totalMs);
  }

  void _scheduleDebounceCheck(int totalMs) {
    _scrollDebounceTimer?.cancel();
    _scrollDebounceTimer = Timer(const Duration(milliseconds: 70), () {
      if (!mounted || !_isInitialized) return;
      if (!_isReversingNotifier.value) {
        if (_forwardController.value.position.inMilliseconds >=
            _targetMs - 25) {
          _forwardController.pause();
        }
      } else {
        final revTargetMs = (totalMs - _targetMs).clamp(0, totalMs);
        if (_reverseController.value.position.inMilliseconds >=
            revTargetMs - 25) {
          _reverseController.pause();
        }
      }
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
        ((kVideoScrollDistance - startOffset) / kVideoScrollDistance).clamp(
          0.05,
          1.0,
        );
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
    _scrollDebounceTimer?.cancel();
    _scrollOffsetNotifier.dispose();
    _isReversingNotifier.dispose();
    _scrollController.dispose();
    if (_isInitialized) {
      _forwardController.removeListener(_onForwardTick);
      _reverseController.removeListener(_onReverseTick);
      _forwardController.dispose();
      _reverseController.dispose();
    }
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
      kVideoScrollDistance + screenHeight,
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeInOutCubic,
    );
  }

  // ── Suites Data ─────────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _suites = [
    {
      'id': 'royal_penthouse',
      'category': 'presidential',
      'title': 'The Royal Imperial Penthouse',
      'tagline':
          '450 m² • 360° Ocean Vista • Private Plunge Pool & Helipad Pier',
      'price': '\$4,800',
      'period': '/ night',
      'badge': 'PREMIER MASTERWORK',
      'image': 'assets/hotel_suite_penthouse.jpg',
      'sqm': '450 m²',
      'guests': 'Up to 6 Guests',
      'view': 'Panoramic Azure Horizon',
      'features': [
        'Private heated cliffside infinity plunge pool',
        '24/7 Dedicated Royal Butler & Private Chef',
        'Hermès Paris bespoke bath amenities',
        'Temperature-controlled sommelier wine cellar',
        'Bang & Olufsen Beolab 90 acoustic sanctuary',
      ],
      'description':
          'Suspended between azure sea and open sky, the Royal Imperial Penthouse commands the entire crown floor. Sculpted marble floors, private sunset sundeck, dual master wings, and unconditional white-glove butler service create the pinnacle of private Mediterranean sanctuary.',
    },
    {
      'id': 'platinum_suite',
      'category': 'presidential',
      'title': 'The Platinum Ocean Suite',
      'tagline': '280 m² • Wraparound Teak Terrace • Carved Marble Soaking Spa',
      'price': '\$2,950',
      'period': '/ night',
      'badge': 'SIGNATURE SANCTUARY',
      'image': 'assets/hotel_suite_platinum.jpg',
      'sqm': '280 m²',
      'guests': 'Up to 4 Guests',
      'view': 'Unobstructed Sunrise Bay',
      'features': [
        'Curved Mediterranean sunrise terrace',
        'Custom hand-stitched silk and velvet bedding',
        'Direct elevator connection to Thalasso Spa',
        'Complimentary Dom Pérignon vintage on arrival',
        'Italian walnut dressing parlor with bespoke vanity',
      ],
      'description':
          'Embodying classic Riviera glamour with contemporary architectural quietude, the Platinum Ocean Suite surrounds you with warm walnut millwork, handcrafted furnishings, and gentle ocean breezes across an expansive private terrace.',
    },
    {
      'id': 'lagoon_villa',
      'category': 'villas',
      'title': 'The Azure Lagoon Villa',
      'tagline': '320 m² • Direct Overwater Access • Secluded Tropical Garden',
      'price': '\$3,400',
      'period': '/ night',
      'badge': 'PRIVATE OVERWATER',
      'image': 'assets/hotel_suite_villa.jpg',
      'sqm': '320 m²',
      'guests': 'Up to 4 Guests',
      'view': 'Private Lagoon & Coral Garden',
      'features': [
        'Private teak boardwalk with secluded catamaran berth',
        'Outdoor rain grotto shower amidst exotic palms',
        'Crystal glass floor observation panel',
        'Nightly private sunset dinner setup on the pier',
        'In-villa signature spa massages by appointment',
      ],
      'description':
          'Tucked along our private crystalline cove, the Azure Lagoon Villa provides absolute seclusion. Step directly from your private infinity sundeck into the sparkling waters, surrounded by lush native botanical gardens and whispering palms.',
    },
    {
      'id': 'horizon_ocean',
      'category': 'oceanfront',
      'title': 'Grand Horizon Suite',
      'tagline': '190 m² • Floor-to-Ceiling Glass • Private Sunset Firepit',
      'price': '\$1,950',
      'period': '/ night',
      'badge': 'COASTAL VISTA',
      'image': 'assets/hotel_suite_penthouse.jpg',
      'sqm': '190 m²',
      'guests': 'Up to 3 Guests',
      'view': 'Western Sunset Coastline',
      'features': [
        'Floor-to-ceiling motorized acoustic glass facade',
        'Artisan espresso & private cocktail bar',
        'Rainfall wet room with heated limestone benches',
        'Evening starlight turndown & aromatherapy selection',
        'Complimentary chauffeured Rolls-Royce transfers',
      ],
      'description':
          'Watch the sun dissolve into the Mediterranean from your private cliffside lounge. Featuring open-concept spatial proportions, state-of-the-art smart environmental controls, and unmatched serenity.',
    },
  ];

  // ── Dining Venues ───────────────────────────────────────────────────────────
  final List<Map<String, dynamic>> _diningVenues = [
    {
      'name': "L'Étoile Céeste",
      'stars': '★★★ MICHELIN GUIDE',
      'chef': 'Chef Patron Alexandre Valmont',
      'cuisine': 'Haute French Coastal Gastronomy',
      'hours': '18:30 – 23:00 • Formal Attire',
      'highlight': '18,000 Vintage Wine Vault with Head Sommelier Pairings',
    },
    {
      'name': 'The Mirage Lounge & Raw Bar',
      'stars': 'COCKTAIL & RAW ARTISTRY',
      'chef': 'Master Omakase Shunsuke Mori',
      'cuisine': 'Edomae Sushi & Rare Botanical Mixology',
      'hours': '12:00 – 01:00 • Smart Casual',
      'highlight': 'Suspended Glass Deck Overilluminated Evening Waves',
    },
    {
      'name': 'The Pergola Caviar Courtyard',
      'stars': 'AL FRESCO DEGUSTATION',
      'chef': 'Chef de Cuisine Hélène Rostand',
      'cuisine': 'Black Truffle, Caviar & Champagne Flight',
      'hours': '11:00 – 19:00 • Resort Chic',
      'highlight': 'Private Olive Grove Pergolas with Live Cello Harmony',
    },
  ];

  // ── Spa Treatments ──────────────────────────────────────────────────────────
  final List<Map<String, String>> _spaTreatments = [
    {
      'title': 'Swiss Cellular Bio-Regeneration',
      'time': '90 MIN',
      'price': '\$550',
      'desc':
          'Targeted cellular infusion utilizing Swiss alpine glacier peptides and pure collagen masks to revitalize youthfulness.',
    },
    {
      'title': 'Deep Grotto Marine Hydrotherapy',
      'time': '120 MIN',
      'price': '\$680',
      'desc':
          'Immersion in heated subterranean mineral pools, followed by dead sea salt exfoliation and pressure point reflexology.',
    },
    {
      'title': 'Twilight Starlight Couple Ritual',
      'time': '150 MIN',
      'price': '\$1,100',
      'desc':
          'Private night access to the cave plunge pools, dual hot stone botanical oil massage, finished with Dom Pérignon.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 650 && screenSize.width < 1024;

    return Scaffold(
      backgroundColor: kObsidian,
      body: Stack(
        children: [
          // ── 1. The Scroll-Driven Video Hero ───────────────────────────────
          // Stays pinned at translateY = 0 while scrollOffset <= kVideoScrollDistance.
          // Once scrollOffset > kVideoScrollDistance (video has finished), it translates
          // UP and exits: translateY = -(scrollOffset - kVideoScrollDistance).
          ValueListenableBuilder<double>(
            valueListenable: _scrollOffsetNotifier,
            builder: (context, scrollOffset, _) {
              double translateY = 0.0;
              if (scrollOffset > kVideoScrollDistance) {
                translateY = -(scrollOffset - kVideoScrollDistance);
              }

              // Off-screen check: if completely scrolled above viewport, unmount to save GPU
              if (translateY <= -screenSize.height) {
                return const SizedBox.shrink();
              }

              // Progress tracking: tracks scroll progress for timed overlays
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
                        // Video Player (Dual-Video Native 60FPS Hardware Engine)
                        if (_isInitialized && !_hasError)
                          FittedBox(
                            fit: BoxFit.cover,
                            clipBehavior: Clip.hardEdge,
                            child: SizedBox(
                              width: _forwardController.value.size.width > 0
                                  ? _forwardController.value.size.width
                                  : 1920,
                              height: _forwardController.value.size.height > 0
                                  ? _forwardController.value.size.height
                                  : 1080,
                              child: ValueListenableBuilder<bool>(
                                valueListenable: _isReversingNotifier,
                                builder: (context, isReversing, _) {
                                  return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Opacity(
                                        opacity: isReversing ? 0.0 : 1.0,
                                        child: VideoPlayer(_forwardController),
                                      ),
                                      Opacity(
                                        opacity: isReversing ? 1.0 : 0.0,
                                        child: VideoPlayer(_reverseController),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        else
                          Container(
                            color: kObsidian,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: kGold,
                                strokeWidth: 2,
                              ),
                            ),
                          ),

                        // Scrim Overlays
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.65),
                                Colors.black.withValues(alpha: 0.35),
                                Colors.black.withValues(alpha: 0.80),
                              ],
                              stops: const [0.0, 0.45, 1.0],
                            ),
                          ),
                        ),

                        // Vignette
                        Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 1.25,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.50),
                              ],
                              stops: const [0.55, 1.0],
                            ),
                          ),
                        ),

                        // Progressive Staged Overlays (Change as user scrubs)
                        _buildTimedOverlays(progress, isDesktop),

                        // Subtle Scroll Cue & Autoplay Directive Controls
                        if (progress < 0.22)
                          Positioned(
                            bottom: 28,
                            left: 0,
                            right: 0,
                            child: Opacity(
                              opacity: (1.0 - progress / 0.22).clamp(0.0, 1.0),
                              child: Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12,
                                  runSpacing: 10,
                                  children: [
                                    InkWell(
                                      onTap: () => _scrollToNextSection(
                                        screenSize.height,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withValues(
                                            alpha: 0.55,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: kGold.withValues(
                                              alpha: 0.35,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'SCROLL TO EXPLORE (START TO FINISH)',
                                              style: GoogleFonts.spaceMono(
                                                color: kIvory,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: kGold,
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
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _isAutoTourRunning
                                              ? kGold
                                              : Colors.black.withValues(
                                                  alpha: 0.55,
                                                ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: kGold.withValues(alpha: 0.6),
                                          ),
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
                                                  : kGold,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              _isAutoTourRunning
                                                  ? 'PAUSE TOUR'
                                                  : 'AUTOPLAY FULL EXPERIENCE',
                                              style: GoogleFonts.spaceMono(
                                                color: _isAutoTourRunning
                                                    ? kObsidian
                                                    : kIvory,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
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

          // ── 2. The Main Page Scrollable Content ───────────────────────────
          // Top spacer is exactly (kVideoScrollDistance + screenSize.height).
          // At scrollOffset == kVideoScrollDistance:
          //   the content's viewport Y is (kVideoScrollDistance + H) - kVideoScrollDistance = H!
          //   It touches the bottom of the video with ZERO overlap!
          // As scrollOffset continues past kVideoScrollDistance:
          //   the video translates UP, and the content scrolls UP directly behind it,
          //   moving together as one contiguous vertical document without ever overlapping on top!
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Perfect geometric spacer: guarantees zero overlap with video
                SizedBox(height: kVideoScrollDistance + screenSize.height),

                // SECTION 1: DIRECT RESERVATION BAR
                RepaintBoundary(
                  child: _buildInstantBookingBar(isDesktop, isTablet),
                ),

                // SECTION 2: THE SUITE COLLECTION (Rooms & Real High-Res Images)
                RepaintBoundary(
                  child: Container(
                    key: _suitesKey,
                    child: _buildSuitesSection(isDesktop, isTablet),
                  ),
                ),

                // SECTION 3: EPICUREAN DINING & GASTRONOMY
                RepaintBoundary(
                  child: Container(
                    key: _diningKey,
                    child: _buildDiningSection(isDesktop, isTablet),
                  ),
                ),

                // SECTION 4: THE SOMA THALASSO SPA & WELLNESS
                RepaintBoundary(
                  child: Container(
                    key: _spaKey,
                    child: _buildSpaSection(isDesktop, isTablet),
                  ),
                ),

                // SECTION 5: BESPOKE CONCIERGE & FLEET PRIVILEGES
                RepaintBoundary(
                  child: Container(
                    key: _conciergeKey,
                    child: _buildConciergeSection(isDesktop, isTablet),
                  ),
                ),

                // SECTION 6: WORLD ACCOLADES & FORBES RATINGS
                RepaintBoundary(
                  child: _buildAccoladesSection(isDesktop, isTablet),
                ),

                // SECTION 7: GRAND LUXURY EDITORIAL FOOTER
                RepaintBoundary(child: _buildLuxuryFooter(isDesktop, isTablet)),
              ],
            ),
          ),

          // ── 3. Sticky Top Floating Navigation Bar ─────────────────────────
          RepaintBoundary(child: _buildFloatingNavBar(isDesktop)),

          // ── 4. Floating Back to Portfolio Pill ────────────────────────────
          // Positioned(
          //   top: 16,
          //   left: 16,
          //   child: SafeArea(child: _buildBackToPortfolioButton()),
          // ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // TIMED / SCROLL-PROGRESS EDITORIAL OVERLAYS
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTimedOverlays(double progress, bool isDesktop) {
    final opacity1 = _calculateOverlayOpacity(progress, 0.00, 0.28);
    final opacity2 = _calculateOverlayOpacity(progress, 0.28, 0.58);
    final opacity3 = _calculateOverlayOpacity(progress, 0.58, 0.85);
    final opacity4 = _calculateOverlayOpacity(progress, 0.85, 1.00);

    return Stack(
      children: [
        if (opacity1 > 0.01) _buildStage1Hero(isDesktop, opacity1),
        if (opacity2 > 0.01) _buildStage2Architecture(isDesktop, opacity2),
        if (opacity3 > 0.01) _buildStage3Wellness(isDesktop, opacity3),
        if (opacity4 > 0.01) _buildStage4Transition(isDesktop, opacity4),
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

  // ── Stage 1: TOP-LEFT ANCHORED (Forbes Grand Sanctuary) ────────────────────
  Widget _buildStage1Hero(bool isDesktop, double opacity) {
    return Positioned(
      top: isDesktop ? 96 : 64,
      left: isDesktop ? 64 : 20,
      right: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 740 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: kGold, width: 1.2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: kGold, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          isDesktop
                              ? 'FORBES 5-STAR WORLD RESORT • EST. 1928'
                              : 'FORBES 5-STAR RESORT • EST. 1928',
                          style: GoogleFonts.spaceMono(
                            color: kGold,
                            fontSize: isDesktop ? 10 : 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: isDesktop ? 2.2 : 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'THE LUMINA\nPALACE',
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 76 : 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  height: 1.04,
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
                'FRENCH RIVIERA PRIVATE SANCTUARY',
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 16 : 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Where Mediterranean heritage meets azure immensity. Sculpted into the limestone promontory of Côte d\'Azur with 98 cliffside infinity suites, three-star Michelin dining, and subterranean thalasso grottos.',
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.92),
                  fontSize: isDesktop ? 16 : 13,
                  height: 1.6,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Text(
                  '43°42\'12"N • 7°25\'08"E | CAP-FERRAT • PRIVATE HELIPAD & MARINA',
                  style: GoogleFonts.spaceMono(
                    color: kIvory.withValues(alpha: 0.75),
                    fontSize: isDesktop ? 10 : 8.5,
                    letterSpacing: isDesktop ? 1.8 : 1.0,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stage 2: TOP-RIGHT ANCHORED (Monumental Architecture) ─────────────────
  Widget _buildStage2Architecture(bool isDesktop, double opacity) {
    return Positioned(
      top: isDesktop ? 96 : 64,
      right: isDesktop ? 64 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 620 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDesktop) ...[
                    Container(width: 24, height: 2, color: kGold),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '01 / MONUMENTAL CRAFT',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 8),
                    Container(width: 24, height: 2, color: kGold),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'SCULPTED INTO\nLIVING CLIFFS',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 54 : 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  height: 1.08,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'A BOUNDLESS HORIZON OF LIMESTONE & AZURE',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 14 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'A secluded Mediterranean promontory designed for total privacy. Every suite, terrace, and infinity horizon plunge is cantilevered toward the boundless azure.',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.88),
                  fontSize: isDesktop ? 15 : 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: isDesktop ? WrapAlignment.end : WrapAlignment.start,
                children: [
                  _buildStatGlassCard(
                    '98',
                    'INFINITY POOLS',
                    'Private cliffside plunges',
                  ),
                  _buildStatGlassCard(
                    '360°',
                    'OCEAN PANORAMA',
                    'Uninterrupted azure views',
                  ),
                  _buildStatGlassCard(
                    '100%',
                    'SECLUDED PRIVACY',
                    'Direct helipad & marina',
                  ),
                  _buildStatGlassCard(
                    '24/7',
                    'BUTLER GUILD',
                    'Certified white-glove service',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stage 3: BOTTOM-LEFT ANCHORED (Sensory Mastery) ───────────────────────
  Widget _buildStage3Wellness(bool isDesktop, double opacity) {
    return Positioned(
      bottom: isDesktop ? 70 : 40,
      left: isDesktop ? 64 : 20,
      right: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 680 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 24, height: 2, color: kGold),
                  const SizedBox(width: 8),
                  Text(
                    '02 / SENSORY MASTERY',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'SUBTERRANEAN THALASSO\n& 3-STAR GASTRONOMY',
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 46 : 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  height: 1.1,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.9),
                      blurRadius: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'HEALING THERMAL CAVERNS & HAUTE ALCHEMY',
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 14 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Immerse in mineral seawater thermal grottoes deep within natural limestone rock caverns. Ascend at dusk to Michelin-starred feasts and an eighteen-thousand-bottle private sommelier cellar.',
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.88),
                  fontSize: isDesktop ? 15 : 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildStatGlassCard(
                    '3 ★',
                    'MICHELIN GUIDED',
                    'Haute coastal alchemy',
                  ),
                  _buildStatGlassCard(
                    '18K',
                    'VINTAGE CELLAR',
                    'Two centuries of rare vintages',
                  ),
                  _buildStatGlassCard(
                    '4,000 m²',
                    'THALASSO GROTTO',
                    'Deep mineral rejuvenation',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stage 4: BOTTOM-RIGHT ANCHORED (Suites & Arrival Invitation) ──────────
  Widget _buildStage4Transition(bool isDesktop, double opacity) {
    return Positioned(
      bottom: isDesktop ? 70 : 40,
      right: isDesktop ? 64 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDesktop) ...[
                    Container(width: 24, height: 2, color: kGold),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '03 / THE COLLECTION',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 8),
                    Container(width: 24, height: 2, color: kGold),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'YOUR SANCTUARY\nAWAITS',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 54 : 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  height: 1.08,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 36,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'IMPERIAL PENTHOUSES & OVERWATER VILLAS',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 14 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Explore our signature architectural suites featuring private infinity horizon plunges, 24/7 personal butler guild, and dedicated yacht moorings.',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.88),
                  fontSize: isDesktop ? 15 : 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: () => _scrollToKey(_suitesKey),
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 26 : 18,
                    vertical: isDesktop ? 15 : 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kGold, Color(0xFFD4AF37)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: kGold.withValues(alpha: 0.4),
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
                          'EXPLORE SUITES & VILLAS',
                          style: GoogleFonts.spaceMono(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: isDesktop ? 12 : 10,
                            letterSpacing: isDesktop ? 2 : 1.2,
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

  Widget _buildStatGlassCard(String number, String title, String subtitle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: 170,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.68),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: kGold.withValues(alpha: 0.45),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                number,
                style: GoogleFonts.cinzel(
                  color: kGold,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.spaceMono(
                  color: kIvory,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: GoogleFonts.outfit(
                  color: kMuted,
                  fontSize: 11,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 1: DIRECT SANCTUARY RESERVATION BAR
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildInstantBookingBar(bool isDesktop, bool isTablet) {
    return Container(
      key: _bookingKey,
      margin: EdgeInsets.fromLTRB(
        isDesktop ? 60 : (isTablet ? 30 : 12),
        36,
        isDesktop ? 60 : (isTablet ? 30 : 12),
        16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : (isTablet ? 20 : 14),
        vertical: isDesktop ? 24 : 18,
      ),
      decoration: BoxDecoration(
        color: kCharcoal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGold.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 35,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 16, height: 2, color: kGold),
                  const SizedBox(width: 8),
                  Text(
                    isDesktop
                        ? 'DIRECT SANCTUARY RESERVATION'
                        : 'SANCTUARY RESERVATION',
                    style: GoogleFonts.cinzel(
                      color: kGold,
                      fontSize: isDesktop ? 11 : 9.5,
                      letterSpacing: isDesktop ? 2.2 : 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'BEST SUITE PRIVILEGES GUARANTEED',
                style: GoogleFonts.spaceMono(
                  color: kMuted,
                  fontSize: isDesktop ? 10 : 8.5,
                  letterSpacing: isDesktop ? 1.1 : 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (isDesktop)
            Row(
              children: [
                Expanded(
                  child: _buildBookingInputField(
                    icon: Icons.calendar_today_rounded,
                    label: 'CHECK-IN',
                    value: 'Oct 14, 2026',
                    subtitle: 'From 15:00',
                  ),
                ),
                _buildBookingDivider(isDesktop: true),
                Expanded(
                  child: _buildBookingInputField(
                    icon: Icons.calendar_month_rounded,
                    label: 'CHECK-OUT',
                    value: 'Oct 21, 2026',
                    subtitle: '7 Nights Stay',
                  ),
                ),
                _buildBookingDivider(isDesktop: true),
                Expanded(
                  child: _buildBookingInputField(
                    icon: Icons.person_outline_rounded,
                    label: 'GUESTS',
                    value: '2 Adults, 1 Suite',
                    subtitle: 'Private Butler Concierge',
                  ),
                ),
                _buildBookingDivider(isDesktop: true),
                Expanded(
                  child: _buildBookingInputField(
                    icon: Icons.bed_outlined,
                    label: 'TIER',
                    value: 'Imperial Penthouse',
                    subtitle: 'Complimentary Yacht Transfer',
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _openBookingDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGold,
                    foregroundColor: kObsidian,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 22,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'CHECK AVAILABILITY',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildBookingInputField(
                        icon: Icons.calendar_today_rounded,
                        label: 'DATES',
                        value: 'Oct 14 – 21, 2026',
                        subtitle: '7 Nights',
                        compact: true,
                      ),
                    ),
                    _buildBookingDivider(isDesktop: false),
                    Expanded(
                      child: _buildBookingInputField(
                        icon: Icons.person_outline_rounded,
                        label: 'GUESTS',
                        value: '2 Adults',
                        subtitle: 'Butler Concierge',
                        compact: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _openBookingDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kObsidian,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'CHECK SANCTUARY AVAILABILITY',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBookingDivider({bool isDesktop = true}) {
    return Container(
      width: 1,
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 16 : 6),
      color: kGold.withValues(alpha: 0.2),
    );
  }

  Widget _buildBookingInputField({
    required IconData icon,
    required String label,
    required String value,
    required String subtitle,
    bool compact = false,
  }) {
    return InkWell(
      onTap: () => _openBookingDialog(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: compact ? 4 : 8, vertical: 4),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(compact ? 8 : 10),
              decoration: BoxDecoration(
                color: kGold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kGold.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: kGold, size: compact ? 16 : 20),
            ),
            SizedBox(width: compact ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.spaceMono(
                      color: kMuted,
                      fontSize: compact ? 9 : 10,
                      letterSpacing: compact ? 1.0 : 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    style: GoogleFonts.cinzel(
                      color: kIvory,
                      fontSize: compact ? 12 : 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      color: kGoldLight.withValues(alpha: 0.7),
                      fontSize: compact ? 10 : 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 2: THE SUITE COLLECTION
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildSuitesSection(bool isDesktop, bool isTablet) {
    final filteredSuites = _selectedCategory == 'all'
        ? _suites
        : _suites.where((s) => s['category'] == _selectedCategory).toList();

    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 40,
    );

    return Container(
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterTab('all', 'ALL SANCTUARIES', _suites.length),
                _buildFilterTab('presidential', 'ROYAL & PLATINUM', 2),
                _buildFilterTab('villas', 'OVERWATER & VILLAS', 1),
                _buildFilterTab('oceanfront', 'OCEAN HORIZON', 1),
              ],
            ),
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
                    child: _CompactLuxurySanctuaryCard(
                      suite: suite,
                      sanctuaryNumber: '0${index + 1}',
                      isDesktop: isDesktop,
                      isTablet: isTablet,
                      onReserve: () => _openReserveSuiteModal(context, suite),
                      onExplore: () => _openSuiteDetailsModal(context, suite),
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

  Widget _buildFilterTab(String id, String label, int count) {
    final isSelected = _selectedCategory == id;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = id),
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

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 3: EPICUREAN DINING & GASTRONOMY
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildDiningSection(bool isDesktop, bool isTablet) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 60,
    );

    return Container(
      color: kCharcoal.withValues(alpha: 0.6),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: kGold),
              const SizedBox(width: 12),
              Text(
                'GASTRONOMY & SOMMELIER',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "EPICUREAN HAUTE CUISINE",
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 38 : (isTablet ? 30 : 24),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              "Led by Master Chef Alexandre Valmont, our three Michelin-starred culinary venues marry rare wild Mediterranean catch with ancestral French techniques and an underground cellar of 18,000 vintage crus.",
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        const SizedBox(
                          height: 520,
                          width: double.infinity,
                          child: AppImage(
                            assetPath: 'assets/hotel_dining_michelin.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  kObsidian.withValues(alpha: 0.8),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 28,
                          left: 28,
                          right: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: kGold,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '3 MICHELIN STARS • CHEF ALEXANDRE VALMONT',
                                  style: GoogleFonts.cinzel(
                                    color: kObsidian,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "L'Étoile Céeste",
                                style: GoogleFonts.cinzel(
                                  color: kIvory,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Candlelit terraces hovering over the moonlit Mediterranean with sommelier flights and coastal caviar degustation.",
                                style: GoogleFonts.outfit(
                                  color: kIvory.withValues(alpha: 0.85),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: _diningVenues.map((v) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: kCardDark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: kGold.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  v['stars'],
                                  style: GoogleFonts.spaceMono(
                                    color: kGold,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  v['hours'],
                                  style: GoogleFonts.outfit(
                                    color: kMuted,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              v['name'],
                              style: GoogleFonts.cinzel(
                                color: kIvory,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${v['chef']} • ${v['cuisine']}',
                              style: GoogleFonts.outfit(
                                color: kGoldLight.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              v['highlight'],
                              style: GoogleFonts.outfit(
                                color: kMuted,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 14),
                            InkWell(
                              onTap: () => _openTableReservationDialog(
                                context,
                                v['name'],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'RESERVE A TABLE',
                                    style: GoogleFonts.cinzel(
                                      color: kGold,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: kGold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const SizedBox(
                    height: 280,
                    width: double.infinity,
                    child: AppImage(
                      assetPath: 'assets/hotel_dining_michelin.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ..._diningVenues.map((v) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: kCardDark,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: kGold.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          v['stars'],
                          style: GoogleFonts.spaceMono(
                            color: kGold,
                            fontSize: 10,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          v['name'],
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          v['highlight'],
                          style: GoogleFonts.outfit(
                            color: kMuted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () =>
                              _openTableReservationDialog(context, v['name']),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: kGold),
                            foregroundColor: kGold,
                          ),
                          child: const Text('RESERVE TABLE'),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 4: THE SOMA THALASSO SPA & WELLNESS
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildSpaSection(bool isDesktop, bool isTablet) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 60,
    );

    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: kGold),
              const SizedBox(width: 12),
              Text(
                'WELLNESS & CELLULAR THERAPY',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'THE SOMA THALASSO SANCTUARY',
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 38 : (isTablet ? 30 : 24),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Descend into 4,000 m² of natural subterranean limestone grottoes. Featuring geothermal mineral lagoons, Swiss anti-aging cellular rituals, and pure sensory deprivation sanctuaries.',
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),

          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                SizedBox(
                  height: isDesktop ? 480 : (isTablet ? 400 : 390),
                  width: double.infinity,
                  child: const AppImage(
                    assetPath: 'assets/hotel_spa_wellness.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                // Dual-side horizontal fade blending both left and right edges into the background
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          kObsidian,
                          kObsidian.withValues(alpha: 0.95),
                          kObsidian.withValues(alpha: 0.70),
                          kObsidian.withValues(alpha: 0.15),
                          Colors.transparent,
                          Colors.transparent,
                          kObsidian.withValues(alpha: 0.20),
                          kObsidian.withValues(alpha: 0.75),
                          kObsidian.withValues(alpha: 0.95),
                          kObsidian,
                        ],
                        stops: const [
                          0.0,
                          0.08,
                          0.22,
                          0.38,
                          0.48,
                          0.60,
                          0.72,
                          0.85,
                          0.94,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                ),
                // Subtle vertical top and bottom vignette blend
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kObsidian.withValues(alpha: 0.5),
                          Colors.transparent,
                          Colors.transparent,
                          kObsidian.withValues(alpha: 0.65),
                        ],
                        stops: const [0.0, 0.18, 0.82, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: isDesktop ? 40 : 20,
                  right: isDesktop ? null : 20,
                  top: isDesktop ? 40 : 24,
                  bottom: isDesktop ? 40 : null,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isDesktop ? 480 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: kGold.withValues(alpha: 0.2),
                            border: Border.all(color: kGold),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isDesktop
                                ? 'SUBTERRANEAN HYDROTHERMAL GROTTO'
                                : 'HYDROTHERMAL GROTTO',
                            style: GoogleFonts.spaceMono(
                              color: kGold,
                              fontSize: isDesktop ? 10 : 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: isDesktop ? 1.5 : 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          'Natural Limestone Salt Cave Thermal Circuit',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: isDesktop ? 28 : 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Filtered seawater drawn directly from 80 meters deep, enriched with marine magnesium and ionized sea salts at 38°C.',
                          style: GoogleFonts.outfit(
                            color: kIvory.withValues(alpha: 0.8),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _openSpaMenuDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGold,
                            foregroundColor: kObsidian,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'VIEW RITUALS & RESERVE',
                            style: GoogleFonts.cinzel(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: _spaTreatments.map((t) {
              return Container(
                width: isDesktop
                    ? (MediaQuery.of(context).size.width - 160) / 3
                    : double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: kCardDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kGold.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          t['time']!,
                          style: GoogleFonts.spaceMono(
                            color: kGold,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          t['price']!,
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t['title']!,
                      style: GoogleFonts.cinzel(
                        color: kIvory,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t['desc']!,
                      style: GoogleFonts.outfit(
                        color: kMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 5: BESPOKE CONCIERGE & FLEET PRIVILEGES
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildConciergeSection(bool isDesktop, bool isTablet) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 20),
      vertical: 60,
    );

    final privileges = [
      {
        'icon': Icons.airplanemode_active_rounded,
        'title': 'AgustaWestland Helipad',
        'desc':
            'Direct private landing strip connecting Nice, Cannes, and Monaco in under 12 minutes.',
      },
      {
        'icon': Icons.directions_boat_rounded,
        'title': 'Private Superyacht Marina',
        'desc':
            'Deep-water moorings accommodating vessels up to 85m with bespoke onboard provisioning.',
      },
      {
        'icon': Icons.directions_car_filled_rounded,
        'title': 'Rolls-Royce Chauffeur',
        'desc':
            'Complimentary on-demand Phantom and Ghost airport transfers and coastal excursions.',
      },
      {
        'icon': Icons.wine_bar_rounded,
        'title': 'Private Island Degustation',
        'desc':
            'Secluded tender excursions uninhabited coves with your private chef and sommelier.',
      },
    ];

    return Container(
      color: kCharcoal.withValues(alpha: 0.4),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 32, height: 2, color: kGold),
              const SizedBox(width: 12),
              Text(
                'WHITE-GLOVE PRIVILEGES',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'BESPOKE CONCIERGE & FLEET',
            style: GoogleFonts.cinzel(
              color: kIvory,
              fontSize: isDesktop ? 38 : (isTablet ? 30 : 24),
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              'No bespoke request is unattainable. Our certified Les Clefs d’Or royal concierge guild curates unforgettable air, land, and sea transitions for all resident patrons.',
              style: GoogleFonts.outfit(
                color: kMuted,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 36),

          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: privileges.map((p) {
              return Container(
                width: isDesktop
                    ? (MediaQuery.of(context).size.width - 192) / 4
                    : (isTablet
                          ? (MediaQuery.of(context).size.width - 90) / 2
                          : double.infinity),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: kCardDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: kGold.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kGold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kGold.withValues(alpha: 0.3)),
                      ),
                      child: Icon(
                        p['icon'] as IconData,
                        color: kGold,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      p['title'] as String,
                      style: GoogleFonts.cinzel(
                        color: kIvory,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      p['desc'] as String,
                      style: GoogleFonts.outfit(
                        color: kMuted,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 6: WORLD ACCOLADES & FORBES RATINGS
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildAccoladesSection(bool isDesktop, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 50,
      ),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: kGold.withValues(alpha: 0.2)),
        ),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: isDesktop ? 60 : 30,
          runSpacing: 24,
          children: [
            _buildAwardBadge(
              'FORBES TRAVEL GUIDE',
              '★ ★ ★ ★ ★',
              'FIVE-STAR VERIFIED 2026',
            ),
            _buildAwardBadge(
              'CONDÉ NAST TRAVELER',
              'GOLD LIST',
              '#1 BEST RESORT IN EUROPE',
            ),
            _buildAwardBadge(
              'PRIX VILLÉGIATURE',
              'GRAND PRIX',
              'BEST SUITE ARCHITECTURE',
            ),
            _buildAwardBadge(
              'LES CLEFS D’OR',
              'CONCIERGE GUILD',
              'WHITE-GLOVE DISTINCTION',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardBadge(String issuer, String grade, String award) {
    return Column(
      children: [
        Text(
          issuer,
          style: GoogleFonts.spaceMono(
            color: kMuted,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          grade,
          style: GoogleFonts.cinzel(
            color: kGold,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          award,
          style: GoogleFonts.outfit(
            color: kIvory.withValues(alpha: 0.8),
            fontSize: 12,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // SECTION 7: GRAND LUXURY EDITORIAL FOOTER
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildLuxuryFooter(bool isDesktop, bool isTablet) {
    return Container(
      color: const Color(0xFF040508),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 70,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop ? 40 : 24),
            decoration: BoxDecoration(
              color: kCharcoal,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kGold.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'THE CONNOISSEURS SOCIETY',
                        style: GoogleFonts.spaceMono(
                          color: kGold,
                          fontSize: 11,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Receive Private Suite Releases & Sommelier Invitations',
                        style: GoogleFonts.cinzel(
                          color: kIvory,
                          fontSize: isDesktop ? 22 : 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 32),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: GoogleFonts.outfit(color: kIvory),
                      decoration: InputDecoration(
                        hintText: 'Enter your private email...',
                        hintStyle: GoogleFonts.outfit(color: kMuted),
                        filled: true,
                        fillColor: kObsidian,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: kGold.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: kGold),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kCharcoal,
                          content: Text(
                            'Thank you. Your invitation to the Connoisseurs Circle is confirmed.',
                            style: GoogleFonts.outfit(color: kGold),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kObsidian,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'JOIN',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 60),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.hotel_class_rounded,
                          color: kGold,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'THE LUMINA PALACE',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Cap d’Antibes • French Riviera\n43°32\'58.4"N 7°07\'16.2"E\nDirect Private Helipad 06/24',
                      style: GoogleFonts.outfit(
                        color: kMuted,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                _buildFooterLinks('SANCTUARIES', [
                  'Royal Imperial Penthouse',
                  'Platinum Ocean Suite',
                  'The Azure Lagoon Villa',
                  'Grand Horizon Suite',
                  'Private Island Cabanas',
                ]),
                _buildFooterLinks('EXPERIENCES', [
                  "L'Étoile Céeste (3 Michelin)",
                  'Mirage Raw Bar & Lounge',
                  'Soma Thalasso Grotto Spa',
                  'Superyacht Catamaran Berth',
                  'Helicopter Transfers',
                ]),
                _buildFooterLinks('PRIVATE CONCIERGE', [
                  '+33 (0)4 93 61 38 00',
                  'butler@luminapalace.com',
                  'Helipad Desk: Desk-7 Bravo',
                  'Les Clefs d’Or Sanctioned',
                  'Press & Architecture Inquiries',
                ]),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THE LUMINA PALACE & SPA',
                  style: GoogleFonts.cinzel(
                    color: kIvory,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cap d’Antibes • French Riviera • Private Marina & Helipad',
                  style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
                ),
              ],
            ),

          const SizedBox(height: 50),
          Divider(color: kGold.withValues(alpha: 0.15)),
          const SizedBox(height: 24),

          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Text(
                '© 2026 THE LUMINA PALACE & SPA RESORT. ALL RIGHTS RESERVED.',
                style: GoogleFonts.spaceMono(
                  color: kMuted.withValues(alpha: 0.6),
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'PORTFOLIO SHOWCASE UI • FLUTTER WEB',
                style: GoogleFonts.spaceMono(
                  color: kGold.withValues(alpha: 0.8),
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cinzel(
            color: kGold,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        ...links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              link,
              style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
            ),
          );
        }),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // FLOATING NAVIGATION BAR & CONTROLS
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildFloatingNavBar(bool isDesktop) {
    return Positioned(
      top: 16,
      right: 16,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 20 : 12,
                vertical: isDesktop ? 8 : 6,
              ),
              decoration: BoxDecoration(
                color: kCharcoal.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: kGold.withValues(alpha: 0.25),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.hotel_class_rounded,
                        color: kGold,
                        size: 18,
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 8),
                        Text(
                          'THE LUMINA',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 24),
                    _buildNavButton('SUITES', () => _scrollToKey(_suitesKey)),
                    _buildNavButton('DINING', () => _scrollToKey(_diningKey)),
                    _buildNavButton(
                      'THALASSO SPA',
                      () => _scrollToKey(_spaKey),
                    ),
                    _buildNavButton(
                      'PRIVILEGES',
                      () => _scrollToKey(_conciergeKey),
                    ),
                  ],
                  SizedBox(width: isDesktop ? 16 : 8),
                  ElevatedButton(
                    onPressed: () => _openBookingDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kObsidian,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 16 : 12,
                        vertical: isDesktop ? 10 : 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'RESERVE',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 13),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          label,
          style: GoogleFonts.cinzel(
            color: kIvory.withValues(alpha: 0.8),
            fontSize: 11,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildBackToPortfolioButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: kCharcoal.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: kGold.withValues(alpha: 0.3), width: 1),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(30),
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
                      color: kGold,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'PORTFOLIO',
                      style: GoogleFonts.spaceMono(
                        color: kIvory,
                        fontSize: 11,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
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

  // ════════════════════════════════════════════════════════════════════════════
  // INTERACTIVE MODALS & DIALOGS
  // ════════════════════════════════════════════════════════════════════════════
  void _openBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            backgroundColor: kCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: kGold, width: 1.5),
            ),
            title: Row(
              children: [
                const Icon(Icons.verified_rounded, color: kGold, size: 22),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'CONFIRM SANCTUARY DATES',
                    style: GoogleFonts.cinzel(
                      color: kIvory,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
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
                    'Direct Booking Privilege Inclusions:',
                    style: GoogleFonts.outfit(
                      color: kGold,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPrivilegeBullet(
                    'Complimentary AgustaWestland or Yacht Transfer',
                  ),
                  _buildPrivilegeBullet(
                    'Welcome chilled Dom Pérignon Vintage 2015',
                  ),
                  _buildPrivilegeBullet(
                    'Guaranteed 12:00 Check-in & 16:00 Late Check-out',
                  ),
                  _buildPrivilegeBullet(
                    '24/7 Dedicated White-Glove Butler Guild',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kObsidian,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: kGold.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'OCTOBER 14 – 21, 2026',
                                style: GoogleFonts.spaceMono(
                                  color: kGold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '7 Nights • 2 Guests • Royal Imperial Penthouse',
                                style: GoogleFonts.outfit(
                                  color: kMuted,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$33,600',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('CLOSE', style: GoogleFonts.cinzel(color: kMuted)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kGold,
                      content: Text(
                        'Your provisional haven reservation is registered. Our Butler concierge will contact you shortly.',
                        style: GoogleFonts.outfit(
                          color: kObsidian,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: kObsidian,
                ),
                child: Text(
                  'REQUEST RESERVATION',
                  style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPrivilegeBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: kGold,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.outfit(color: kIvory, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  void _openReserveSuiteModal(
    BuildContext context,
    Map<String, dynamic> suite,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            backgroundColor: kCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: kGold, width: 1.5),
            ),
            title: Text(
              'RESERVE ${suite['title'].toString().toUpperCase()}',
              style: GoogleFonts.cinzel(
                color: kIvory,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${suite['price']} ${suite['period']} • ${suite['sqm']} • ${suite['view']}',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    suite['description'],
                    style: GoogleFonts.outfit(
                      color: kMuted,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(
                  'DISMISS',
                  style: GoogleFonts.cinzel(color: kMuted),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kGold,
                      content: Text(
                        'Sanctuary reserved: ${suite['title']}. Welcome to Lumina Palace.',
                        style: GoogleFonts.outfit(
                          color: kObsidian,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: kObsidian,
                ),
                child: Text(
                  'PROCEED TO CHECKOUT',
                  style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSuiteDetailsModal(
    BuildContext context,
    Map<String, dynamic> suite,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Dialog(
            backgroundColor: kCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: kGold, width: 1.5),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720, maxHeight: 650),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: AppImage(
                          assetPath: suite['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      suite['title'],
                      style: GoogleFonts.cinzel(
                        color: kIvory,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${suite['price']} ${suite['period']} • ${suite['sqm']} • ${suite['guests']}',
                      style: GoogleFonts.spaceMono(
                        color: kGold,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      suite['description'],
                      style: GoogleFonts.outfit(
                        color: kMuted,
                        fontSize: 14,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'BESPOKE SUITE AMENITIES',
                      style: GoogleFonts.cinzel(
                        color: kGold,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...(suite['features'] as List<String>).map((feat) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: kGold,
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              feat,
                              style: GoogleFonts.outfit(
                                color: kIvory,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text(
                            'CLOSE',
                            style: GoogleFonts.cinzel(color: kMuted),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            _openReserveSuiteModal(context, suite);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGold,
                            foregroundColor: kObsidian,
                          ),
                          child: Text(
                            'RESERVE THIS SUITE',
                            style: GoogleFonts.cinzel(
                              fontWeight: FontWeight.bold,
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

  void _openTableReservationDialog(
    BuildContext context,
    String restaurantName,
  ) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            backgroundColor: kCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: kGold, width: 1.5),
            ),
            title: Text(
              'RESERVE TABLE AT $restaurantName',
              style: GoogleFonts.cinzel(
                color: kIvory,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Select preferred seating for dinner tonight. Michelin degustation table with direct sommelier pairing.',
              style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('CANCEL', style: GoogleFonts.cinzel(color: kMuted)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kGold,
                      content: Text(
                        'Table reservation requested for $restaurantName. Sommelier notified.',
                        style: GoogleFonts.outfit(
                          color: kObsidian,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: kObsidian,
                ),
                child: Text(
                  'CONFIRM TABLE',
                  style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSpaMenuDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: AlertDialog(
            backgroundColor: kCharcoal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: kGold, width: 1.5),
            ),
            title: Text(
              'THALASSO SPA SANCTUARY RESERVATION',
              style: GoogleFonts.cinzel(
                color: kIvory,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Direct subterranean private cave suite access reserved for 2 hours with cellular peptide facial & mineral immersion.',
              style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('CANCEL', style: GoogleFonts.cinzel(color: kMuted)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kGold,
                      content: Text(
                        'Spa session booked. Your private therapist has prepared the grotto.',
                        style: GoogleFonts.outfit(
                          color: kObsidian,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGold,
                  foregroundColor: kObsidian,
                ),
                child: Text(
                  'BOOK SESSION',
                  style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// FULL-BLEED CINEMATIC ARCHITECTURAL SANCTUARY CARD (PHOTO IS THE HERO)
// ════════════════════════════════════════════════════════════════════════════
class _CompactLuxurySanctuaryCard extends StatefulWidget {
  final Map<String, dynamic> suite;
  final String sanctuaryNumber;
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onReserve;
  final VoidCallback onExplore;

  const _CompactLuxurySanctuaryCard({
    required this.suite,
    required this.sanctuaryNumber,
    required this.isDesktop,
    required this.isTablet,
    required this.onReserve,
    required this.onExplore,
  });

  @override
  State<_CompactLuxurySanctuaryCard> createState() =>
      _CompactLuxurySanctuaryCardState();
}

class _CompactLuxurySanctuaryCardState
    extends State<_CompactLuxurySanctuaryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.suite;
    final isPremier = s['id'] == 'royal_penthouse';
    final double cardHeight = widget.isDesktop
        ? 520.0
        : (widget.isTablet ? 480.0 : 470.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _LuxuryHotelWebsiteScreenState.kGold.withValues(
                alpha: _isHovered ? 0.30 : (isPremier ? 0.12 : 0.05),
              ),
              blurRadius: _isHovered ? 32 : 18,
              spreadRadius: _isHovered ? 2 : 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── 1. The Architectural Photograph (The 100% Star Attraction) ──
              AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeOutCubic,
                child: AppImage(
                  assetPath: s['image'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // ── 2. Atmospheric Haute-Luxury Gradient Scrims ───────────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.65),
                      Colors.black.withValues(alpha: 0.10),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.50),
                      const Color(0xFF08090D).withValues(alpha: 0.96),
                    ],
                    stops: const [0.0, 0.18, 0.42, 0.68, 1.0],
                  ),
                ),
              ),

              // ── 3. Subtle Outer Gold Highlight Border ─────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? _LuxuryHotelWebsiteScreenState.kGold
                        : (isPremier
                              ? _LuxuryHotelWebsiteScreenState.kGold.withValues(
                                  alpha: 0.45,
                                )
                              : _LuxuryHotelWebsiteScreenState.kGold.withValues(
                                  alpha: 0.20,
                                )),
                    width: _isHovered ? 1.8 : 1.2,
                  ),
                ),
              ),

              // ── 4. Floating Top Architectural Badges ───────────────────────
              Positioned(
                top: widget.isDesktop ? 18 : 12,
                left: widget.isDesktop ? 18 : 12,
                right: widget.isDesktop ? 18 : 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Sanctuary Identifier Badge
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.isDesktop ? 14 : 10,
                              vertical: widget.isDesktop ? 7 : 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.68),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isPremier
                                    ? _LuxuryHotelWebsiteScreenState.kGold
                                    : _LuxuryHotelWebsiteScreenState.kGold
                                          .withValues(alpha: 0.40),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPremier
                                      ? Icons.hotel_class_rounded
                                      : Icons.star_rounded,
                                  size: widget.isDesktop ? 13 : 11,
                                  color: _LuxuryHotelWebsiteScreenState.kGold,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    widget.isDesktop
                                        ? 'SANCTUARY ${widget.sanctuaryNumber}  •  ${s['badge']}'
                                        : '0${widget.sanctuaryNumber} • ${s['badge']}',
                                    style: GoogleFonts.spaceMono(
                                      color:
                                          _LuxuryHotelWebsiteScreenState.kGold,
                                      fontSize: widget.isDesktop ? 10 : 8.5,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: widget.isDesktop
                                          ? 1.5
                                          : 0.8,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Price Tag Glass Pill
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.isDesktop ? 16 : 10,
                            vertical: widget.isDesktop ? 7 : 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: _LuxuryHotelWebsiteScreenState.kGold
                                  .withValues(alpha: 0.45),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                s['price'],
                                style: GoogleFonts.cinzel(
                                  color: _LuxuryHotelWebsiteScreenState.kGold,
                                  fontSize: widget.isDesktop ? 16 : 13.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                ' ${s['period']}',
                                style: GoogleFonts.outfit(
                                  color: _LuxuryHotelWebsiteScreenState.kIvory
                                      .withValues(alpha: 0.85),
                                  fontSize: widget.isDesktop ? 11 : 9.5,
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

              // ── 5. Center Gallery Reticle (Appears on Hover) ───────────────
              Positioned.fill(
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 280),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: InkWell(
                          onTap: widget.onExplore,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.70),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: _LuxuryHotelWebsiteScreenState.kGold,
                                width: 1.4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: _LuxuryHotelWebsiteScreenState.kGold
                                      .withValues(alpha: 0.40),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.fullscreen_rounded,
                                  color: _LuxuryHotelWebsiteScreenState.kGold,
                                  size: 19,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'VIEW ARCHITECTURAL GALLERY',
                                  style: GoogleFonts.cinzel(
                                    color:
                                        _LuxuryHotelWebsiteScreenState.kIvory,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── 6. Bottom Floating Editorial Pedestal ─────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(widget.isDesktop ? 26.0 : 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Subtitle & Specs Row
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 16,
                                height: 1.5,
                                color: _LuxuryHotelWebsiteScreenState.kGold,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${s['category'].toString().toUpperCase()} SANCTUARY',
                                style: GoogleFonts.spaceMono(
                                  color:
                                      _LuxuryHotelWebsiteScreenState.kGoldLight,
                                  fontSize: widget.isDesktop ? 10 : 8.5,
                                  letterSpacing: widget.isDesktop ? 2 : 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFloatingSpec(
                                Icons.square_foot_rounded,
                                s['sqm'],
                              ),
                              const SizedBox(width: 6),
                              _buildFloatingSpec(
                                Icons.people_outline_rounded,
                                s['guests'],
                              ),
                              if (widget.isDesktop) ...[
                                const SizedBox(width: 6),
                                _buildFloatingSpec(
                                  Icons.visibility_outlined,
                                  s['view'],
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Grand Cinzel Sanctuary Title
                      Text(
                        s['title'],
                        style: GoogleFonts.cinzel(
                          color: _LuxuryHotelWebsiteScreenState.kIvory,
                          fontSize: widget.isDesktop
                              ? 26
                              : (widget.isTablet ? 22 : 19),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.95),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Description
                      Text(
                        s['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          color: _LuxuryHotelWebsiteScreenState.kIvory
                              .withValues(alpha: 0.88),
                          fontSize: 13,
                          height: 1.45,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.9),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Bottom Action Row
                      if (widget.isDesktop || widget.isTablet)
                        Row(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.shield_outlined,
                                  color: _LuxuryHotelWebsiteScreenState.kGold,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Dedicated Royal Butler & Helipad Transfer',
                                  style: GoogleFonts.spaceMono(
                                    color: _LuxuryHotelWebsiteScreenState
                                        .kGoldLight
                                        .withValues(alpha: 0.8),
                                    fontSize: 9.5,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            OutlinedButton(
                              onPressed: widget.onExplore,
                              style: OutlinedButton.styleFrom(
                                foregroundColor:
                                    _LuxuryHotelWebsiteScreenState.kIvory,
                                side: BorderSide(
                                  color: _LuxuryHotelWebsiteScreenState.kGold
                                      .withValues(alpha: 0.45),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Text(
                                'EXPLORE',
                                style: GoogleFonts.cinzel(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: widget.onReserve,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _LuxuryHotelWebsiteScreenState.kGold,
                                foregroundColor:
                                    _LuxuryHotelWebsiteScreenState.kObsidian,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 12,
                                ),
                                elevation: 6,
                                shadowColor: _LuxuryHotelWebsiteScreenState
                                    .kGold
                                    .withValues(alpha: 0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'RESERVE',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: widget.onExplore,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      _LuxuryHotelWebsiteScreenState.kIvory,
                                  side: BorderSide(
                                    color: _LuxuryHotelWebsiteScreenState.kGold
                                        .withValues(alpha: 0.45),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'EXPLORE',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: widget.onReserve,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _LuxuryHotelWebsiteScreenState.kGold,
                                  foregroundColor:
                                      _LuxuryHotelWebsiteScreenState.kObsidian,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'RESERVE',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 12,
                                    ),
                                  ],
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

  Widget _buildFloatingSpec(IconData icon, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _LuxuryHotelWebsiteScreenState.kGold.withValues(
                alpha: 0.25,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: _LuxuryHotelWebsiteScreenState.kGold),
              const SizedBox(width: 5),
              Text(
                text,
                style: GoogleFonts.spaceMono(
                  color: _LuxuryHotelWebsiteScreenState.kIvory,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
