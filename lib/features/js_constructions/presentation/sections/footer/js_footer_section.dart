import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../painters/footer_bottom_hazard_painter.dart';
import '../../painters/footer_top_border_painter.dart';
import '../../painters/js_logo_painter.dart';
import '../../widgets/footer/footer_nav_link.dart';
import '../../widgets/footer/footer_social_button.dart';

/// ZONE 06: SITE EGRESS & SAFETY COMPLIANCE AUDIT FOOTER
class JsFooterSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onHomeTap;
  final VoidCallback onAboutUsTap;
  final VoidCallback onServicesTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  const JsFooterSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onHomeTap,
    required this.onAboutUsTap,
    required this.onServicesTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── 1. Panoramic Sunset Construction Horizon Banner ──
        SizedBox(
          height: isDesktop ? 260 : (isTablet ? 200 : 150),
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/construction_footer_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              // Subtle darkening scrim at bottom to meet the technical border cleanly
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.40),
                    ],
                    stops: const [0.70, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── 2. Technical Top Border Line ──
        const CustomPaint(
          size: Size(double.infinity, 16),
          painter: FooterTopBorderPainter(),
        ),

        // ── 3. Dark Industrial HUD Footer Panel ──
        Container(
          color: const Color(0xFF07090E),
          padding: EdgeInsets.fromLTRB(
            isDesktop ? 60 : (isTablet ? 30 : 20),
            32,
            isDesktop ? 60 : (isTablet ? 30 : 20),
            24,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 1024;
              final isMedium =
                  constraints.maxWidth >= 640 && constraints.maxWidth < 1024;

              return Column(
                children: [
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Column 1: Brand & Logo
                        Expanded(flex: 32, child: _buildFooterBrandCol()),
                        const SizedBox(width: 36),
                        // Column 2: Quick Links
                        Expanded(flex: 18, child: _buildFooterQuickLinksCol()),
                        const SizedBox(width: 28),
                        // Column 3: Our Services
                        Expanded(flex: 22, child: _buildFooterServicesCol()),
                        const SizedBox(width: 28),
                        // Column 4: Contact Us
                        Expanded(flex: 26, child: _buildFooterContactCol()),
                        const SizedBox(width: 28),
                        // Column 5: Follow Us
                        Expanded(flex: 20, child: _buildFooterFollowCol()),
                      ],
                    )
                  else if (isMedium)
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildFooterBrandCol()),
                            const SizedBox(width: 32),
                            Expanded(child: _buildFooterQuickLinksCol()),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildFooterServicesCol()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildFooterContactCol()),
                            const SizedBox(width: 24),
                            Expanded(child: _buildFooterFollowCol()),
                          ],
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFooterBrandCol(),
                        const SizedBox(height: 28),
                        _buildFooterQuickLinksCol(),
                        const SizedBox(height: 28),
                        _buildFooterServicesCol(),
                        const SizedBox(height: 28),
                        _buildFooterContactCol(),
                        const SizedBox(height: 28),
                        _buildFooterFollowCol(),
                      ],
                    ),

                  const SizedBox(height: 32),

                  // Divider
                  Container(height: 1, color: const Color(0xFF1E2636)),
                  const SizedBox(height: 16),

                  // Bottom Copyright Row + Hazard Accent
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '© 2025 JS Constructions. All rights reserved.',
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF64748B),
                          fontSize: 11,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                        height: 10,
                        child: CustomPaint(
                          painter: FooterBottomHazardPainter(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFooterBrandCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 36,
              height: 32,
              child: CustomPaint(painter: JsLogoPainter()),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JS',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.2,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'CONSTRUCTIONS',
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFF94A3B8),
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Building tomorrow, today. Delivering excellence in construction, infrastructure and engineering solutions across every terrain.',
          style: GoogleFonts.plusJakartaSans(
            color: const Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 24,
          height: 3.5,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9F1C),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterHeader(String title) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 2.5,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9F1C),
            borderRadius: BorderRadius.circular(1.5),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFFFF9F1C),
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterQuickLinksCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('QUICK LINKS'),
        const SizedBox(height: 16),
        FooterNavLink(label: 'Home', onTap: onHomeTap),
        const SizedBox(height: 9),
        FooterNavLink(label: 'About Us', onTap: onAboutUsTap),
        const SizedBox(height: 9),
        FooterNavLink(label: 'Services', onTap: onServicesTap),
        const SizedBox(height: 9),
        FooterNavLink(label: 'Projects', onTap: onProjectsTap),
        const SizedBox(height: 9),
        FooterNavLink(label: 'Contact Us', onTap: onContactTap),
      ],
    );
  }

  Widget _buildFooterServicesCol() {
    final services = [
      'Earthmoving & Site Preparation',
      'Civil & Structural Works',
      'Infrastructure Development',
      'Equipment Rental',
      'Project Management',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('OUR SERVICES'),
        const SizedBox(height: 16),
        for (int i = 0; i < services.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          Text(
            services[i],
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFooterContactCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('CONTACT US'),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Color(0xFFFF9F1C),
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '123 Construction Avenue,\nIndustrial Area, Kochi, India – 682017',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontSize: 12,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.call_outlined, color: Color(0xFFFF9F1C), size: 16),
            const SizedBox(width: 10),
            Text(
              '+91 98765 43210',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFCBD5E1),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(
              Icons.mail_outline_rounded,
              color: Color(0xFFFF9F1C),
              size: 16,
            ),
            const SizedBox(width: 10),
            Text(
              'info@jsconstructions.com',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFFCBD5E1),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterFollowCol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFooterHeader('FOLLOW US'),
        const SizedBox(height: 16),
        Row(
          children: [
            FooterSocialButton(
              child: Text(
                'f',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(width: 8),
            FooterSocialButton(
              child: Text(
                'in',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const FooterSocialButton(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Color(0xFFCBD5E1),
                size: 14,
              ),
            ),
            const SizedBox(width: 8),
            const FooterSocialButton(
              child: Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFFCBD5E1),
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            FooterSocialButton(
              child: Text(
                '𝕏',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFFCBD5E1),
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'STRONGER FOUNDATIONS\nFOR A BRIGHTER FUTURE',
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFF64748B),
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
