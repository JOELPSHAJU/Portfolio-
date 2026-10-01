import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/privilege_bullet.dart';

class BookingDialog extends StatelessWidget {
  final List<String>? privilegeInclusions;
  final String sampleDates;
  final String sampleSummary;
  final String samplePrice;

  const BookingDialog({
    super.key,
    this.privilegeInclusions,
    this.sampleDates = 'OCTOBER 14 – 21, 2026',
    this.sampleSummary = '7 Nights • 2 Guests • Royal Imperial Penthouse',
    this.samplePrice = '\$33,600',
  });

  static Future<void> show(
    BuildContext context, {
    List<String>? privilegeInclusions,
    String sampleDates = 'OCTOBER 14 – 21, 2026',
    String sampleSummary = '7 Nights • 2 Guests • Royal Imperial Penthouse',
    String samplePrice = '\$33,600',
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => BookingDialog(
        privilegeInclusions: privilegeInclusions,
        sampleDates: sampleDates,
        sampleSummary: sampleSummary,
        samplePrice: samplePrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inclusions = privilegeInclusions ??
        const [
          'Complimentary AgustaWestland or Yacht Transfer',
          'Welcome chilled Dom Pérignon Vintage 2015',
          'Guaranteed 12:00 Check-in & 16:00 Late Check-out',
          '24/7 Dedicated White-Glove Butler Guild',
        ];

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: AlertDialog(
        backgroundColor: kCharcoal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: kGold, width: 1.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.verified_rounded, color: kGold, size: 22),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'CONFIRM SANCTUARY DATES',
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Direct Booking Privilege Inclusions:',
                style: GoogleFonts.outfit(
                  color: kGold,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ...inclusions.map((text) => PrivilegeBullet(text: text)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: kObsidian,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kGold.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sampleDates,
                            style: GoogleFonts.spaceMono(
                              color: kGold,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            sampleSummary,
                            style: GoogleFonts.outfit(
                              color: kMuted,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      samplePrice,
                      style: GoogleFonts.cinzel(
                        color: kIvory,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('CLOSE', style: GoogleFonts.cinzel(color: kMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kGold,
                  content: Text(
                    'Your provisional haven reservation is registered. Our Butler concierge will contact you shortly.',
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
              'REQUEST RESERVATION',
              style: GoogleFonts.cinzel(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
