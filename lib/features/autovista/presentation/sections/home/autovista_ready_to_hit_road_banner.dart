import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../theme/autovista_colors.dart';

class AutovistaReadyToHitRoadBanner extends StatelessWidget {
  final VoidCallback? onRentNow;

  const AutovistaReadyToHitRoadBanner({super.key, this.onRentNow});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AutovistaColors.cardDark,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // Background Car Rear Light Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: const Opacity(
                opacity: 0.85,
                child: AppImage(
                  assetPath: 'assets/autovista_test_drive.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ),

          // Left Gradient Scrim
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AutovistaColors.cardDark,
                    AutovistaColors.cardDark.withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 0.85],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(22),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'READY TO\nHIT THE ',
                        style: GoogleFonts.anton(
                          fontSize: 22,
                          letterSpacing: 1,
                          height: 1.1,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'ROAD?',
                        style: GoogleFonts.anton(
                          fontSize: 22,
                          letterSpacing: 1,
                          height: 1.1,
                          color: AutovistaColors.primaryRed,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Book your rental today and\nfeel the ultimate driving thrill.',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 14),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onRentNow,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Rent Now',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  }
}
