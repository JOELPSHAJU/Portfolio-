import 'package:flutter/material.dart';
import '../../domain/entities/accolade.dart';
import '../theme/luxury_hotel_colors.dart';
import '../widgets/accolade_card.dart';

class AccoladesSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final List<Accolade> accolades;

  const AccoladesSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.accolades,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 50,
      ),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: kGold.withValues(alpha: 0.2)),
        ),
      ),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: isDesktop ? 60 : 30,
          runSpacing: 24,
          children: accolades.map((a) => AccoladeCard(accolade: a)).toList(),
        ),
      ),
    );
  }
}
