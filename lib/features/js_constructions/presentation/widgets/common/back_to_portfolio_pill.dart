import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/js_construction_theme.dart';

class BackToPortfolioPill extends StatelessWidget {
  final VoidCallback? onTap;

  const BackToPortfolioPill({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: JsConstructionTheme.kSiteCharcoal.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: JsConstructionTheme.kSafetyAmber.withValues(alpha: 0.4),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.45),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTap ?? () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_back_rounded,
                      color: JsConstructionTheme.kSafetyAmber,
                      size: 15,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'PORTFOLIO',
                      style: GoogleFonts.spaceGrotesk(
                        color: JsConstructionTheme.kSteel,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
