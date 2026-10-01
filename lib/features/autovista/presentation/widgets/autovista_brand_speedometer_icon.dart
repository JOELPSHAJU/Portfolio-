import 'package:flutter/material.dart';
import '../theme/autovista_colors.dart';

class AutovistaBrandSpeedometerIcon extends StatelessWidget {
  const AutovistaBrandSpeedometerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: AutovistaColors.primaryRed,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.speed_rounded, color: Colors.white, size: 18),
      ),
    );
  }
}
