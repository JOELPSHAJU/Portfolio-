import 'package:flutter/material.dart';

class PurelisScrollController {
  final ScrollController scrollController = ScrollController();

  final GlobalKey categoriesKey = GlobalKey();
  final GlobalKey promoKey = GlobalKey();
  final GlobalKey newArrivalsKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();

  void scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void scrollToCategories() => scrollToKey(categoriesKey);
  void scrollToPromo() => scrollToKey(promoKey);
  void scrollToNewArrivals() => scrollToKey(newArrivalsKey);
  void scrollToAbout() => scrollToKey(aboutKey);

  void dispose() {
    scrollController.dispose();
  }
}
