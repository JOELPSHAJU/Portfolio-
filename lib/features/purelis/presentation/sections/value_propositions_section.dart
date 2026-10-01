import 'package:flutter/material.dart';
import '../../domain/entities/value_proposition.dart';
import '../theme/purelis_colors.dart';
import '../widgets/value_proposition_item.dart';

class ValuePropositionsSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final List<ValueProposition>? items;

  const ValuePropositionsSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    this.items,
  });

  static const List<ValueProposition> defaultItems = [
    ValueProposition(
      icon: 'eco_outlined',
      title: 'Natural Ingredients',
      subtitle: 'Safe & toxin-free',
    ),
    ValueProposition(
      icon: 'science_outlined',
      title: 'Clinically Tested',
      subtitle: 'Dermatologically proven',
    ),
    ValueProposition(
      icon: 'pets_outlined',
      title: 'Cruelty Free',
      subtitle: 'We never test on animals',
    ),
    ValueProposition(
      icon: 'water_drop_outlined',
      title: 'For All Skin Types',
      subtitle: 'Gentle & effective care',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final list = (items != null && items!.isNotEmpty) ? items! : defaultItems;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 24,
      ),
      decoration: const BoxDecoration(
        color: PurelisColors.valuesBg,
        border: Border(
          top: BorderSide(color: PurelisColors.borderSubtle, width: 1.0),
          bottom: BorderSide(color: PurelisColors.borderSubtle, width: 1.0),
        ),
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: list
                  .map((item) => Flexible(child: ValuePropositionItem(item: item)))
                  .toList(),
            )
          : Wrap(
              spacing: 24,
              runSpacing: 20,
              alignment: WrapAlignment.spaceAround,
              children: list
                  .map(
                    (item) => SizedBox(
                      width: isTablet ? 240 : 160,
                      child: ValuePropositionItem(item: item),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}
