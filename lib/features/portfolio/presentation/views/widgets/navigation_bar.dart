import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/theme_controller.dart';
import 'package:clean_riverpod_template/core/utils/fullscreen.dart';
import 'package:clean_riverpod_template/core/widgets/adaptive_logo.dart';

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
    final isDesktop = size.width >= 1150;
    final pal = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accent = isDark ? const Color(0xFF00E5FF) : const Color(0xFF0F172A);

    return Container(
      margin: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.05),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? accent.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            spreadRadius: -5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            color: isDark
                ? const Color(0xFF0B0F19).withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.6),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ── Logo / Branding ─────────────────────────────────
                GestureDetector(
                  onTap: () => onSectionSelected('home'),
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AdaptiveLogo(
                      height: 36,
                      floatingInDarkMode: true,
                    ),
                  ),
                ),

                // ── Desktop Nav ─────────────────────────────────────
                if (isDesktop)
                  Row(
                    children: [
                      _NavLink(
                        'HOME',
                        'home',
                        activeSection,
                        onSectionSelected,
                        pal,
                      ),
                      _NavLink(
                        'ABOUT',
                        'about',
                        activeSection,
                        onSectionSelected,
                        pal,
                      ),
                      _NavLink(
                        'EXPERIENCE',
                        'experience',
                        activeSection,
                        onSectionSelected,
                        pal,
                      ),
                      _NavLink(
                        'SKILLS',
                        'skills',
                        activeSection,
                        onSectionSelected,
                        pal,
                      ),
                      _NavLink(
                        'PROJECTS',
                        'projects',
                        activeSection,
                        onSectionSelected,
                        pal,
                      ),
                      _NavLink(
                        'CONTACT',
                        'contact',
                        activeSection,
                        onSectionSelected,
                        pal,
                      ),
                      const SizedBox(width: 24),
                      const _FullscreenToggle(),
                      const SizedBox(width: 10),
                      _ThemeToggle(isDark: isDark, ref: ref),
                      const SizedBox(width: 16),
                      _HireMeButton(onTap: () => onSectionSelected('contact')),
                    ],
                  )
                else
                  Row(
                    children: [
                      const _FullscreenToggle(),
                      const SizedBox(width: 10),
                      _ThemeToggle(isDark: isDark, ref: ref),
                      const SizedBox(width: 10),
                      // Drawer toggle button with correct descendant context
                      Builder(
                        builder: (context) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => Scaffold.of(context).openEndDrawer(),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                                ),
                                child: Icon(
                                  Icons.menu_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 18,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Nav Link (Holographic Pill) ───────────────────────────────────────────────
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final accentColor = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF0F172A);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.sectionId),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: _hovered
                ? (isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.02))
                : Colors.transparent,
          ),
          child: Text(
            widget.title,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive
                  ? accentColor
                  : (isDark
                        ? Colors.white.withValues(alpha: 0.7)
                        : Colors.black.withValues(alpha: 0.7)),
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Hire Me Button (Liquid Gradient Pill) ─────────────────────────────────────
class _HireMeButton extends StatefulWidget {
  final VoidCallback onTap;
  const _HireMeButton({required this.onTap});

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF00E5FF), const Color(0xFF007AFF)]
                  : [const Color(0xFF0F172A), const Color(0xFF334155)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: (isDark ? const Color(0xFF00E5FF) : Colors.black)
                          .withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Text(
                'Let\'s Talk',
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                transform: Matrix4.translationValues(
                  _hovered ? 4.0 : 0.0,
                  0.0,
                  0.0,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Theme Toggle Button (Frosted Circle) ──────────────────────────────────────
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
    _spinAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _spin, curve: Curves.easeOutBack));
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

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
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? primaryColor.withValues(alpha: 0.12)
                : primaryColor.withValues(alpha: 0.05),
          ),
          child: RotationTransition(
            turns: _spinAnim,
            child: Icon(
              widget.isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
              color: primaryColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Fullscreen Toggle Button (Frosted Circle) ─────────────────────────────────
class _FullscreenToggle extends StatefulWidget {
  const _FullscreenToggle();

  @override
  State<_FullscreenToggle> createState() => _FullscreenToggleState();
}

class _FullscreenToggleState extends State<_FullscreenToggle> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          toggleFullscreen();
          setState(() {});
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _hovered
                ? primaryColor.withValues(alpha: 0.12)
                : primaryColor.withValues(alpha: 0.05),
          ),
          child: Icon(Icons.fullscreen_rounded, color: primaryColor, size: 18),
        ),
      ),
    );
  }
}
