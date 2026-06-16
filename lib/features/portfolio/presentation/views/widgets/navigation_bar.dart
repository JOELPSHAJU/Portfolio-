import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/theme/theme_controller.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';

class PortfolioHeader extends ConsumerWidget {
  final String activeSection;
  final Function(String) onSectionSelected;

  const PortfolioHeader({
    super.key,
    required this.activeSection,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    final pal = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: GlassContainer(
        borderRadius: 16,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
        blur: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ── Logo / Branding ─────────────────────────────────
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
                      child: Text(
                        'JS',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: isDark ? BrandColors.darkBackground : Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'JOEL P SHAJU',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: pal.textPrimary,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          'Flutter Architect',
                          style: TextStyle(
                            fontSize: 10,
                            color: BrandColors.primaryNeon,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ── Desktop Nav ─────────────────────────────────────
            if (isDesktop)
              Row(
                children: [
                  _NavLink('Home', 'home', activeSection, onSectionSelected, pal),
                  _NavLink('About', 'about', activeSection, onSectionSelected, pal),
                  _NavLink('Experience', 'experience', activeSection, onSectionSelected, pal),
                  _NavLink('Skills', 'skills', activeSection, onSectionSelected, pal),
                  _NavLink('Projects', 'projects', activeSection, onSectionSelected, pal),
                  _NavLink('Contact', 'contact', activeSection, onSectionSelected, pal),
                  const SizedBox(width: 8),
                  _ThemeToggle(isDark: isDark, ref: ref),
                  const SizedBox(width: 12),
                  _HireMeButton(
                    isDark: isDark,
                    onTap: () => onSectionSelected('contact'),
                  ),
                ],
              )
            else
              Row(
                children: [
                  _ThemeToggle(isDark: isDark, ref: ref),
                  const SizedBox(width: 6),
                  IconButton(
                    icon: Icon(Icons.menu_rounded, color: pal.textPrimary, size: 26),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// ── Nav Link ──────────────────────────────────────────────────────────────────
class _NavLink extends StatefulWidget {
  final String title;
  final String sectionId;
  final String activeSection;
  final Function(String) onTap;
  final AppPalette pal;

  const _NavLink(
    this.title,
    this.sectionId,
    this.activeSection,
    this.onTap,
    this.pal,
  );

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.activeSection == widget.sectionId;
    final color = isActive
        ? BrandColors.primaryNeon
        : _hovered
            ? BrandColors.primaryNeon.withOpacity(0.8)
            : widget.pal.warmBrown;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.sectionId),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: color,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13.5,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 2,
                width: isActive ? 20 : 0,
                decoration: BoxDecoration(
                  color: BrandColors.primaryNeon,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Hire Me Button ────────────────────────────────────────────────────────────
class _HireMeButton extends StatefulWidget {
  final bool isDark;
  final VoidCallback onTap;
  const _HireMeButton({required this.isDark, required this.onTap});

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: BrandColors.primaryGradient,
            boxShadow: [
              BoxShadow(
                color: BrandColors.primaryNeon.withOpacity(_hovered ? 0.4 : 0.2),
                blurRadius: _hovered ? 14 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Hire Me',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: widget.isDark ? BrandColors.darkBackground : Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: widget.isDark ? BrandColors.darkBackground : Colors.white,
                      size: 13,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Theme Toggle Button ───────────────────────────────────────────────────────
class _ThemeToggle extends StatefulWidget {
  final bool isDark;
  final WidgetRef ref;
  const _ThemeToggle({required this.isDark, required this.ref});

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _spin;
  late Animation<double> _spinAnim;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _spinAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _spin, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          _spin.forward(from: 0);
          widget.ref.read(themeModeProvider.notifier).toggleTheme();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: _hovered
                ? BrandColors.primaryNeon.withOpacity(0.15)
                : BrandColors.primaryNeon.withOpacity(0.07),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? BrandColors.primaryNeon.withOpacity(0.45)
                  : BrandColors.primaryNeon.withOpacity(0.18),
            ),
          ),
          child: RotationTransition(
            turns: _spinAnim,
            child: Icon(
              widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: BrandColors.primaryNeon,
              size: 17,
            ),
          ),
        ),
      ),
    );
  }
}
