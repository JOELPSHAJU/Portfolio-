import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../theme/purelis_colors.dart';
import '../widgets/skincare_button.dart';

class HeroSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onShopNowTap;

  const HeroSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onShopNowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PurelisColors.heroBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 0 : 36,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Typography & Shop Now CTA
                Expanded(flex: 5, child: _buildHeroLeftText()),
                const SizedBox(width: 40),
                // Right Column: Skincare Products on Stone Podium
                Expanded(flex: 7, child: _buildHeroRightImage()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroLeftText(),
                const SizedBox(height: 36),
                _buildHeroRightImage(),
              ],
            ),
    );
  }

  Widget _buildHeroLeftText() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 60 : 12,
        horizontal: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'NATURALLY PURE.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: isDesktop ? 46 : 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              color: PurelisColors.textPrimary,
              height: 1.1,
            ),
          ),
          Text(
            'BEAUTIFULLY YOU.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: isDesktop ? 46 : 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              color: PurelisColors.topBarGreen,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Clean, effective & cruelty-free skincare\nenriched with nature’s finest ingredients.',
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 15.5 : 14.0,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF3E4A3E),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),
          SkincareButton(
            label: 'SHOP NOW',
            onTap: onShopNowTap,
          ),
        ],
      ),
    );
  }

  Widget _buildHeroRightImage() {
    return SizedBox(
      width: double.infinity,
      height: isDesktop ? 540 : 380,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: const AppImage(
          assetPath: 'assets/purelis_hero.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
