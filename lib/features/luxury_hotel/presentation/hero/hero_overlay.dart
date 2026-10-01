import 'package:flutter/material.dart';
import '../utils/hero_opacity_calculator.dart';
import 'hero_stage_one.dart';
import 'hero_stage_two.dart';
import 'hero_stage_three.dart';
import 'hero_stage_four.dart';

class HeroOverlay extends StatelessWidget {
  final double progress;
  final bool isDesktop;
  final VoidCallback onExploreSuites;

  const HeroOverlay({
    super.key,
    required this.progress,
    required this.isDesktop,
    required this.onExploreSuites,
  });

  @override
  Widget build(BuildContext context) {
    final opacity1 = HeroOpacityCalculator.calculate(progress, 0.00, 0.28);
    final opacity2 = HeroOpacityCalculator.calculate(progress, 0.28, 0.58);
    final opacity3 = HeroOpacityCalculator.calculate(progress, 0.58, 0.85);
    final opacity4 = HeroOpacityCalculator.calculate(progress, 0.85, 1.00);

    return Stack(
      children: [
        if (opacity1 > 0.01)
          HeroStageOne(isDesktop: isDesktop, opacity: opacity1),
        if (opacity2 > 0.01)
          HeroStageTwo(isDesktop: isDesktop, opacity: opacity2),
        if (opacity3 > 0.01)
          HeroStageThree(isDesktop: isDesktop, opacity: opacity3),
        if (opacity4 > 0.01)
          HeroStageFour(
            isDesktop: isDesktop,
            opacity: opacity4,
            onExploreSuites: onExploreSuites,
          ),
      ],
    );
  }
}
