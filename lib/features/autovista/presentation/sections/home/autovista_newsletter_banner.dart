import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../theme/autovista_colors.dart';

class AutovistaNewsletterBanner extends StatefulWidget {
  final bool isDesktop;

  const AutovistaNewsletterBanner({super.key, required this.isDesktop});

  @override
  State<AutovistaNewsletterBanner> createState() =>
      _AutovistaNewsletterBannerState();
}

class _AutovistaNewsletterBannerState extends State<AutovistaNewsletterBanner> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: const BoxDecoration(
          color: AutovistaColors.cardDark,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Stack(
          children: [
            // Dark luxury car background silhouette
            const Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 350,
              child: Opacity(
                opacity: 0.35,
                child: AppImage(
                  assetPath: 'assets/autovista_newsletter_car.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            if (isDesktop)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left text & email icon
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AutovistaColors.primaryRed,
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.mail_outline_rounded,
                            color: AutovistaColors.primaryRed,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Stay in the Loop',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Subscribe to get exclusive rental discounts, weekend specials and fleet news.',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 24),

                  // Right Email input + Subscribe button
                  _buildInputForm(context, true),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AutovistaColors.primaryRed,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.mail_outline_rounded,
                          color: AutovistaColors.primaryRed,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Stay in the Loop',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Subscribe to get exclusive rental discounts, weekend specials and fleet news.',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildInputForm(context, false),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputForm(BuildContext context, bool isDesktop) {
    return Container(
      width: isDesktop ? 360 : double.infinity,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: TextField(
                controller: _controller,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your email for rental deals',
                  hintStyle: GoogleFonts.outfit(
                    fontSize: 12.5,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (_controller.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Thank you for subscribing to Go Drive VIP rental deals!',
                      ),
                      backgroundColor: AutovistaColors.primaryRed,
                    ),
                  );
                  _controller.clear();
                }
              },
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: AutovistaColors.primaryRed,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(7),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Subscribe',
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
