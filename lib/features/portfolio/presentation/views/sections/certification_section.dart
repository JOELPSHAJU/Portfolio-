import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';
import 'package:clean_riverpod_template/core/widgets/hover_animated_text.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Certifications & Credentials Section ────────────────────────────────────

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 768 && size.width < 1024;
    final sidePadding = isDesktop
        ? size.width * 0.08
        : (isTablet ? 40.0 : 24.0);
    final pal = context.palette;

    final certifications = [
      _CertItem(
        title: 'Microsoft Learn Student Ambassador',
        issuer: 'Microsoft',
        category: 'COMMUNITY & LEADERSHIP',
        icon: Icons.verified_user_rounded,
        description:
            'Conducted technical workshops, spoke on cloud integrations, and mentored student developers across the region.',
        accentColor: const Color(0xFF00F5D4), // Cyan
      ),
      _CertItem(
        title: 'Flutter Certified Specialist',
        issuer: 'Advanced Mobile Academy',
        category: 'CERTIFICATION',
        icon: Icons.bookmark_added_rounded,
        description:
            'Verified proficiency in state management, Clean Architecture, and performance optimization.',
        accentColor: const Color(0xFF7B2CBF), // Purple
      ),
      _CertItem(
        title: 'Technical Systems Workshop',
        issuer: 'Appstation Core Team',
        category: 'WORKSHOP',
        icon: Icons.developer_mode_rounded,
        description:
            'Deep dive into Melos monorepos, Microsoft SSO, and multi-tenant authentication patterns.',
        accentColor: const Color(0xFFFF007F), // Pink
      ),
      _CertItem(
        title: 'Cloud & DevOps Webinar Leader',
        issuer: 'Developer Community',
        category: 'PRESENTATION',
        icon: Icons.cloud_done_rounded,
        description:
            'Shared deployment strategies for Flutter web nodes and server backends on AWS infrastructure.',
        accentColor: const Color(0xFFF77F00), // Orange
      ),
    ];

    return Container(
      color: pal.surface,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Kinetic Typography
          Positioned(
            top: 40,
            left: 10,
            child: Text(
              'CRED.SYS',
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
              vertical: 120.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInSlide(
                  delay: const Duration(milliseconds: 100),
                  direction: 25.0,
                  child: _buildEditorialHeader(pal),
                ),
                const SizedBox(height: 80),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = isDesktop ? 2 : 1;
                    final spacing = 24.0;
                    final width =
                        (constraints.maxWidth -
                            (crossAxisCount - 1) * spacing) /
                        crossAxisCount;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: certifications.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final cert = entry.value;
                        return FadeInSlide(
                          delay: Duration(milliseconds: 200 + (idx * 100)),
                          direction: 25.0,
                          child: SizedBox(
                            width: width,
                            child: _CertificationManifestoCard(cert: cert),
                          ),
                        );
                      }).toList(),
                    );
                  },
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
                '04 / CREDENTIAL_SYS',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.warmBrown,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              HoverAnimatedText(
                text: 'WORKSHOPS &\nCERTIFICATIONS.',
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
}

// ─── Certification & Workshop Manifesto Card ──────────────────────────────────

class _CertificationManifestoCard extends StatefulWidget {
  final _CertItem cert;

  const _CertificationManifestoCard({required this.cert});

  @override
  State<_CertificationManifestoCard> createState() =>
      _CertificationManifestoCardState();
}

class _CertificationManifestoCardState
    extends State<_CertificationManifestoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cert = widget.cert;
    final pal = context.palette;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _hovered
              ? pal.card.withValues(alpha: 0.6)
              : pal.card.withValues(alpha: 0.3),
          border: Border(
            left: BorderSide(
              color: _hovered ? cert.accentColor : BrandColors.warmBrown,
              width: 4,
            ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '// CLASS: ${cert.category.toUpperCase()}',
                    style: GoogleFonts.spaceMono(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: pal.textPrimary.withValues(alpha: 0.5),
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Icon(
                  cert.icon,
                  color: _hovered
                      ? cert.accentColor
                      : pal.textPrimary.withValues(alpha: 0.4),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 24),
            HoverAnimatedText(
              text: cert.title.toUpperCase(),
              style: GoogleFonts.anton(
                fontSize: 28,
                height: 1.1,
                color: pal.textPrimary,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              cert.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontSize: 14,
                height: 1.5,
                color: pal.textPrimary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '// CREDENTIAL ISSUER',
              style: GoogleFonts.spaceMono(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: pal.textPrimary.withValues(alpha: 0.4),
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: pal.textPrimary.withValues(alpha: 0.03),
                border: Border.all(
                  color: pal.textPrimary.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.fingerprint_rounded,
                    size: 12,
                    color: cert.accentColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    cert.issuer.toUpperCase(),
                    style: GoogleFonts.spaceMono(
                      color: pal.textPrimary.withValues(alpha: 0.7),
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Certification Data Model ──────────────────────────────────────────────────

class _CertItem {
  final String title;
  final String issuer;
  final String category;
  final IconData icon;
  final String description;
  final Color accentColor;

  const _CertItem({
    required this.title,
    required this.issuer,
    required this.category,
    required this.icon,
    required this.description,
    required this.accentColor,
  });
}
