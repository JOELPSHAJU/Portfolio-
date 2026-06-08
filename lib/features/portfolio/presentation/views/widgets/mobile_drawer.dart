import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';


class MobileDrawer extends StatelessWidget {
  final String activeSection;
  final Function(String) onSectionSelected;

  const MobileDrawer({
    super.key,
    required this.activeSection,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GlassContainer(
        borderRadius: 0,
        blur: 25.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        customGradient: LinearGradient(
          colors: [
            BrandColors.darkBackground.withOpacity(0.95),
            BrandColors.darkSurface.withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button & Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'NAVIGATION',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: BrandColors.secondaryNeon,
                    letterSpacing: 2.0,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: BrandColors.textDark, size: 24),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Navigation list items
            _buildDrawerItem(context, 'Home', Icons.home_filled, 'home'),
            _buildDrawerItem(context, 'About', Icons.person_rounded, 'about'),
            _buildDrawerItem(context, 'Experience', Icons.work_history_rounded, 'experience'),
            _buildDrawerItem(context, 'Skills', Icons.psychology_rounded, 'skills'),
            _buildDrawerItem(context, 'Projects', Icons.code_rounded, 'projects'),
            _buildDrawerItem(context, 'Contact', Icons.mail_rounded, 'contact'),

            const Spacer(),

            // Footer Contact Details
            const Divider(color: BrandColors.glassBorder, height: 1),
            const SizedBox(height: 24),
            const Text(
              'GET IN TOUCH',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: BrandColors.warmBrown,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            const SelectableText(
              'joelpshaju@gmail.com',
              style: TextStyle(color: BrandColors.secondaryNeon, fontSize: 13),
            ),
            const SizedBox(height: 4),
            const SelectableText(
              '+91 8590182736',
              style: TextStyle(color: BrandColors.warmBrown, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    String sectionId,
  ) {
    final isActive = activeSection == sectionId;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isActive ? BrandColors.primaryGradient : null,
        color: isActive ? BrandColors.warmGold.withOpacity(0.15) : BrandColors.warmCream,
        border: isActive
            ? Border.all(color: BrandColors.warmGold.withOpacity(0.35))
            : Border.all(color: Colors.transparent),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isActive ? Colors.white : BrandColors.warmAccent,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : BrandColors.heroBg1.withOpacity(0.9),
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 15,
            letterSpacing: 0.5,
          ),
        ),
        onTap: () {
          Navigator.pop(context); // Close Drawer
          onSectionSelected(sectionId);
        },
      ),
    );
  }
}
