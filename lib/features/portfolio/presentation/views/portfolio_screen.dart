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
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        // Home Section
                        Container(
                          key: _sectionKeys['home'],
                          child: HeroSection(
                            onExploreWorkPressed: () =>
                                _scrollToSection('projects'),
                            onContactPressed: () => _scrollToSection('contact'),
                          ),
                        ),

                        // About Section
                        Container(
                          key: _sectionKeys['about'],
                          child: const AboutSection(),
                        ),

                        // Experience Section
                        Container(
                          key: _sectionKeys['experience'],
                          child: ExperienceSection(experiences: state.experiences),
                        ),

                        // Skills Section
                        Container(
                          key: _sectionKeys['skills'],
                          child: SkillsSection(skills: state.skills),
                        ),

                        // Certification Section
                        const CertificationsSection(),

                        // Projects Section
                        Container(
                          key: _sectionKeys['projects'],
                          child: ProjectsSection(projects: state.projects),
                        ),

                        // Contact Section
                        Container(
                          key: _sectionKeys['contact'],
                          child: const ContactSection(),
                        ),

                        // Footer
                        _buildFooter(),
                      ],
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
                  style: const TextStyle(color: Color(0xFF141010)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
      color: const Color(0xFF1C1008),
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
                child: const Text(
                  'JS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: const Color(0xFF141010),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'JOEL P SHAJU',
                style: TextStyle(
                  color: const Color(0xFF141010),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Designed & Engineered in Flutter with Riverpod Clean Architecture.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF8C5E28), fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(
            '© ${DateTime.now().year} Joel P Shaju. All Rights Reserved.',
            style: TextStyle(
              color: const Color(0xFF1C1008).withOpacity(0.3),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
