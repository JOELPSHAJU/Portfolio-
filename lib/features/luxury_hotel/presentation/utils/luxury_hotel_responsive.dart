import 'package:flutter/material.dart';
import '../theme/luxury_hotel_dimensions.dart';

class LuxuryHotelResponsive {
  LuxuryHotelResponsive._();

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= LuxuryHotelDimensions.desktopBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= LuxuryHotelDimensions.tabletBreakpoint &&
        width < LuxuryHotelDimensions.desktopBreakpoint;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < LuxuryHotelDimensions.tabletBreakpoint;
  }
}
