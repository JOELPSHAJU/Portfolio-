import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class TableReservationDialog extends StatelessWidget {
  final String restaurantName;

  const TableReservationDialog({super.key, required this.restaurantName});

  static Future<void> show(BuildContext context, String restaurantName) {
    return showDialog(
      context: context,
      builder: (ctx) => TableReservationDialog(restaurantName: restaurantName),
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
          'RESERVE TABLE AT $restaurantName',
          style: GoogleFonts.cinzel(
            color: kIvory,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Select preferred seating for dinner tonight. Michelin degustation table with direct sommelier pairing.',
          style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('CANCEL', style: GoogleFonts.cinzel(color: kMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kGold,
                  content: Text(
                    'Table reservation requested for $restaurantName. Sommelier notified.',
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
              'CONFIRM TABLE',
              style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
