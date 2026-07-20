import 'package:flutter/material.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/theme/brand_colors.dart';
import 'package:joel_portfolio/core/widgets/fade_in_slide.dart';
import 'package:joel_portfolio/core/widgets/hover_animated_text.dart';
import 'package:joel_portfolio/core/widgets/adaptive_logo.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Cyber-Brutalist About Section ──────────────────────────────────────────────
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;
    final sidePadding = isDesktop
        ? size.width * 0.08
        : (isTablet ? 40.0 : 24.0);
    final pal = context.palette;

    return Container(
      color: pal.surface,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Matrix / Kinetic Typography
          Positioned(
            top: 40,
            left: 10,
            child: Text(
              'JOEL.P.SHAJU',
              style: GoogleFonts.anton(
                fontSize: isDesktop ? 220 : 120,
                color: pal.textPrimary.withValues(alpha: 0.02),
                letterSpacing: -4,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sidePadding,
              vertical: 140.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInSlide(direction: 15.0, child: _buildEditorialHeader(pal)),
                const SizedBox(height: 80),
                isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: FadeInSlide(
                              delay: const Duration(milliseconds: 100),
                              direction: 15.0,
                              child: _buildManifesto(pal),
                            ),
                          ),
                          const SizedBox(width: 80),
                          Expanded(
                            flex: 4,
                            child: FadeInSlide(
                              delay: const Duration(milliseconds: 200),
                              direction: 15.0,
                              child: _buildSystemCapabilities(pal),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInSlide(
                            delay: const Duration(milliseconds: 100),
                            direction: 15.0,
                            child: _buildManifesto(pal),
                          ),
                          const SizedBox(height: 80),
                          FadeInSlide(
                            delay: const Duration(milliseconds: 200),
                            direction: 15.0,
                            child: _buildSystemCapabilities(pal),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialHeader(AppPalette pal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 2,
          color: BrandColors.warmBrown,
          margin: const EdgeInsets.only(top: 10),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '01 / ABOUT_SYS',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.warmBrown,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              HoverAnimatedText(
                text: 'NOT JUST WRITING CODE.\nARCHITECTING DIGITAL REALITIES.',
                style: GoogleFonts.anton(
                  fontSize: 48,
                  height: 1.1,
                  color: pal.textPrimary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildManifesto(AppPalette pal) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: pal.card.withValues(alpha: 0.3),
        border: Border(
          left: const BorderSide(color: BrandColors.warmBrown, width: 4),
          top: BorderSide(
            color: pal.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
          right: BorderSide(
            color: pal.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
          bottom: BorderSide(
            color: pal.textPrimary.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// THE MANIFESTO',
            style: GoogleFonts.spaceMono(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: pal.textPrimary.withValues(alpha: 0.4),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Joel P Shaju bridges the gap between abstract design aesthetics and rigorous engineering logic to architect high-performance digital ecosystems.\n\nWith a track record of delivering enterprise-grade solutions—including systems for Kahramaa and Khadoom—I specialize in clean architectural paradigms, secure state workflows, and modular repositories.\n\nEvery component I build is engineered to enforce a strict separation of concerns, optimize performance metrics, and deliver delightful, interactive user experiences.',
            style: GoogleFonts.outfit(
              fontSize: 16,
              height: 1.8,
              color: pal.textPrimary.withValues(alpha: 0.75),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 32),
          // Signature Logo
          const Align(
            alignment: Alignment.centerRight,
            child: AdaptiveLogo(height: 120, floatingInDarkMode: true),
          ),
          const SizedBox(height: 32),
          // Raw Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRawMetric('EXP_YRS', '02+', pal),
              _buildRawMetric('DEPLOYED', '8+', pal),
              _buildRawMetric('CLIENT_SAT', '100', pal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRawMetric(String label, String value, AppPalette pal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.anton(
            fontSize: 36,
            color: pal.textPrimary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.spaceMono(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: BrandColors.warmBrown,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSystemCapabilities(AppPalette pal) {
    final caps = [
      {
        'title': 'CLEAN ARCHITECTURE',
        'desc': 'Domain, Data, Presentation layers for testable repositories.',
      },
      {
        'title': 'SECURITY & AUTH',
        'desc': 'Token cycles, biometric login, Entra ID, encrypted storage.',
      },
      {
        'title': 'STATE ORCHESTRATION',
        'desc': 'Reactive UI workflows via Riverpod, BLoC, and GetIt DI.',
      },
      {
        'title': 'AI-ASSISTED VELOCITY',
        'desc':
            'Pairing with Claude & Copilot to optimize velocity and quality.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// SYSTEM_CAPABILITIES',
          style: GoogleFonts.spaceMono(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: pal.textPrimary.withValues(alpha: 0.4),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 32),
        ...caps.map((c) => _buildCapNode(c['title']!, c['desc']!, pal)),
      ],
    );
  }

  Widget _buildCapNode(String title, String desc, AppPalette pal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: pal.textPrimary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: pal.textPrimary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: GoogleFonts.outfit(
              fontSize: 14,
              height: 1.5,
              color: pal.textPrimary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStrip(AppPalette pal, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: pal.textPrimary,
        border: Border.all(color: pal.textPrimary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '// EXECUTION_TIMELINE',
            style: GoogleFonts.spaceMono(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: pal.surface.withValues(alpha: 0.5),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 48),
          isDesktop
              ? Row(
                  children: [
                    Expanded(
                      child: _buildTimeNode(
                        '2023 - PRESENT',
                        'Flutter Architect',
                        'Digital Experience Engineering',
                        pal,
                        isDarkBg: true,
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      child: _buildTimeNode(
                        '2020 - 2023',
                        'Computer Engineering',
                        'Govt. Polytechnic College',
                        pal,
                        isDarkBg: true,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildTimeNode(
                      '2023 - PRESENT',
                      'Flutter Architect',
                      'Digital Experience Engineering',
                      pal,
                      isDarkBg: true,
                    ),
                    const SizedBox(height: 48),
                    _buildTimeNode(
                      '2020 - 2023',
                      'Computer Engineering',
                      'Govt. Polytechnic College',
                      pal,
                      isDarkBg: true,
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildTimeNode(
    String year,
    String title,
    String subtitle,
    AppPalette pal, {
    required bool isDarkBg,
  }) {
    final fg = isDarkBg ? pal.surface : pal.textPrimary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          color: BrandColors.warmBrown,
          child: Text(
            year,
            style: GoogleFonts.spaceMono(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        HoverAnimatedText(
          text: title,
          style: GoogleFonts.anton(fontSize: 28, color: fg, letterSpacing: 1),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: fg.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
