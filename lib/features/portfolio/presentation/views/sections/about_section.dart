import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/widgets/fade_in_slide.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Modern Cyber-Aesthetic "ABOUT ME" Section
/// Pixel-perfect 1:1 reproduction of the architectural design reference.
/// ─────────────────────────────────────────────────────────────────────────────
class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  // Theme Color Palette directly sampled from reference design
  static const Color kBackground = Color(0xFF060911);
  static const Color kCardSurface = Color(0xFF090E17);
  static const Color kCardSurfaceLight = Color(0xFF0C1320);
  static const Color kBorder = Color(0xFF162235);
  static const Color kBorderHover = Color(0xFF00D2FF);
  static const Color kCyan = Color(0xFF00D2FF);
  static const Color kCyanGlow = Color(0xFF38BDF8);
  static const Color kTextWhite = Color(0xFFFFFFFF);
  static const Color kTextMuted = Color(0xFF94A3B8);
  static const Color kTextSub = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1150;
    final isTablet = size.width >= 720 && size.width < 1150;

    final horizontalPadding = isDesktop
        ? size.width * 0.075
        : (isTablet ? 36.0 : 20.0);

    return Container(
      color: kBackground,
      width: double.infinity,
      child: Stack(
        children: [
          // Ambient Neon Cyan Radial Lighting Backdrops
          Positioned(
            top: 40,
            right: size.width * 0.1,
            child: IgnorePointer(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [kCyan.withValues(alpha: 0.08), Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: size.width * 0.05,
            child: IgnorePointer(
              child: Container(
                width: 450,
                height: 450,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF0284C7).withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isDesktop ? 100.0 : 60.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── 1. Top Section: Headline + Workspace Visual Showcase ──
                FadeInSlide(
                  direction: 20.0,
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 11,
                              child: _buildTopHeaderLeft(isDesktop),
                            ),
                            const SizedBox(width: 48),
                            Expanded(
                              flex: 13,
                              child: _buildTopHeaderRight(isDesktop),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTopHeaderLeft(isDesktop),
                            const SizedBox(height: 36),
                            _buildTopHeaderRight(isDesktop),
                          ],
                        ),
                ),

                SizedBox(height: isDesktop ? 64 : 48),

                // ── 2. Bottom Section: The Builder Card + System Capabilities ──
                FadeInSlide(
                  delay: const Duration(milliseconds: 150),
                  direction: 20.0,
                  child: isDesktop
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 13,
                              child: _buildTheBuilderCard(isDesktop, isTablet),
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              flex: 9,
                              child: _buildSystemCapabilitiesColumn(),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTheBuilderCard(isDesktop, isTablet),
                            const SizedBox(height: 48),
                            _buildSystemCapabilitiesColumn(),
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

  // ════════════════════════════════════════════════════════════════════════════
  // 1. TOP HEADER - LEFT CONTENT
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTopHeaderLeft(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pill / Section Identifier
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 2.5,
              decoration: BoxDecoration(
                color: kCyan,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(color: kCyan.withValues(alpha: 0.6), blurRadius: 6),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'ABOUT ME',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: kCyan,
                letterSpacing: 2.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Headline Line 1
        Text(
          'NOT JUST WRITING CODE.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: isDesktop ? 38 : 27,
            fontWeight: FontWeight.w900,
            color: kTextWhite,
            letterSpacing: -0.5,
            height: 1.12,
          ),
        ),
        const SizedBox(height: 4),

        // Headline Line 2 (Vibrant Cyan-Blue Gradient)
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00D2FF), Color(0xFF38BDF8), Color(0xFF60A5FA)],
            stops: [0.0, 0.6, 1.0],
          ).createShader(bounds),
          child: Text(
            'ARCHITECTING DIGITAL REALITIES.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: isDesktop ? 38 : 27,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 1.12,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle Paragraph
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'I build scalable, secure, and high-performance digital ecosystems where design meets logic and technology creates impact.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: isDesktop ? 15.5 : 14.5,
              color: kTextMuted,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════════════════════
  // 1. TOP HEADER - RIGHT WORKSPACE SHOWCASE (Laptop, Floating Code & Chips)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTopHeaderRight(bool isDesktop) {
    return Container(
      height: isDesktop ? 290 : 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kBorder.withValues(alpha: 0.6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Laptop Desk Workspace Photography
            Image.asset('assets/about_hero_laptop.jpg', fit: BoxFit.cover),

            // Left & Bottom Ambient Vignette to blend into section
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    kBackground.withValues(alpha: 0.88),
                    kBackground.withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.35, 1.0],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    kBackground.withValues(alpha: 0.80),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),

            // Floating Holographic Code Snippet
            Positioned(
              top: isDesktop ? 24 : 16,
              left: isDesktop ? 24 : 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xCC070C15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: kCyan.withValues(alpha: 0.35),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: kCyan.withValues(alpha: 0.15),
                          blurRadius: 18,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.firaCode(
                          fontSize: isDesktop ? 11 : 9.5,
                          height: 1.45,
                        ),
                        children: const [
                          TextSpan(
                            text: 'const build = \n',
                            style: TextStyle(
                              color: Color(0xFF38BDF8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '  ({ideas, code, impact}) =>\n',
                            style: TextStyle(color: Color(0xFFF1F5F9)),
                          ),
                          TextSpan(
                            text: '  ({\n',
                            style: TextStyle(color: Color(0xFF94A3B8)),
                          ),
                          TextSpan(
                            text: '    frontend: ',
                            style: TextStyle(color: Color(0xFF7DD3FC)),
                          ),
                          TextSpan(
                            text: 'beautiful,\n',
                            style: TextStyle(
                              color: Color(0xFF34D399),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '    backend: ',
                            style: TextStyle(color: Color(0xFF7DD3FC)),
                          ),
                          TextSpan(
                            text: 'reliable,\n',
                            style: TextStyle(
                              color: Color(0xFF34D399),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '    deployment: ',
                            style: TextStyle(color: Color(0xFF7DD3FC)),
                          ),
                          TextSpan(
                            text: 'seamless,\n',
                            style: TextStyle(
                              color: Color(0xFF34D399),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '  });',
                            style: TextStyle(color: Color(0xFF94A3B8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Floating Tech Stack Pills (React, Node.js, PostgreSQL, Docker, AWS)
            const Positioned(
              top: 18,
              right: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _TechStackPill(
                    icon: Icons.all_inclusive_rounded,
                    label: 'Flutter',
                  ),
                  SizedBox(height: 7),
                  _TechStackPill(
                    icon: Icons.hexagon_outlined,
                    label: 'Firebase',
                  ),
                  SizedBox(height: 7),
                  _TechStackPill(icon: Icons.dns_rounded, label: 'Supabase'),
                  SizedBox(height: 7),
                  _TechStackPill(icon: Icons.all_inbox_rounded, label: 'Git'),
                  SizedBox(height: 7),
                  _TechStackPill(
                    icon: Icons.cloud_queue_rounded,
                    label: 'RestAPIs',
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
  // 2. THE BUILDER CARD (Left Large Card with Portrait Photo, Bio & Metrics)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildTheBuilderCard(bool isDesktop, bool isTablet) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Only use row layout if there is sufficient width (>= 600px) so content has ample room
        final isRowLayout = constraints.maxWidth >= 600;
        final cardPadding = isDesktop ? 24.0 : 18.0;
        final photoWidth = constraints.maxWidth >= 720 ? 270.0 : 220.0;
        const gap = 24.0;

        return Container(
          decoration: BoxDecoration(
            color: kCardSurface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: kBorder, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          padding: EdgeInsets.all(cardPadding),
          child: isRowLayout
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left: Vertical Developer Setup Photo (enforces healthy minHeight so card never squishes content)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: photoWidth,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 440),
                            child: Image.asset(
                              'assets/about_builder_desk.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: gap),

                      // Right: Bio Narrative & Raw Metrics
                      Expanded(
                        child: _buildTheBuilderBioContent(isRowLayout: true),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Image.asset(
                          'assets/about_builder_desk.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTheBuilderBioContent(isRowLayout: false),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildTheBuilderBioContent({bool isRowLayout = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isRowLayout
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cyan Overline
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 2,
                  decoration: BoxDecoration(
                    color: kCyan,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: kCyan.withValues(alpha: 0.6),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'THE BUILDER',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: kCyan,
                      letterSpacing: 2.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Paragraph 1
            Text(
              'Joel P Shaju bridges the gap between abstract design aesthetics and rigorous engineering logic to architect high-performance digital ecosystems.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.0,
                color: const Color(0xFFCBD5E1),
                height: 1.58,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 14),

            // Paragraph 2
            Text(
              'With a track record of delivering enterprise-grade solutions—including systems for Kahramaa and Khadoom—I specialize in clean architectural paradigms, secure state workflows, and modular repositories.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.0,
                color: kTextMuted,
                height: 1.58,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 14),

            // Paragraph 3
            Text(
              'Every component I build is engineered to enforce a strict separation of concerns, optimize performance metrics, and deliver delightful, interactive user experiences.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.0,
                color: kTextMuted,
                height: 1.58,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Metrics Footer (3+ YEARS EXPERIENCE | 8+ COMPLETED PROJECTS | 100% DEDICATION)
        Container(
          padding: const EdgeInsets.only(top: 16),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF141F30), width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildMetricColumn('3+', 'YEARS EXPERIENCE')),
              _buildVerticalDivider(),
              Expanded(child: _buildMetricColumn('8+', 'COMPLETED PROJECTS')),
              _buildVerticalDivider(),
              Expanded(child: _buildMetricColumn('100%', 'DEDICATION')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricColumn(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: kTextWhite,
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: kTextSub,
                letterSpacing: 1.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 36, width: 1, color: const Color(0xFF162335));
  }

  // ════════════════════════════════════════════════════════════════════════════
  // 3. SYSTEM CAPABILITIES COLUMN (4 Interactive Stacked Feature Cards)
  // ════════════════════════════════════════════════════════════════════════════
  Widget _buildSystemCapabilitiesColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cyan Overline
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 2,
              decoration: BoxDecoration(
                color: kCyan,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(color: kCyan.withValues(alpha: 0.6), blurRadius: 4),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'SYSTEM CAPABILITIES',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: kCyan,
                  letterSpacing: 2.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // 1. Clean Architecture
        _CapabilityCard(
          iconWidget: Text(
            '</>',
            style: GoogleFonts.firaCode(
              color: kCyan,
              fontWeight: FontWeight.w900,
              fontSize: 17,
            ),
          ),
          title: 'CLEAN ARCHITECTURE',
          description:
              'Domain, Data, Presentation layers for testable repositories.',
        ),
        const SizedBox(height: 14),

        // 2. Security & Auth
        _CapabilityCard(
          iconWidget: const Icon(Icons.shield_outlined, color: kCyan, size: 20),
          title: 'SECURITY & AUTH',
          description:
              'Token cycles, biometric login, Entra ID, encrypted storage.',
        ),
        const SizedBox(height: 14),

        // 3. State Orchestration
        _CapabilityCard(
          iconWidget: const Icon(
            Icons.device_hub_rounded,
            color: kCyan,
            size: 20,
          ),
          title: 'STATE ORCHESTRATION',
          description:
              'Reactive UI workflows via Riverpod, BLoC, and GetIt DI.',
        ),
        const SizedBox(height: 14),

        // 4. AI-Assisted Velocity
        _CapabilityCard(
          iconWidget: const Icon(Icons.bolt_rounded, color: kCyan, size: 22),
          title: 'AI-ASSISTED VELOCITY',
          description:
              'Pairing with Claude & Copilot to optimize velocity and quality.',
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Interactive Capability Card Component
// ─────────────────────────────────────────────────────────────────────────────
class _CapabilityCard extends StatefulWidget {
  final Widget iconWidget;
  final String title;
  final String description;

  const _CapabilityCard({
    required this.iconWidget,
    required this.title,
    required this.description,
  });

  @override
  State<_CapabilityCard> createState() => _CapabilityCardState();
}

class _CapabilityCardState extends State<_CapabilityCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF0D1424)
              : _AboutSectionState.kCardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? _AboutSectionState.kCyan.withValues(alpha: 0.5)
                : _AboutSectionState.kBorder,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? _AboutSectionState.kCyan.withValues(alpha: 0.12)
                  : Colors.black.withValues(alpha: 0.25),
              blurRadius: _isHovered ? 20 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Dark Navy Square Icon Capsule
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF0F1829),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isHovered
                      ? _AboutSectionState.kCyan.withValues(alpha: 0.4)
                      : const Color(0xFF1B283E),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? _AboutSectionState.kCyan.withValues(alpha: 0.25)
                        : Colors.transparent,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(child: widget.iconWidget),
            ),
            const SizedBox(width: 16),

            // Title & Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: _AboutSectionState.kTextWhite,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: _AboutSectionState.kTextMuted,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Trailing Circle Arrow Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isHovered
                    ? _AboutSectionState.kCyan
                    : const Color(0xFF111827),
                border: Border.all(
                  color: _isHovered
                      ? _AboutSectionState.kCyan
                      : const Color(0xFF1E293B),
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: _AboutSectionState.kCyan.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 10,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  Icons.mouse,
                  size: 15,
                  color: _isHovered
                      ? _AboutSectionState.kBackground
                      : _AboutSectionState.kTextMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tech Stack Pill Component (React, Node.js, PostgreSQL, Docker, AWS)
// ─────────────────────────────────────────────────────────────────────────────
class _TechStackPill extends StatefulWidget {
  final IconData icon;
  final String label;

  const _TechStackPill({required this.icon, required this.label});

  @override
  State<_TechStackPill> createState() => _TechStackPillState();
}

class _TechStackPillState extends State<_TechStackPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7.5),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xF20F1C30) : const Color(0xD909101C),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isHovered
                ? _AboutSectionState.kCyan.withValues(alpha: 0.6)
                : const Color(0xFF1C2A40),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? _AboutSectionState.kCyan.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.35),
              blurRadius: _isHovered ? 12 : 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 14, color: _AboutSectionState.kCyan),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _isHovered ? Colors.white : const Color(0xFFE2E8F0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
