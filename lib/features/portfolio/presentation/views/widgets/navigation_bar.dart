import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';

class PortfolioHeader extends StatelessWidget {
  final String activeSection;
  final Function(String) onSectionSelected;

  const PortfolioHeader({
    super.key,
    required this.activeSection,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    return Container(
      // Fully transparent container — no color, no decoration
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: GlassContainer(
        borderRadius: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        blur: 18.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Branding / Logo
            GestureDetector(
              onTap: () => onSectionSelected('home'),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: BrandColors.primaryGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'JS',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: const Color(0xFF141010),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'JOEL P SHAJU',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF141010),
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Flutter Architect',
                          style: TextStyle(
                            fontSize: 10,
                            color: BrandColors.secondaryNeon,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Navigation Options
            if (isDesktop)
              Row(
                children: [
                  _buildNavLink('Home', 'home'),
                  _buildNavLink('About', 'about'),
                  _buildNavLink('Experience', 'experience'),
                  _buildNavLink('Skills', 'skills'),
                  _buildNavLink('Projects', 'projects'),
                  _buildNavLink('Contact', 'contact'),
                  const SizedBox(width: 12),
                  // Glowing CTA Button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: BrandColors.primaryGradient,
                        boxShadow: [
                          BoxShadow(
                            color: BrandColors.primaryNeon.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => onSectionSelected('contact'),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Hire Me',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF141010),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: const Color(0xFF141010),
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              // Mobile Hamburger Icon
              IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: const Color(0xFF141010),
                  size: 28,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, String sectionId) {
    final isActive = activeSection == sectionId;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onSectionSelected(sectionId),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFFA0743B),
                  fontWeight:
                      isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 14.0,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 2,
                width: isActive ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: BrandColors.primaryGradient,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: BrandColors.primaryNeon.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
