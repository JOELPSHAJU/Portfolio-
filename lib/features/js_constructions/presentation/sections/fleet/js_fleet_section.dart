import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/fleet_machine.dart';
import '../../providers/fleet_controller_provider.dart';
import '../../providers/js_constructions_providers.dart';
import '../../widgets/fleet/fleet_circle_arrow.dart';
import '../../widgets/fleet/fleet_feature_item.dart';
import '../../widgets/hero/hero_machinery_stage_transition.dart';
import '../../widgets/hero/hero_machinery_telemetry_tag.dart';
import '../../widgets/hero/interactive_hero_machinery.dart';
import '../../widgets/hero/stage_docking_ring.dart';

/// ZONE 03: POWERFUL MACHINERY FLEET SHOWCASE
class JsFleetSection extends ConsumerStatefulWidget {
  final bool isDesktop;
  final bool isTablet;

  const JsFleetSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  ConsumerState<JsFleetSection> createState() => _JsFleetSectionState();
}

class _JsFleetSectionState extends ConsumerState<JsFleetSection> {
  final ScrollController _fleetThumbScrollController = ScrollController();

  @override
  void dispose() {
    _fleetThumbScrollController.dispose();
    super.dispose();
  }

  void _onSelectFleet(int newIndex, int currentIndex, {int? direction}) {
    if (newIndex == currentIndex) return;
    final int dir = direction ?? (newIndex > currentIndex ? 1 : -1);
    ref
        .read(fleetControllerProvider.notifier)
        .selectIndex(newIndex, direction: dir);

    if (_fleetThumbScrollController.hasClients) {
      const double itemWidth = 142.0;
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

  @override
  Widget build(BuildContext context) {
    final fleetAsync = ref.watch(fleetProvider);
    final fleetState = ref.watch(fleetControllerProvider);

    return fleetAsync.when(
      data: (fleet) {
        if (fleet.isEmpty) return const SizedBox.shrink();
        final selectedIndex = fleetState.selectedIndex.clamp(
          0,
          fleet.length - 1,
        );
        final m = fleet[selectedIndex];

        return Container(
          color: const Color(0xFF090A0E),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = widget.isDesktop
                  ? (width * 9 / 16).clamp(640.0, 920.0)
                  : (widget.isTablet ? 720.0 : 820.0);

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
                        color: Colors.black.withValues(alpha: 0.35),
                      ),
                    ),

                    // ── 2. Layout (Desktop vs Mobile) ──
                    if (widget.isDesktop)
                      _buildFleetDesktopView(
                        fleet,
                        m,
                        selectedIndex,
                        fleetState.direction,
                        width,
                        height,
                      )
                    else
                      _buildFleetMobileView(
                        fleet,
                        m,
                        selectedIndex,
                        fleetState.direction,
                        width,
                        height,
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
      loading: () => const SizedBox(
        height: 700,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFFE5A93B)),
        ),
      ),
      error: (e, st) => const SizedBox.shrink(),
    );
  }

  Widget _buildMachineryTransition(
    Widget child,
    Animation<double> anim,
    FleetMachine m,
    int direction,
  ) {
    final bool isIncoming = (child.key == ValueKey(m.image));

    return HeroMachineryStageTransition(
      animation: anim,
      isIncoming: isIncoming,
      direction: direction,
      child: child,
    );
  }

  Widget _buildFleetDesktopView(
    List<FleetMachine> fleet,
    FleetMachine m,
    int selectedIndex,
    int direction,
    double width,
    double height,
  ) {
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FleetFeatureItem(
                icon: Icons.settings_outlined,
                title: 'High Performance',
                subtitle: 'Maximum productivity in every condition.',
              ),
              SizedBox(height: 22),
              FleetFeatureItem(
                icon: Icons.shield_outlined,
                title: 'Safety First',
                subtitle: 'Built with advanced safety features.',
              ),
              SizedBox(height: 22),
              FleetFeatureItem(
                icon: Icons.access_time_outlined,
                title: 'Well Maintained',
                subtitle: 'Regular servicing for reliable performance.',
              ),
            ],
          ),
        ),

        // ── CENTER: Hero Machinery sitting on the glowing ground platform ──
        Positioned(
          left: width * 0.20,
          right: width * 0.20,
          bottom: height * 0.22,
          height: height * 0.58,
          child: InteractiveHeroMachinery(
            isDesktop: true,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // 1. Stage Backlight Spotlight Glow — flares on vehicle switch
                Positioned(
                  bottom: 25,
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey('glow_$selectedIndex'),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 620),
                    curve: Curves.easeOutCubic,
                    builder: (context, val, _) {
                      final double intensity = 0.38 - (0.16 * val);
                      return Container(
                        width: (width * 0.36).clamp(280.0, 520.0),
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(
                                0xFFFF9F1C,
                              ).withValues(alpha: intensity),
                              const Color(
                                0xFFE5A93B,
                              ).withValues(alpha: intensity * 0.4),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 2. Dynamic Expanding Turntable Docking Shockwave Ring
                Positioned(
                  bottom: 4,
                  child: StageDockingRing(
                    key: ValueKey('ring_$selectedIndex'),
                    width: (width * 0.38).clamp(260.0, 500.0),
                  ),
                ),

                // 3. Subtle ground contact shadow on circular platform
                Positioned(
                  bottom: 12,
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey('shadow_$selectedIndex'),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 620),
                    curve: Curves.easeOutCubic,
                    builder: (context, val, _) {
                      final double widthScale = 0.85 + (0.15 * val);
                      return Container(
                        width:
                            ((width * 0.32).clamp(240.0, 480.0)) * widthScale,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(width * 0.32 * widthScale, 22),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.70),
                              blurRadius: 24,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 4. Animated Machinery Display with 3D Hero Perspective Transition
                Positioned.fill(
                  top: 40,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 620),
                    switchInCurve: Curves.linear,
                    switchOutCurve: Curves.linear,
                    layoutBuilder: (currentChild, previousChildren) => Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.none,
                      children: [
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    ),
                    transitionBuilder: (child, anim) =>
                        _buildMachineryTransition(child, anim, m, direction),
                    child: Image.asset(
                      m.image,
                      key: ValueKey(m.image),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),

                // 5. Floating Hero Machinery HUD Telemetry Pill
                Positioned(
                  top: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, anim) {
                      return FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, -0.35),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: anim,
                                  curve: Curves.easeOutCubic,
                                ),
                              ),
                          child: child,
                        ),
                      );
                    },
                    child: HeroMachineryTelemetryTag.fromEntity(
                      key: ValueKey(m.name),
                      machinery: m,
                      index: selectedIndex,
                      total: fleet.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── LEFT NAV ARROW ──
        Positioned(
          left: width * 0.035,
          top: height * 0.48,
          child: FleetCircleArrow(
            icon: Icons.chevron_left,
            onTap: () {
              final newIdx = (selectedIndex - 1 + fleet.length) % fleet.length;
              _onSelectFleet(newIdx, selectedIndex, direction: -1);
            },
          ),
        ),

        // ── RIGHT NAV ARROW ──
        Positioned(
          right: width * 0.035,
          top: height * 0.48,
          child: FleetCircleArrow(
            icon: Icons.chevron_right,
            onTap: () {
              final newIdx = (selectedIndex + 1) % fleet.length;
              _onSelectFleet(newIdx, selectedIndex, direction: 1);
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
                    children: List.generate(fleet.length, (i) {
                      final item = fleet[i];
                      final bool isSelected = i == selectedIndex;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => _onSelectFleet(i, selectedIndex),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedScale(
                                scale: isSelected ? 1.05 : 1.0,
                                duration: const Duration(milliseconds: 220),
                                curve: Curves.easeOutCubic,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 220),
                                  width: 122,
                                  height: 78,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.black.withValues(alpha: 0.55)
                                        : Colors.black.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFE5A93B)
                                          : Colors.white.withValues(
                                              alpha: 0.08,
                                            ),
                                      width: isSelected ? 1.6 : 1.0,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFFE5A93B,
                                              ).withValues(alpha: 0.35),
                                              blurRadius: 18,
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
                                          item.thumb,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        item.label,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.spaceGrotesk(
                                          color: isSelected
                                              ? const Color(0xFFE5A93B)
                                              : const Color(0xFFCBD5E1),
                                          fontSize: 11,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (i < fleet.length - 1)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Container(
                                width: 3.5,
                                height: 3.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.18),
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
                  final bool isActive =
                      pillIdx == (selectedIndex ~/ 3).clamp(0, 2);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      width: isActive ? 28 : 14,
                      height: 3.5,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFE5A93B)
                            : const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFFE5A93B,
                                  ).withValues(alpha: 0.4),
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

  Widget _buildFleetMobileView(
    List<FleetMachine> fleet,
    FleetMachine m,
    int selectedIndex,
    int direction,
    double width,
    double height,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(width: 24, height: 2, color: const Color(0xFFE5A93B)),
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
            // Hero machinery with arrows & stage lighting
            SizedBox(
              height: 290,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Amber stage backlight glow
                  Positioned(
                    bottom: 25,
                    child: TweenAnimationBuilder<double>(
                      key: ValueKey('mob_glow_$selectedIndex'),
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 620),
                      curve: Curves.easeOutCubic,
                      builder: (context, val, _) {
                        final double intensity = 0.32 - (0.14 * val);
                        return Container(
                          width: 260,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(
                                  0xFFFF9F1C,
                                ).withValues(alpha: intensity),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Docking ring on mobile
                  Positioned(
                    bottom: 2,
                    child: StageDockingRing(
                      key: ValueKey('mob_ring_$selectedIndex'),
                      width: 250,
                    ),
                  ),

                  // Ground contact shadow
                  Positioned(
                    bottom: 12,
                    child: Container(
                      width: 240,
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.elliptical(240, 18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.65),
                            blurRadius: 18,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Hero Machinery Transition
                  Positioned(
                    bottom: 14,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 620),
                      switchInCurve: Curves.linear,
                      switchOutCurve: Curves.linear,
                      layoutBuilder: (currentChild, previousChildren) => Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          ...previousChildren,
                          if (currentChild != null) currentChild,
                        ],
                      ),
                      transitionBuilder: (child, anim) =>
                          _buildMachineryTransition(child, anim, m, direction),
                      child: Image.asset(
                        m.image,
                        key: ValueKey(m.image),
                        height: 220,
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ),

                  // Mobile HUD Tag
                  Positioned(
                    top: 0,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 380),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position:
                              Tween<Offset>(
                                begin: const Offset(0, -0.3),
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: anim,
                                  curve: Curves.easeOutCubic,
                                ),
                              ),
                          child: child,
                        ),
                      ),
                      child: HeroMachineryTelemetryTag.fromEntity(
                        key: ValueKey('mob_hud_$selectedIndex'),
                        machinery: m,
                        index: selectedIndex,
                        total: fleet.length,
                        isCompact: true,
                      ),
                    ),
                  ),

                  // Nav arrows
                  Positioned(
                    left: 0,
                    child: FleetCircleArrow(
                      icon: Icons.chevron_left,
                      onTap: () {
                        final newIdx =
                            (selectedIndex - 1 + fleet.length) % fleet.length;
                        _onSelectFleet(newIdx, selectedIndex, direction: -1);
                      },
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: FleetCircleArrow(
                      icon: Icons.chevron_right,
                      onTap: () {
                        final newIdx = (selectedIndex + 1) % fleet.length;
                        _onSelectFleet(newIdx, selectedIndex, direction: 1);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 3 Badges horizontally or vertically
            const FleetFeatureItem(
              icon: Icons.settings_outlined,
              title: 'High Performance',
              subtitle: 'Maximum productivity in every condition.',
            ),
            const SizedBox(height: 14),
            const FleetFeatureItem(
              icon: Icons.shield_outlined,
              title: 'Safety First',
              subtitle: 'Built with advanced safety features.',
            ),
            const SizedBox(height: 14),
            const FleetFeatureItem(
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
                children: List.generate(fleet.length, (i) {
                  final item = fleet[i];
                  final bool isSelected = i == selectedIndex;
                  return GestureDetector(
                    onTap: () => _onSelectFleet(i, selectedIndex),
                    child: AnimatedScale(
                      scale: isSelected ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 100,
                        height: 68,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.black.withValues(alpha: 0.55)
                              : Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFE5A93B)
                                : Colors.white.withValues(alpha: 0.08),
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFFE5A93B,
                                    ).withValues(alpha: 0.30),
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                item.thumb,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item.label,
                              style: GoogleFonts.spaceGrotesk(
                                color: isSelected
                                    ? const Color(0xFFE5A93B)
                                    : const Color(0xFFCBD5E1),
                                fontSize: 9.5,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
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
}
