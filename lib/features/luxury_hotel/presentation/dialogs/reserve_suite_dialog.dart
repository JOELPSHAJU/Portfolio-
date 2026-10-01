import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/suite.dart';
import '../theme/luxury_hotel_colors.dart';

class ReserveSuiteDialog extends StatelessWidget {
  final Suite suite;

  const ReserveSuiteDialog({super.key, required this.suite});

  static Future<void> show(BuildContext context, Suite suite) {
    return showDialog(
      context: context,
      builder: (ctx) => ReserveSuiteDialog(suite: suite),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: AlertDialog(
        backgroundColor: kCharcoal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: kGold, width: 1.5),
        ),
        title: Text(
          'RESERVE ${suite.title.toUpperCase()}',
          style: GoogleFonts.cinzel(
            color: kIvory,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${suite.price} ${suite.period} • ${suite.sqm} • ${suite.view}',
                style: GoogleFonts.spaceMono(
                  color: kGold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                suite.description,
                style: GoogleFonts.outfit(
                  color: kMuted,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'DISMISS',
              style: GoogleFonts.cinzel(color: kMuted),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kGold,
                  content: Text(
                    'Sanctuary reserved: ${suite.title}. Welcome to Lumina Palace.',
                    style: GoogleFonts.outfit(
                      color: kObsidian,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kGold,
              foregroundColor: kObsidian,
            ),
            child: Text(
              'PROCEED TO CHECKOUT',
              style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
