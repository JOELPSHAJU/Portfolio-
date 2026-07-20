import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/theme/theme_controller.dart';
import 'package:joel_portfolio/core/widgets/adaptive_logo.dart';

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

    final drawerBg = pal.card;
    final divColor = pal.glassBorder;

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Drawer(
      backgroundColor: drawerBg,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
            decoration: BoxDecoration(
              color: pal.surface,
              border: Border(bottom: BorderSide(color: divColor, width: 1)),
            ),
            child: Row(
              children: [
                const AdaptiveLogo(height: 36, floatingInDarkMode: true),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'JOEL P SHAJU',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: pal.textPrimary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'Flutter Architect',
                        style: TextStyle(
                          fontSize: 10,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: pal.warmBrown,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Nav items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                _item(
                  context,
                  'Home',
                  Icons.home_outlined,
                  'home',
                  pal,
                  isDark,
                ),
                _item(
                  context,
                  'About',
                  Icons.person_outline_rounded,
                  'about',
                  pal,
                  isDark,
                ),
                _item(
                  context,
                  'Experience',
                  Icons.work_outline_rounded,
                  'experience',
                  pal,
                  isDark,
                ),
                _item(
                  context,
                  'Skills',
                  Icons.psychology_outlined,
                  'skills',
                  pal,
                  isDark,
                ),
                _item(
                  context,
                  'Projects',
                  Icons.code_rounded,
                  'projects',
                  pal,
                  isDark,
                ),
                _item(
                  context,
                  'Contact',
                  Icons.mail_outline_rounded,
                  'contact',
                  pal,
                  isDark,
                ),
              ],
            ),
          ),

          // Bottom actions
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Column(
              children: [
                Divider(color: divColor, height: 1),
                const SizedBox(height: 16),

                // Theme toggle
                GestureDetector(
                  onTap: () =>
                      ref.read(themeModeProvider.notifier).toggleTheme(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: primaryColor.withOpacity(0.20)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          themeMode == ThemeMode.dark
                              ? Icons.wb_sunny_rounded
                              : Icons.nightlight_round,
                          color: primaryColor,
                          size: 18,
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
                const SizedBox(height: 16),

                // Contact info
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: pal.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: divColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GET IN TOUCH',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          color: pal.warmBrown,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'joelpshaju@gmail.com',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        '+91 8590182736',
                        style: TextStyle(color: pal.warmBrown, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String title,
    IconData icon,
    String sectionId,
    AppPalette pal,
    bool isDark,
  ) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isActive = activeSection == sectionId;
    final activeBg = primaryColor.withOpacity(0.10);
    final activeText = primaryColor;
    final inactiveBg = Colors.transparent;
    final inactiveText = pal.textPrimary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? activeBg : inactiveBg,
        border: isActive
            ? Border.all(color: primaryColor.withOpacity(0.25))
            : null,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          icon,
          color: isActive ? activeText : pal.warmBrown,
          size: 19,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isActive ? activeText : inactiveText,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14.5,
            letterSpacing: 0.2,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          Navigator.pop(context);
          onSectionSelected(sectionId);
        },
      ),
    );
  }
}
