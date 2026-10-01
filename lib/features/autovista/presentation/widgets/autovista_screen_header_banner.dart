import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/autovista_colors.dart';

class AutovistaScreenHeaderBanner extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;
  final bool isDesktop;

  const AutovistaScreenHeaderBanner({
    super.key,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AutovistaColors.scaffoldDark,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 42 : 28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 14,
                color: AutovistaColors.primaryRed,
              ),
              const SizedBox(width: 8),
              Text(
                tag,
                style: GoogleFonts.spaceMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AutovistaColors.primaryRed,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.anton(
              fontSize: isDesktop ? 38 : 28,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              subtitle,
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
