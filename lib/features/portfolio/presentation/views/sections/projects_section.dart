import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../domain/entities/project.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';
import 'package:clean_riverpod_template/core/widgets/hover_animated_text.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsSection extends StatefulWidget {
  final List<Project> projects;
  const ProjectsSection({super.key, required this.projects});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  static const _projectMeta = {
    'kahramaa': {
      'icon': Icons.water_drop_rounded,
      'file': 'kahramaa.dart',
      'previewAssets': [
        {
          'label': 'Mobile Client',
          'asset': 'assets/kahramaa.png',
          'type': 'mobile',
        },
      ],
    },
    'khadoom': {
      'icon': Icons.badge_rounded,
      'file': 'khadoom.dart',
      'previewAssets': [
        {'label': 'Web Portal', 'asset': 'assets/khadoom.png', 'type': 'web'},
        {
          'label': 'Mobile Client',
          'asset': 'assets/khadoom_mobile.png',
          'type': 'mobile',
        },
      ],
    },
    'qsw': {
      'icon': Icons.supervised_user_circle_rounded,
      'file': 'qsw_mobile.dart',
      'previewAssets': <Map<String, String>>[],
    },
    'qatar_museums': {
      'icon': Icons.museum_rounded,
      'file': 'qatar_museums.dart',
      'previewAssets': [
        {
          'label': 'Web Portal',
          'asset': 'assets/qatar_museum_web.png',
          'type': 'web',
        },
        {
          'label': 'Mobile Client',
          'asset': 'assets/qatar_museum.png',
          'type': 'mobile',
        },
      ],
    },
  };

  static const _defaultMeta = {
    'icon': Icons.insert_drive_file_rounded,
    'file': 'unknown_project.dart',
    'previewAssets': <Map<String, String>>[],
  };

  Map<String, dynamic> _meta(String id) =>
      (_projectMeta[id] ?? _defaultMeta).cast<String, dynamic>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1024;
    final isTablet = width >= 768 && width < 1024;
    final sidePadding = isDesktop ? width * 0.08 : (isTablet ? 40.0 : 24.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pal = context.palette;

    if (widget.projects.isEmpty) {
      return Container(
        color: pal.surface,
        padding: EdgeInsets.symmetric(horizontal: sidePadding, vertical: 100),
        child: Center(
          child: Text(
            'No projects found.',
            style: GoogleFonts.outfit(
              color: pal.textPrimary.withValues(alpha: 0.5),
            ),
          ),
        ),
      );
    }

    return Container(
      color: pal.surface,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Kinetic Typography
          Positioned(
            top: 40,
            left: 10,
            child: Text(
              'CASE.STUDIES',
              style: GoogleFonts.anton(
                fontSize: isDesktop ? 220 : 120,
                color: pal.textPrimary.withValues(alpha: 0.02),
                letterSpacing: -4,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sidePadding,
              vertical: 140.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInSlide(
                  delay: const Duration(milliseconds: 100),
                  direction: 15.0,
                  child: _buildEditorialHeader(pal),
                ),
                const SizedBox(height: 80),

                // Manifesto Project Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossCount = constraints.maxWidth < 768 ? 1 : 2;
                    final spacing = 24.0;
                    final cardWidth =
                        (constraints.maxWidth - (crossCount - 1) * spacing) /
                        crossCount;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: widget.projects.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final project = entry.value;
                        final meta = _meta(project.id);
                        return FadeInSlide(
                          delay: Duration(milliseconds: 150 + (idx * 50)),
                          direction: 20,
                          child: SizedBox(
                            width: cardWidth,
                            height: 330,
                            child: _ProjectManifestoCard(
                              project: project,
                              meta: meta,
                              pal: pal,
                              isDark: isDark,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorialHeader(AppPalette pal) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 2,
          color: BrandColors.warmBrown,
          margin: const EdgeInsets.only(top: 10),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '04 / PROJECT_SYS',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.warmBrown,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              HoverAnimatedText(
                text: 'ARCHITECTING ENTERPRISE SCALE\nDIGITAL REALITIES.',
                style: GoogleFonts.anton(
                  fontSize: 48,
                  height: 1.1,
                  color: pal.textPrimary,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Project Manifesto Card Widget ─────────────────────────────────────────────
class _ProjectManifestoCard extends StatefulWidget {
  final Project project;
  final Map<String, dynamic> meta;
  final AppPalette pal;
  final bool isDark;

  const _ProjectManifestoCard({
    required this.project,
    required this.meta,
    required this.pal,
    required this.isDark,
  });

  @override
  State<_ProjectManifestoCard> createState() => _ProjectManifestoCardState();
}

class _ProjectManifestoCardState extends State<_ProjectManifestoCard> {
  bool _hovered = false;

  Color _getAccent(String id) {
    switch (id) {
      case 'kahramaa':
        return const Color(0xFF007AFF);
      case 'khadoom':
        return const Color(0xFFFF9500);
      case 'qatar_museums':
        return const Color(0xFFAF52DE);
      case 'qsw':
        return const Color(0xFF34C759);
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final pal = widget.pal;
    final previews =
        (widget.meta['previewAssets'] as List?)
            ?.map((e) => Map<String, String>.from(e as Map))
            .toList() ??
        [];

    final hasImages = previews.isNotEmpty;
    final accent = _getAccent(p.id);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: hasImages ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: () {
          if (hasImages) {
            _MinimalLightbox.show(
              context,
              previews: previews,
              projectTitle: p.title,
            );
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _hovered
                ? pal.card.withValues(alpha: 0.6)
                : pal.card.withValues(alpha: 0.3),
            border: Border(
              left: BorderSide(
                color: _hovered ? accent : BrandColors.warmBrown,
                width: 4,
              ),
              top: BorderSide(
                color: pal.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
              right: BorderSide(
                color: pal.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
              bottom: BorderSide(
                color: pal.textPrimary.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Top Data row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '// CLIENT: ${p.clientOrOrg.toUpperCase()}',
                      style: GoogleFonts.spaceMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: pal.textPrimary.withValues(alpha: 0.5),
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Icon(
                    widget.meta['icon'] as IconData? ??
                        Icons.folder_open_rounded,
                    color: _hovered
                        ? accent
                        : pal.textPrimary.withValues(alpha: 0.4),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Massive Title
              HoverAnimatedText(
                text: p.title.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.anton(
                  fontSize: 28,
                  height: 1.1,
                  color: pal.textPrimary,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Expanded(
                child: Text(
                  p.description,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    height: 1.5,
                    color: pal.textPrimary.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Tech Stack Header
              Text(
                '// ARCHITECTURE',
                style: GoogleFonts.spaceMono(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: pal.textPrimary.withValues(alpha: 0.4),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              // Tech Stack & Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: p.technologies.take(3).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: pal.textPrimary.withValues(alpha: 0.03),
                            border: Border.all(
                              color: pal.textPrimary.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Text(
                            tech.toUpperCase(),
                            style: GoogleFonts.spaceMono(
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold,
                              color: pal.textPrimary.withValues(alpha: 0.7),
                              letterSpacing: 1,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  if (hasImages) ...[
                    const SizedBox(width: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'VIEW BLUEPRINTS',
                          style: GoogleFonts.spaceMono(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _hovered
                                ? accent
                                : pal.textPrimary.withValues(alpha: 0.4),
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: _hovered
                              ? accent
                              : pal.textPrimary.withValues(alpha: 0.4),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Minimal Fullscreen Black Lightbox Overlay ──────────────────────────────
class _MinimalLightbox extends StatefulWidget {
  final List<Map<String, String>> previews;
  final String projectTitle;

  const _MinimalLightbox({required this.previews, required this.projectTitle});

  static void show(
    BuildContext context, {
    required List<Map<String, String>> previews,
    required String projectTitle,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss View',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) =>
          _MinimalLightbox(previews: previews, projectTitle: projectTitle),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return AnimatedBuilder(
          animation: curvedAnimation,
          builder: (context, _) {
            final progress = curvedAnimation.value;
            return Stack(
              children: [
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 12.0 * progress,
                        sigmaY: 12.0 * progress,
                      ),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.85 * progress),
                      ),
                    ),
                  ),
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  State<_MinimalLightbox> createState() => _MinimalLightboxState();
}

class _MinimalLightboxState extends State<_MinimalLightbox> {
  int _activeTabIdx = 0;

  @override
  Widget build(BuildContext context) {
    final previews = widget.previews;

    // Filter screens to match tabs: "web" or "mobile"
    final webScreens = previews.where((e) => e['type'] == 'web').toList();
    final mobileScreens = previews.where((e) => e['type'] == 'mobile').toList();

    final hasWeb = webScreens.isNotEmpty;
    final hasMobile = mobileScreens.isNotEmpty;

    // Setup active viewport list based on tab
    List<Map<String, String>> activeScreens = [];
    if (_activeTabIdx == 0) {
      activeScreens = hasWeb ? webScreens : mobileScreens;
    } else {
      activeScreens = mobileScreens;
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  // Top control bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tabs for Web vs Mobile
                      Expanded(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 12,
                          children: [
                            if (hasWeb)
                              _TabBtn(
                                label: 'WEB PREVIEW',
                                isActive: _activeTabIdx == 0,
                                onTap: () => setState(() => _activeTabIdx = 0),
                              ),
                            if (hasMobile)
                              _TabBtn(
                                label: 'MOBILE PREVIEW',
                                isActive: hasWeb
                                    ? _activeTabIdx == 1
                                    : _activeTabIdx == 0,
                                onTap: () => setState(
                                  () => _activeTabIdx = hasWeb ? 1 : 0,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Close button
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '✕ CLOSE',
                            style: GoogleFonts.spaceMono(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Image display viewport with futuristic switcher
                  Expanded(
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        switchInCurve: Curves.easeOutQuart,
                        switchOutCurve: Curves.easeInQuart,
                        layoutBuilder:
                            (
                              Widget? currentChild,
                              List<Widget> previousChildren,
                            ) {
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  ...previousChildren,
                                  if (currentChild != null) currentChild,
                                ],
                              );
                            },
                        transitionBuilder: (child, animation) {
                          final isEntering =
                              child.key ==
                              ValueKey('active_tab_$_activeTabIdx');

                          return AnimatedBuilder(
                            animation: animation,
                            child: child,
                            builder: (context, child) {
                              final progress = animation.value;

                              // entering: scales from 0.82 up to 1.0, tilts back and tilts forward
                              // exiting: scales down from 1.0 to 0.82, tilts back
                              final scale = isEntering
                                  ? 0.82 + (0.18 * progress)
                                  : 1.0 - (0.18 * (1.0 - progress));

                              final tilt = isEntering
                                  ? -0.15 * (1.0 - progress)
                                  : -0.15 * (1.0 - progress);

                              final opacity = progress.clamp(0.0, 1.0);

                              return Transform(
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001) // perspective
                                  ..rotateX(tilt)
                                  ..multiply(
                                    Matrix4.diagonal3Values(scale, scale, 1.0),
                                  ),
                                alignment: Alignment.center,
                                child: Opacity(opacity: opacity, child: child),
                              );
                            },
                          );
                        },
                        child: activeScreens.isEmpty
                            ? const Text(
                                'No screen available for this format.',
                                key: ValueKey('empty'),
                                style: TextStyle(color: Colors.white60),
                              )
                            : PageView.builder(
                                key: ValueKey('active_tab_$_activeTabIdx'),
                                itemCount: activeScreens.length,
                                itemBuilder: (context, idx) {
                                  return InteractiveViewer(
                                    maxScale: 3.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        activeScreens[idx]['asset']!,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabBtn extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabBtn({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_TabBtn> createState() => _TabBtnState();
}

class _TabBtnState extends State<_TabBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bool isWeb = widget.label.contains('WEB');
    final IconData icon = isWeb
        ? Icons.desktop_windows_rounded
        : Icons.phone_android_rounded;
    final accentColor = isWeb
        ? const Color(0xFF00E5FF)
        : const Color(0xFFFF2A5F);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutExpo,
          height: 44,
          padding: EdgeInsets.only(
            left: widget.isActive ? 20 : 16,
            right: widget.isActive ? 24 : 16,
          ),
          decoration: BoxDecoration(
            color: widget.isActive
                ? accentColor.withValues(alpha: 0.12)
                : (_hovered
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.transparent),
            border: Border(
              bottom: BorderSide(
                color: widget.isActive
                    ? accentColor
                    : (_hovered
                          ? Colors.white.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.1)),
                width: widget.isActive ? 3 : 1,
              ),
              left: BorderSide(
                color: widget.isActive
                    ? accentColor.withValues(alpha: 0.6)
                    : Colors.transparent,
                width: widget.isActive ? 1 : 0,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: widget.isActive ? accentColor : Colors.white54,
                shadows: widget.isActive
                    ? [Shadow(color: accentColor, blurRadius: 12)]
                    : null,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.spaceMono(
                  fontSize: 11.5,
                  fontWeight: widget.isActive
                      ? FontWeight.bold
                      : FontWeight.w500,
                  color: widget.isActive ? Colors.white : Colors.white54,
                  letterSpacing: 2.0,
                ),
              ),
              if (widget.isActive) ...[
                const SizedBox(width: 12),
                Row(
                  children: [
                    _buildDot(accentColor, 1.0),
                    const SizedBox(width: 4),
                    _buildDot(accentColor, 0.5),
                    const SizedBox(width: 4),
                    _buildDot(accentColor, 0.2),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(Color color, double opacity) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.rectangle,
      ),
    );
  }
}
