import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/js_constructions_providers.dart';
import '../../theme/js_construction_theme.dart';
import '../../widgets/projects/prestige_project_card.dart';

/// ZONE 02: STRUCTURAL STEEL DECK & ARCHITECTURAL MASTERWORKS
class JsProjectsSection extends ConsumerWidget {
  final bool isDesktop;
  final bool isTablet;

  const JsProjectsSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prestigeProjectsAsync = ref.watch(prestigeProjectsProvider);

    return Container(
      color: JsConstructionTheme.kObsidian,
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
                    color: JsConstructionTheme.kSafetyAmber,
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
                prestigeProjectsAsync.when(
                  data: (projects) => LayoutBuilder(
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
                        children: projects.map((proj) {
                          return SizedBox(
                            width: cardWidth,
                            child: PrestigeProjectCard(project: proj),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(
                        color: JsConstructionTheme.kSafetyAmber,
                      ),
                    ),
                  ),
                  error: (e, st) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 48),

                // ── "VIEW ALL PROJECTS →" CTA button ──
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: JsConstructionTheme.kSafetyAmber,
                    side: const BorderSide(
                      color: JsConstructionTheme.kSafetyAmber,
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 18,
                    ),
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
                      color: JsConstructionTheme.kSafetyAmber,
                    ),
                  ),
                  label: const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: JsConstructionTheme.kSafetyAmber,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
