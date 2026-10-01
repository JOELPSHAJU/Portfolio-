import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../theme/autovista_colors.dart';

class AutovistaHeroSection extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback? onBookRental;

  const AutovistaHeroSection({
    super.key,
    required this.isDesktop,
    this.onBookRental,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: isDesktop ? 480 : 380,
      color: AutovistaColors.scaffoldDark,
      child: Stack(
        children: [
          // Background Hero Porsche Car Image
          const Positioned.fill(
            child: AppImage(
              assetPath: 'assets/autovista_hero_porsche.jpg',
              fit: BoxFit.cover,
              alignment: Alignment(0.4, 0),
            ),
          ),

          // High-End Luxury Dark Vignette Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AutovistaColors.scaffoldDark.withValues(alpha: 0.95),
                    AutovistaColors.scaffoldDark.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.9],
                ),
              ),
            ),
          ),

          // Hero Text Content on Left
          Positioned(
            top: 0,
            bottom: 0,
            left: isDesktop ? 48 : 24,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Accent Tag
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 14,
                          color: AutovistaColors.primaryRed,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'POWER. PERFORMANCE. FREEDOM.',
                          style: GoogleFonts.spaceMono(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.85),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Massive Headline
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'RENT THE\n',
                            style: GoogleFonts.anton(
                              fontSize: isDesktop ? 54 : 40,
                              letterSpacing: 1.5,
                              height: 1.0,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'EXPERIENCE',
                            style: GoogleFonts.anton(
                              fontSize: isDesktop ? 54 : 40,
                              letterSpacing: 1.5,
                              height: 1.0,
                              color: AutovistaColors.primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Explore our premium fleet of luxury, sports,\nand executive rental cars on your own terms.',
                      style: GoogleFonts.outfit(
                        fontSize: 14.5,
                        height: 1.5,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 26),

                    // Book Your Rental Pill CTA Button & Slider indicators
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: onBookRental,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AutovistaColors.primaryRed,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Book Your Rental',
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: AutovistaColors.primaryRed,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Carousel dots
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AutovistaColors.primaryRed,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
