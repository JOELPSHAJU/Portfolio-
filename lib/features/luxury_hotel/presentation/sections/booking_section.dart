import 'package:flutter/material.dart';
import '../../domain/entities/booking.dart';
import '../widgets/booking_bar.dart';

class BookingSection extends StatelessWidget {
  final GlobalKey? bookingKey;
  final bool isDesktop;
  final bool isTablet;
  final BookingInfo? bookingInfo;
  final VoidCallback onOpenBooking;

  const BookingSection({
    super.key,
    this.bookingKey,
    required this.isDesktop,
    required this.isTablet,
    this.bookingInfo,
    required this.onOpenBooking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: bookingKey,
      child: BookingBar(
        isDesktop: isDesktop,
        isTablet: isTablet,
        bookingInfo: bookingInfo,
        onOpenBooking: onOpenBooking,
      ),
    );
  }
}
