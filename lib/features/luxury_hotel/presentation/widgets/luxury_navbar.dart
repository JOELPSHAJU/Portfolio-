import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';
import 'nav_button.dart';

class LuxuryNavbar extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onSuitesTap;
  final VoidCallback onDiningTap;
  final VoidCallback onSpaTap;
  final VoidCallback onPrivilegesTap;
  final VoidCallback onReserveTap;

  const LuxuryNavbar({
    super.key,
    required this.isDesktop,
    required this.onSuitesTap,
    required this.onDiningTap,
    required this.onSpaTap,
    required this.onPrivilegesTap,
    required this.onReserveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 20 : 12,
                vertical: isDesktop ? 8 : 6,
              ),
              decoration: BoxDecoration(
                color: kCharcoal.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: kGold.withValues(alpha: 0.25),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.hotel_class_rounded,
                        color: kGold,
                        size: 18,
                      ),
                      if (isDesktop) ...[
                        const SizedBox(width: 8),
                        Text(
                          'THE LUMINA',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 24),
                    NavButton(label: 'SUITES', onTap: onSuitesTap),
                    NavButton(label: 'DINING', onTap: onDiningTap),
                    NavButton(label: 'THALASSO SPA', onTap: onSpaTap),
                    NavButton(label: 'PRIVILEGES', onTap: onPrivilegesTap),
                  ],
                  SizedBox(width: isDesktop ? 16 : 8),
                  ElevatedButton(
                    onPressed: onReserveTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kObsidian,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 16 : 12,
                        vertical: isDesktop ? 10 : 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'RESERVE',
                          style: GoogleFonts.cinzel(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_rounded, size: 13),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
