import 'package:flutter/material.dart';
import '../theme/luxury_hotel_colors.dart';

class BookingDivider extends StatelessWidget {
  final bool isDesktop;

  const BookingDivider({super.key, this.isDesktop = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 48,
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 16 : 6),
      color: kGold.withValues(alpha: 0.2),
    );
  }
}
