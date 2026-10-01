import 'package:flutter/material.dart';

class PurelisIconUtils {
  PurelisIconUtils._();

  static IconData resolve(String name) {
    switch (name) {
      case 'eco_outlined':
        return Icons.eco_outlined;
      case 'science_outlined':
        return Icons.science_outlined;
      case 'pets_outlined':
        return Icons.pets_outlined;
      case 'water_drop_outlined':
        return Icons.water_drop_outlined;
      case 'local_shipping_outlined':
        return Icons.local_shipping_outlined;
      case 'cached_rounded':
        return Icons.cached_rounded;
      case 'verified_user_outlined':
        return Icons.verified_user_outlined;
      case 'spa_outlined':
        return Icons.spa_outlined;
      case 'autorenew_rounded':
        return Icons.autorenew_rounded;
      case 'inventory_2_outlined':
        return Icons.inventory_2_outlined;
      default:
        return Icons.eco_outlined;
    }
  }
}
