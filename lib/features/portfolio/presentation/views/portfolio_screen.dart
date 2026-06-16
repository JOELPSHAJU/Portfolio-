import 'package:clean_riverpod_template/features/portfolio/presentation/views/sections/certification_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/portfolio_controller.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'widgets/glow_background.dart';
import 'widgets/mobile_drawer.dart';
import 'widgets/navigation_bar.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  // Keys for scrolling targeting
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'experience': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  bool _isScrollingProgrammatically = false;

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key != null && key.currentContext != null) {
      setState(() {
        _isScrollingProgrammatically = true;
      });

      // Update navbar state immediately
      ref
          .read(portfolioControllerProvider.notifier)
          .updateActiveSection(sectionId);

      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        // Delay resetting scrolling lock to prevent minor bouncing glitches
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) {
            setState(() {
              _isScrollingProgrammatically = false;
            });
          }
        });
      });
    }
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (_isScrollingProgrammatically) return false;

    if (notification is ScrollUpdateNotification) {
      double minDiff = double.infinity;
      String currentActive = 'home';
      // Measure screen midpoint distance
      final screenHeight = MediaQuery.of(context).size.height;
      final targetLine =
          screenHeight *
          0.3; // Check y coordinate relative to upper 30% of screen

      for (var entry in _sectionKeys.entries) {
        final context = entry.value.currentContext;
        if (context != null) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null) {
            final position = box.localToGlobal(Offset.zero);
            final double y = position.dy;

            // Calculate distance to target line
            final double diff = (y - targetLine).abs();
            if (diff < minDiff) {
              minDiff = diff;
              currentActive = entry.key;
            }
          }
        }
      }

      final controller = ref.read(portfolioControllerProvider.notifier);
      final stateVal = ref.read(portfolioControllerProvider).value;
      if (stateVal != null && stateVal.activeSection != currentActive) {
        controller.updateActiveSection(currentActive);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final portfolioStateAsync = ref.watch(portfolioControllerProvider);

    return GlowBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // No appBar — nav bar floats over the body via Stack overlay
        extendBodyBehindAppBar: true,
        endDrawer: portfolioStateAsync.when(
          data: (state) => MobileDrawer(
            activeSection: state.activeSection,
            onSectionSelected: _scrollToSection,
          ),
          loading: () => null,
          error: (_, __) => null,
        ),
        body: portfolioStateAsync.when(
          data: (state) {
            return Stack(
              children: [
                // ── Scrollable content — full viewport ──
                NotificationListener<ScrollNotification>(
                  onNotification: _onScrollNotification,
                  child: ScrollConfiguration(
                    // Remove the default overscroll glow/stretch on web
                    behavior: const _NoOverscrollBehavior(),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      // ClampingScrollPhysics is correct for web —
                      // BouncingScrollPhysics adds rubber-band latency that
                      // makes every scroll feel sluggish.
                      physics: const ClampingScrollPhysics(),
                      child: RepaintBoundary(
                        child: Column(
                          children: [
                            // Home Section
                            Container(
                              key: _sectionKeys['home'],
                              child: FadeInSlide(
                                direction: -35,
                                child: HeroSection(
                                  onExploreWorkPressed: () =>
                                      _scrollToSection('projects'),
                                  onContactPressed: () => _scrollToSection('contact'),
                                ),
                              ),
                            ),

                            // About Section
                            Container(
                              key: _sectionKeys['about'],
                              child: const FadeInSlide(
                                delay: Duration(milliseconds: 80),
                                direction: 35,
                                child: AboutSection(),
                              ),
                            ),

                            // Experience Section
                            Container(
                              key: _sectionKeys['experience'],
                              child: FadeInSlide(
                                delay: const Duration(milliseconds: 100),
                                direction: -35,
                                child: ExperienceSection(
                                  experiences: state.experiences,
                                ),
                              ),
                            ),

                            // Skills Section
                            Container(
                              key: _sectionKeys['skills'],
                              child: FadeInSlide(
                                delay: const Duration(milliseconds: 100),
                                direction: 35,
                                child: SkillsSection(skills: state.skills),
                              ),
                            ),

                            // Certification Section
                            const FadeInSlide(
                              delay: Duration(milliseconds: 100),
                              direction: -35,
                              child: CertificationsSection(),
                            ),

                            // Projects Section
                            Container(
                              key: _sectionKeys['projects'],
                              child: FadeInSlide(
                                delay: const Duration(milliseconds: 100),
                                direction: 35,
                                child: ProjectsSection(projects: state.projects),
                              ),
                            ),

                            // Contact Section
                            Container(
                              key: _sectionKeys['contact'],
                              child: const FadeInSlide(
                                delay: Duration(milliseconds: 100),
                                direction: -35,
                                child: ContactSection(),
                              ),
                            ),

                            // Footer
                            FadeInSlide(
                              delay: const Duration(milliseconds: 100),
                              child: _buildFooter(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Floating nav bar — always on top, no background ──
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: PortfolioHeader(
                    activeSection: state.activeSection,
                    onSectionSelected: _scrollToSection,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: BrandColors.primaryNeon),
          ),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: BrandColors.accentNeon,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading data: $err',
                  style: TextStyle(color: context.palette.textPrimary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Light: pure white bg, near-black title, mid-grey text
    // Dark: dark grey (not black) bg, silver title, dim grey text
    final bgColor    = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final titleColor = isDark ? const Color(0xFFD1D1D6) : BrandColors.textPrimary;
    final subColor   = isDark ? const Color(0xFF8E8E93) : BrandColors.warmAccent;
    final muteColor  = isDark ? const Color(0xFF636366) : BrandColors.textMuted;
    final logoText   = isDark ? BrandColors.darkBackground : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
      color: bgColor,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: BrandColors.primaryGradient,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'JS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: logoText,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'JOEL P SHAJU',
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Designed & Engineered in Flutter with Riverpod Clean Architecture.',
            textAlign: TextAlign.center,
            style: TextStyle(color: subColor, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            '\u00a9 ${DateTime.now().year} Joel P Shaju. All Rights Reserved.',
            style: TextStyle(color: muteColor, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

/// Removes the default overscroll glow and stretch on Flutter web.
/// BouncingScrollPhysics + the default indicator both add perceived latency.
class _NoOverscrollBehavior extends ScrollBehavior {
  const _NoOverscrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) =>
      child; // no glow, no stretch

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
