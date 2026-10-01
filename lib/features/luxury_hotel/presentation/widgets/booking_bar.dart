import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/booking.dart';
import '../theme/luxury_hotel_colors.dart';
import 'booking_divider.dart';
import 'booking_input.dart';

class BookingBar extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final BookingInfo? bookingInfo;
  final VoidCallback onOpenBooking;

  const BookingBar({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    this.bookingInfo,
    required this.onOpenBooking,
  });

  @override
  Widget build(BuildContext context) {
    final info = bookingInfo;
    final checkIn = info?.checkIn ?? 'Oct 14, 2026';
    final checkInSub = info?.checkInSubtitle ?? 'From 15:00';
    final checkOut = info?.checkOut ?? 'Oct 21, 2026';
    final checkOutSub = info?.checkOutSubtitle ?? '7 Nights Stay';
    final guests = info?.guests ?? '2 Adults, 1 Suite';
    final guestsSub = info?.guestsSubtitle ?? 'Private Butler Concierge';
    final tier = info?.tier ?? 'Imperial Penthouse';
    final tierSub = info?.tierSubtitle ?? 'Complimentary Yacht Transfer';

    final datesCompact = info?.datesCompact ?? 'Oct 14 – 21, 2026';
    final datesSubtitleCompact = info?.datesSubtitleCompact ?? '7 Nights';
    final guestsCompact = info?.guestsCompact ?? '2 Adults';
    final guestsSubtitleCompact = info?.guestsSubtitleCompact ?? 'Butler Concierge';

    return Container(
      margin: EdgeInsets.fromLTRB(
        isDesktop ? 60 : (isTablet ? 30 : 12),
        36,
        isDesktop ? 60 : (isTablet ? 30 : 12),
        16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : (isTablet ? 20 : 14),
        vertical: isDesktop ? 24 : 18,
      ),
      decoration: BoxDecoration(
        color: kCharcoal,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kGold.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 35,
            spreadRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 16, height: 2, color: kGold),
                  const SizedBox(width: 8),
                  Text(
                    isDesktop
                        ? 'DIRECT SANCTUARY RESERVATION'
                        : 'SANCTUARY RESERVATION',
                    style: GoogleFonts.cinzel(
                      color: kGold,
                      fontSize: isDesktop ? 11 : 9.5,
                      letterSpacing: isDesktop ? 2.2 : 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                'BEST SUITE PRIVILEGES GUARANTEED',
                style: GoogleFonts.spaceMono(
                  color: kMuted,
                  fontSize: isDesktop ? 10 : 8.5,
                  letterSpacing: isDesktop ? 1.1 : 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (isDesktop)
            Row(
              children: [
                Expanded(
                  child: BookingInput(
                    icon: Icons.calendar_today_rounded,
                    label: 'CHECK-IN',
                    value: checkIn,
                    subtitle: checkInSub,
                    onTap: onOpenBooking,
                  ),
                ),
                const BookingDivider(isDesktop: true),
                Expanded(
                  child: BookingInput(
                    icon: Icons.calendar_month_rounded,
                    label: 'CHECK-OUT',
                    value: checkOut,
                    subtitle: checkOutSub,
                    onTap: onOpenBooking,
                  ),
                ),
                const BookingDivider(isDesktop: true),
                Expanded(
                  child: BookingInput(
                    icon: Icons.person_outline_rounded,
                    label: 'GUESTS',
                    value: guests,
                    subtitle: guestsSub,
                    onTap: onOpenBooking,
                  ),
                ),
                const BookingDivider(isDesktop: true),
                Expanded(
                  child: BookingInput(
                    icon: Icons.bed_outlined,
                    label: 'TIER',
                    value: tier,
                    subtitle: tierSub,
                    onTap: onOpenBooking,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: onOpenBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGold,
                    foregroundColor: kObsidian,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 22,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'CHECK AVAILABILITY',
                        style: GoogleFonts.cinzel(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: BookingInput(
                        icon: Icons.calendar_today_rounded,
                        label: 'DATES',
                        value: datesCompact,
                        subtitle: datesSubtitleCompact,
                        compact: true,
                        onTap: onOpenBooking,
                      ),
                    ),
                    const BookingDivider(isDesktop: false),
                    Expanded(
                      child: BookingInput(
                        icon: Icons.person_outline_rounded,
                        label: 'GUESTS',
                        value: guestsCompact,
                        subtitle: guestsSubtitleCompact,
                        compact: true,
                        onTap: onOpenBooking,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onOpenBooking,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kObsidian,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'CHECK SANCTUARY AVAILABILITY',
                      style: GoogleFonts.cinzel(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
