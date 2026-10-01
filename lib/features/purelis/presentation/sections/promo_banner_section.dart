import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../theme/purelis_colors.dart';
import '../widgets/eco_badge_item.dart';
import '../widgets/skincare_button.dart';

class PromoBannerSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onExploreOffersTap;
  final GlobalKey? sectionKey;

  const PromoBannerSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onExploreOffersTap,
    this.sectionKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 60 : 20),
      decoration: BoxDecoration(
        color: PurelisColors.promoBg,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: isDesktop
          ? const EdgeInsets.symmetric(horizontal: 44)
          : const EdgeInsets.all(24),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left promo copy
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 44),
                    child: _buildPromoLeftContent(),
                  ),
                ),
                const SizedBox(width: 40),
                // Right promo product arrangement
                Expanded(
                  flex: 7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const AppImage(
                      assetPath: 'assets/purelis_promo.png',
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPromoLeftContent(),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const AppImage(
                    assetPath: 'assets/purelis_promo.png',
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPromoLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'GOOD FOR YOUR SKIN.\nGOOD FOR THE PLANET.',
          style: GoogleFonts.outfit(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
            color: PurelisColors.promoAccent,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Up to 25% Off\nSitewide',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            color: PurelisColors.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 22),
        SkincareButton(
          label: 'EXPLORE OFFERS',
          onTap: onExploreOffersTap,
        ),
        const SizedBox(height: 28),
        const Wrap(
          spacing: 16,
          runSpacing: 10,
          children: [
            EcoBadgeItem(
              icon: Icons.spa_outlined,
              label: 'Clean Beauty',
            ),
            EcoBadgeItem(
              icon: Icons.autorenew_rounded,
              label: 'Sustainable',
            ),
            EcoBadgeItem(
              icon: Icons.inventory_2_outlined,
              label: 'Eco-Friendly Packaging',
            ),
          ],
        ),
      ],
    );
  }
}
