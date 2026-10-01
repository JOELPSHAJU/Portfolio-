import 'package:flutter/material.dart';
import '../widgets/hoverable_nav_link.dart';
import '../widgets/purelis_logo.dart';

class HeaderSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onLogoTap;
  final VoidCallback onShopTap;
  final VoidCallback onCollectionsTap;
  final VoidCallback onAboutTap;
  final VoidCallback onContactTap;
  final VoidCallback onSearchTap;
  final VoidCallback onAccountTap;

  const HeaderSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onLogoTap,
    required this.onShopTap,
    required this.onCollectionsTap,
    required this.onAboutTap,
    required this.onContactTap,
    required this.onSearchTap,
    required this.onAccountTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEBE8E1), width: 1.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Brand Logo
          PurelisLogo(onTap: onLogoTap),

          // Center: Navigation links (Desktop)
          if (isDesktop)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                HoverableNavLink(label: 'HOME', isSelected: true, onTap: () {}),
                const SizedBox(width: 32),
                HoverableNavLink(
                  label: 'SHOP',
                  hasDropdown: true,
                  onTap: onShopTap,
                ),
                const SizedBox(width: 32),
                HoverableNavLink(
                  label: 'COLLECTIONS',
                  hasDropdown: true,
                  onTap: onCollectionsTap,
                ),
                const SizedBox(width: 32),
                HoverableNavLink(
                  label: 'ABOUT US',
                  onTap: onAboutTap,
                ),
                const SizedBox(width: 32),
                HoverableNavLink(label: 'BLOG', onTap: () {}),
                const SizedBox(width: 32),
                HoverableNavLink(
                  label: 'CONTACT',
                  onTap: onContactTap,
                ),
              ],
            ),

          // Right: Action Icons (Search, Profile)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onSearchTap,
                icon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF222222),
                  size: 21,
                ),
                splashRadius: 20,
                tooltip: 'Search',
              ),
              const SizedBox(width: 6),
              IconButton(
                onPressed: onAccountTap,
                icon: const Icon(
                  Icons.person_outline_rounded,
                  color: Color(0xFF222222),
                  size: 21,
                ),
                splashRadius: 20,
                tooltip: 'Account',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
