import 'package:flutter/material.dart';

class PurelisResponsive {
  PurelisResponsive._();

  static const double desktopBreakpoint = 1024;
  static const double tabletBreakpoint = 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tabletBreakpoint;
}
