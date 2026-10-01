import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../domain/entities/suite.dart';
import '../theme/luxury_hotel_colors.dart';
import 'reserve_suite_dialog.dart';

class SuiteDetailsDialog extends StatelessWidget {
  final Suite suite;
  final VoidCallback? onReserveThisSuite;

  const SuiteDetailsDialog({
    super.key,
    required this.suite,
    this.onReserveThisSuite,
  });

  static Future<void> show(
    BuildContext context,
    Suite suite, {
    VoidCallback? onReserveThisSuite,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => SuiteDetailsDialog(
        suite: suite,
        onReserveThisSuite: onReserveThisSuite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: Dialog(
        backgroundColor: kCharcoal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: kGold, width: 1.5),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720, maxHeight: 650),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: AppImage(
                      assetPath: suite.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  suite.title,
                  style: GoogleFonts.cinzel(
                    color: kIvory,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${suite.price} ${suite.period} • ${suite.sqm} • ${suite.guests}',
                  style: GoogleFonts.spaceMono(
                    color: kGold,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  suite.description,
                  style: GoogleFonts.outfit(
                    color: kMuted,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'BESPOKE SUITE AMENITIES',
                  style: GoogleFonts.cinzel(
                    color: kGold,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                ...suite.features.map((feat) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: kGold,
                          size: 14,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          feat,
                          style: GoogleFonts.outfit(
                            color: kIvory,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'CLOSE',
                        style: GoogleFonts.cinzel(color: kMuted),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onReserveThisSuite != null) {
                          onReserveThisSuite!();
                        } else {
                          ReserveSuiteDialog.show(context, suite);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGold,
                        foregroundColor: kObsidian,
                      ),
                      child: Text(
                        'RESERVE THIS SUITE',
                        style: GoogleFonts.cinzel(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
