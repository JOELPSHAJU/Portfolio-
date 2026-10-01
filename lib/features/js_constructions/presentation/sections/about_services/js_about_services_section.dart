import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../painters/excavator_icon_painter.dart';
import '../../painters/safety_shield_icon_painter.dart';
import '../../painters/worker_icon_painter.dart';
import '../../widgets/common/about_services_button.dart';

/// ZONE 01: OUR SERVICES & ABOUT SHOWCASE (Building Today for a Stronger Tomorrow)
class JsAboutServicesSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onOurServicesTap;

  const JsAboutServicesSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onOurServicesTap,
  });

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFDF9B35);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isDesktop ? 760 : (isTablet ? 680 : 580),
      ),
      color: Colors.black,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // 1. Full-bleed background image of excavator, sunset, and construction site
          Positioned.fill(
            child: Image.asset(
              'assets/about_const_bg.png',
              fit: BoxFit.cover,
              alignment: isDesktop ? Alignment.centerRight : Alignment.center,
            ),
          ),

          // 2. High-contrast left-to-right gradient overlay keeping excavator visible
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isDesktop
                      ? [
                          Colors.black.withValues(alpha: 0.85),
                          Colors.black.withValues(alpha: 0.74),
                          Colors.black.withValues(alpha: 0.45),
                          Colors.black.withValues(alpha: 0.10),
                          Colors.transparent,
                        ]
                      : (isTablet
                            ? [
                                Colors.black.withValues(alpha: 0.88),
                                Colors.black.withValues(alpha: 0.80),
                                Colors.black.withValues(alpha: 0.52),
                                Colors.black.withValues(alpha: 0.20),
                              ]
                            : [
                                Colors.black.withValues(alpha: 0.92),
                                Colors.black.withValues(alpha: 0.85),
                                Colors.black.withValues(alpha: 0.70),
                                Colors.black.withValues(alpha: 0.45),
                              ]),
                  stops: isDesktop
                      ? const [0.0, 0.35, 0.54, 0.74, 0.92]
                      : (isTablet
                            ? const [0.0, 0.42, 0.72, 1.0]
                            : const [0.0, 0.40, 0.75, 1.0]),
                ),
              ),
            ),
          ),

          // 3. Subtle top and bottom blend vignettes
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.50),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.60),
                  ],
                  stops: const [0.0, 0.10, 0.90, 1.0],
                ),
              ),
            ),
          ),

          // 4. Foreground Content Column (Left Aligned matching mockup)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 80 : (isTablet ? 40 : 20),
              vertical: isDesktop ? 80 : (isTablet ? 60 : 45),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop
                        ? math.min(540.0, screenWidth * 0.46)
                        : (isTablet
                              ? math.min(500.0, screenWidth * 0.75)
                              : double.infinity),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Eyebrow: OUR SERVICES —
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'OUR SERVICES',
                            style: GoogleFonts.outfit(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.4,
                              color: goldColor,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Container(
                            width: 32,
                            height: 2,
                            decoration: BoxDecoration(
                              color: goldColor,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Headline: Building Today for a Stronger Tomorrow
                      Text(
                        'Building Today\nfor a Stronger\nTomorrow',
                        style: GoogleFonts.outfit(
                          fontSize: isDesktop ? 48 : (isTablet ? 36 : 28),
                          fontWeight: FontWeight.w800,
                          height: 1.14,
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Paragraph Description
                      Text(
                        'From earthmoving to final finishes, we handle every phase of construction with precision, safety and a commitment to excellence.',
                        style: GoogleFonts.outfit(
                          fontSize: isDesktop ? 15.5 : 14.5,
                          fontWeight: FontWeight.w400,
                          height: 1.58,
                          color: const Color(0xFFCBD5E1),
                          letterSpacing: 0.15,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Feature 1: Earthworks & Excavation
                      _buildAboutServiceFeatureRow(
                        iconPainter: const ExcavatorIconPainter(),
                        title: 'Earthworks & Excavation',
                        description:
                            'Site preparation and excavation with modern equipment and skilled operators.',
                      ),
                      const SizedBox(height: 22),

                      // Feature 2: Skilled Workforce
                      _buildAboutServiceFeatureRow(
                        iconPainter: const WorkerIconPainter(),
                        title: 'Skilled Workforce',
                        description:
                            'Experienced professionals dedicated to quality and timely delivery.',
                      ),
                      const SizedBox(height: 22),

                      // Feature 3: Safety First
                      _buildAboutServiceFeatureRow(
                        iconPainter: const SafetyShieldIconPainter(),
                        title: 'Safety First',
                        description:
                            'We maintain strict safety standards on every site, every day.',
                      ),
                      const SizedBox(height: 38),

                      // Button: OUR SERVICES →
                      AboutServicesButton(onTap: onOurServicesTap),
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

  Widget _buildAboutServiceFeatureRow({
    required CustomPainter iconPainter,
    required String title,
    required String description,
  }) {
    const goldColor = Color(0xFFDF9B35);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF0F1523).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: goldColor.withValues(alpha: 0.75),
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: goldColor.withValues(alpha: 0.10),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: SizedBox(
            width: 28,
            height: 28,
            child: CustomPaint(painter: iconPainter),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: GoogleFonts.outfit(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  height: 1.45,
                  color: const Color(0xFF94A3B8),
                  letterSpacing: 0.15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
