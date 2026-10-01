import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/core/widgets/scroll_video_hero.dart';
import '../hero/hero_overlay.dart';
import '../theme/luxury_hotel_assets.dart';
import '../theme/luxury_hotel_colors.dart';
import '../theme/luxury_hotel_dimensions.dart';

class HotelVideoHeroSection extends StatelessWidget {
  final ScrollController scrollController;
  final ScrollVideoHeroController videoHeroController;
  final bool isDesktop;
  final VoidCallback onScrollToNextSection;
  final VoidCallback onExploreSuites;

  const HotelVideoHeroSection({
    super.key,
    required this.scrollController,
    required this.videoHeroController,
    required this.isDesktop,
    required this.onScrollToNextSection,
    required this.onExploreSuites,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollVideoHero(
      videoAsset: LuxuryHotelAssets.hotelIntroVideo,
      scrollController: scrollController,
      scrollDistance: LuxuryHotelDimensions.videoScrollDistance,
      controller: videoHeroController,
      backgroundColor: kObsidian,
      placeholder: Container(
        color: kObsidian,
        child: const Center(
          child: CircularProgressIndicator(color: kGold, strokeWidth: 2),
        ),
      ),
      underlayBuilder: (context, progress) {
        return Stack(
          fit: StackFit.expand,
          children: [
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
          ],
        );
      },
      overlayBuilder: (context, progress, isReady) {
        return Stack(
          fit: StackFit.expand,
          children: [
            // Progressive Staged Overlays (Change as user scrubs)
            HeroOverlay(
              progress: progress,
              isDesktop: isDesktop,
              onExploreSuites: onExploreSuites,
            ),

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
                          onTap: onScrollToNextSection,
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: kGold.withValues(alpha: 0.35),
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
                        ValueListenableBuilder<bool>(
                          valueListenable: videoHeroController.isAutoTourRunning,
                          builder: (context, isAutoTourRunning, _) {
                            return InkWell(
                              onTap: videoHeroController.toggleAutoTour,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isAutoTourRunning
                                      ? kGold
                                      : Colors.black.withValues(
                                          alpha: 0.55,
                                        ),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: kGold.withValues(alpha: 0.6),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isAutoTourRunning
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      color: isAutoTourRunning
                                          ? kObsidian
                                          : kGold,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      isAutoTourRunning
                                          ? 'PAUSE TOUR'
                                          : 'AUTOPLAY FULL EXPERIENCE',
                                      style: GoogleFonts.spaceMono(
                                        color: isAutoTourRunning
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
