import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/theme/theme_controller.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';

class MobileDrawer extends ConsumerWidget {
  final String activeSection;
  final Function(String) onSectionSelected;

  const MobileDrawer({
    super.key,
    required this.activeSection,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pal = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GlassContainer(
        borderRadius: 0,
        blur: 25,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        customGradient: LinearGradient(
          colors: [
            isDark
                ? BrandColors.darkBackground.withOpacity(0.97)
                : const Color(0xFFFFFFFF).withOpacity(0.85),
            isDark
                ? BrandColors.darkSurface.withOpacity(0.97)
                : const Color(0xFFF2F2F2).withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NAVIGATION',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    color: BrandColors.primaryNeon,
                    letterSpacing: 2.5,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded, color: pal.textPrimary, size: 22),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 36),

            _item(context, 'Home', Icons.home_filled, 'home', pal),
            _item(context, 'About', Icons.person_rounded, 'about', pal),
            _item(context, 'Experience', Icons.work_history_rounded, 'experience', pal),
            _item(context, 'Skills', Icons.psychology_rounded, 'skills', pal),
            _item(context, 'Projects', Icons.code_rounded, 'projects', pal),
            _item(context, 'Contact', Icons.mail_rounded, 'contact', pal),

            const Spacer(),

            // Theme toggle
            GestureDetector(
              onTap: () => ref.read(themeModeProvider.notifier).toggleTheme(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: BrandColors.primaryNeon.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: BrandColors.primaryNeon.withOpacity(0.20),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      themeMode == ThemeMode.dark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color: BrandColors.primaryNeon,
                      size: 19,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      themeMode == ThemeMode.dark
                          ? 'Switch to Light Mode'
                          : 'Switch to Dark Mode',
                      style: TextStyle(
                        color: pal.textPrimary,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Divider(color: pal.glassBorder, height: 1),
            const SizedBox(height: 20),
            Text(
              'GET IN TOUCH',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: pal.warmBrown,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 8),
            const SelectableText(
              'joelpshaju@gmail.com',
              style: TextStyle(color: BrandColors.primaryNeon, fontSize: 13),
            ),
            const SizedBox(height: 4),
            SelectableText(
              '+91 8590182736',
              style: TextStyle(color: pal.warmBrown, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String title,
    IconData icon,
    String sectionId,
    AppPalette pal,
  ) {
    final isActive = activeSection == sectionId;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isActive ? BrandColors.primaryGradient : null,
        color: isActive ? null : pal.warmCream,
        border: Border.all(
          color: isActive
              ? BrandColors.primaryNeon.withOpacity(0.4)
              : Colors.transparent,
        ),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isActive ? Colors.white : BrandColors.primaryNeon,
          size: 19,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : pal.textPrimary,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            fontSize: 14.5,
            letterSpacing: 0.3,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          onSectionSelected(sectionId);
        },
      ),
    );
  }
}
