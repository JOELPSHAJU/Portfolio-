import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/core/widgets/scroll_video_hero.dart';
import '../../painters/atmospheric_dust_painter.dart';
import '../../painters/site_gantry_frame_painter.dart';
import '../../theme/js_construction_theme.dart';
import '../../widgets/hero/hero_timed_overlays.dart';

/// Hero Section with ScrollVideoHero and timed narrative overlays
class JsConstructionHero extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollVideoHeroController videoHeroController;
  final VoidCallback onScrollToNext;
  final VoidCallback onExploreProjects;

  const JsConstructionHero({
    super.key,
    required this.scrollController,
    required this.videoHeroController,
    required this.onScrollToNext,
    required this.onExploreProjects,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 1024;

    return ScrollVideoHero(
      videoAsset: 'assets/construction_introd.mp4',
      reversedVideoAsset: 'assets/construction_introd_reversed.mp4',
      scrollController: scrollController,
      scrollDistance: JsConstructionTheme.kVideoScrollDistance,
      enableSmoothWheel: false,
      controller: videoHeroController,
      backgroundColor: JsConstructionTheme.kObsidian,
      placeholder: Container(
        color: JsConstructionTheme.kObsidian,
        child: const Center(
          child: CircularProgressIndicator(
            color: JsConstructionTheme.kSafetyAmber,
            strokeWidth: 2,
          ),
        ),
      ),
      underlayBuilder: (context, progress) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Atmospheric Dust & Lighting Shader Overlay
            CustomPaint(
              painter: AtmosphericDustPainter(progress: progress),
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
          ],
        );
      },
      overlayBuilder: (context, progress, isReady) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Structural Steel Gantry Perimeter Overlay (Site Entrance Frame)
            if (isDesktop)
              const Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(painter: SiteGantryFramePainter()),
                ),
              ),

            // Staged Narrative Environmental Overlays
            HeroTimedOverlays(
              progress: progress,
              isDesktop: isDesktop,
              onExploreProjectsTap: onExploreProjects,
            ),

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
                          onTap: onScrollToNext,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: JsConstructionTheme.kSiteCharcoal
                                  .withValues(alpha: 0.90),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: JsConstructionTheme.kSafetyAmber,
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: JsConstructionTheme.kSafetyAmber
                                      .withValues(alpha: 0.35),
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
                                  color: JsConstructionTheme.kSafetyAmber,
                                  size: 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'SCROLL TO EXPLORE (START TO FINISH)',
                                  style: GoogleFonts.spaceGrotesk(
                                    color: JsConstructionTheme.kSteel,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: JsConstructionTheme.kSafetyAmber,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: videoHeroController.isAutoTourRunning,
                          builder: (context, isAutoTourRunning, _) {
                            return InkWell(
                              onTap: videoHeroController.toggleAutoTour,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: isAutoTourRunning
                                      ? JsConstructionTheme.kSafetyAmber
                                      : JsConstructionTheme.kSiteCharcoal
                                          .withValues(alpha: 0.90),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: JsConstructionTheme.kSafetyAmber,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: JsConstructionTheme.kSafetyAmber
                                          .withValues(
                                            alpha: isAutoTourRunning
                                                ? 0.5
                                                : 0.2,
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
                                      isAutoTourRunning
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: isAutoTourRunning
                                          ? JsConstructionTheme.kObsidian
                                          : JsConstructionTheme.kSafetyAmber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      isAutoTourRunning
                                          ? 'PAUSE TOUR'
                                          : 'AUTOPLAY FULL TIMELINE',
                                      style: GoogleFonts.spaceGrotesk(
                                        color: isAutoTourRunning
                                            ? JsConstructionTheme.kObsidian
                                            : JsConstructionTheme.kSteel,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
