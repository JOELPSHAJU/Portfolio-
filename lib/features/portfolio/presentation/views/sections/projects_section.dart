import 'package:flutter/material.dart';
import '../../../domain/entities/project.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

class ProjectsSection extends StatelessWidget {
  final List<Project> projects;
  const ProjectsSection({super.key, required this.projects});

  // previewAssets: list of {label, asset} maps
  static const _projectMeta = {
    'kahramaa': {
      'icon': Icons.water_drop_rounded,
      'gradient': [Color(0xFF0EA5E9), Color(0xFF0C4A6E)],
      'accent': Color(0xFF38BDF8),
      'previewAssets': [
        {'label': 'Mobile App', 'asset': 'assets/kahramaa.png'},
      ],
    },
    'khadoom': {
      'icon': Icons.badge_rounded,
      'gradient': [Color(0xFF10B981), Color(0xFF064E3B)],
      'accent': Color(0xFF34D399),
      'previewAssets': [
        {'label': 'Web App', 'asset': 'assets/khadoom.png'},
        {'label': 'Mobile App', 'asset': 'assets/khadoom_mobile.png'},
      ],
    },
    'qsw': {
      'icon': Icons.supervised_user_circle_rounded,
      'gradient': [Color(0xFF8B5CF6), Color(0xFF3B0764)],
      'accent': Color(0xFFA78BFA),
    },
    'qatar_museums': {
      'icon': Icons.museum_rounded,
      'gradient': [Color(0xFFF59E0B), Color(0xFF78350F)],
      'accent': Color(0xFFFBBF24),
      'previewAssets': [
        {'label': 'Web App', 'asset': 'assets/qatar_museum_web.png'},
        {'label': 'Mobile App', 'asset': 'assets/qatar_museum.png'},
      ],
    },
  };

  static const _defaultMeta = {
    'icon': Icons.bolt_rounded,
    'gradient': [Color(0xFF06B6D4), Color(0xFF0C4A6E)],
    'accent': Color(0xFF22D3EE),
  };

  Map<String, dynamic> _meta(String id) =>
      (_projectMeta[id] ?? _defaultMeta).cast<String, dynamic>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40.0 : 20.0,
        vertical: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            direction: 25.0,
            child: _buildSectionHeader('MY PORTFOLIO', 'Featured Projects'),
          ),
          const SizedBox(height: 40),
          if (projects.isEmpty)
            const Center(
              child: Text(
                'No projects found.',
                style: const TextStyle(color: Color(0xFF6B6B6B)),
              ),
            )
          else
            Column(
              children: List.generate(projects.length, (index) {
                final project = projects[index];
                final meta = _meta(project.id);
                final isEven = index.isEven;
                // Cast safely — may be null for projects without previews
                final rawList = (meta['previewAssets'] as List?)
                    ?.map((e) => Map<String, String>.from(e as Map))
                    .toList();

                return FadeInSlide(
                  delay: Duration(milliseconds: 180 + (index * 100)),
                  direction: 28.0,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: index < projects.length - 1 ? 20 : 0,
                    ),
                    child: _CaseStudyBand(
                      project: project,
                      meta: meta,
                      index: index,
                      flipLayout: !isEven && isDesktop,
                      isDesktop: isDesktop,
                      previewAssets: rawList,
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String overtitle, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          overtitle,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: BrandColors.secondaryNeon,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 8),
        GradientText(
          title,
          gradient: BrandColors.primaryGradient,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: BrandColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

// ─── Case Study Band ──────────────────────
class _CaseStudyBand extends StatefulWidget {
  final Project project;
  final Map<String, dynamic> meta;
  final int index;
  final bool flipLayout;
  final bool isDesktop;
  final List<Map<String, String>>? previewAssets;

  const _CaseStudyBand({
    required this.project,
    required this.meta,
    required this.index,
    required this.flipLayout,
    required this.isDesktop,
    this.previewAssets,
  });

  @override
  State<_CaseStudyBand> createState() => _CaseStudyBandState();
}

class _CaseStudyBandState extends State<_CaseStudyBand> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.meta['accent'] as Color;
    final gradColors = widget.meta['gradient'] as List<Color>;
    final icon = widget.meta['icon'] as IconData;
    final num = (widget.index + 1).toString().padLeft(2, '0');
    final hasPreview = widget.previewAssets != null;

    return MouseRegion(
      cursor: hasPreview ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: hasPreview
            ? () => _ProjectLightbox.show(
                context,
                previews: widget.previewAssets!,
                title: widget.project.title,
                accent: accent,
              )
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _hovered
                  ? accent.withOpacity(0.40)
                  : const Color(0xFFE8E0D8).withOpacity(0.50),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? accent.withOpacity(0.10)
                    : const Color(0xFF141010).withOpacity(0.06),
                blurRadius: _hovered ? 40 : 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Stack(
              children: [
                Container(color: const Color(0xFFFAF7F4)),
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 280),
                    opacity: _hovered ? 0.7 : 0.25,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            gradColors[0].withOpacity(0.15),
                            gradColors[1].withOpacity(0.30),
                          ],
                          begin: widget.flipLayout
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          end: widget.flipLayout
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ),
                // Watermark number
                Positioned(
                  right: widget.flipLayout ? null : -10,
                  left: widget.flipLayout ? -10 : null,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 280),
                      opacity: _hovered ? 0.07 : 0.035,
                      child: Text(
                        num,
                        style: TextStyle(
                          fontSize: 180,
                          fontWeight: FontWeight.w900,
                          color: accent,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                // "View Screens" hover badge
                if (hasPreview)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _hovered ? 1.0 : 0.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: accent.withOpacity(0.35),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                              color: accent,
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.previewAssets!.length > 1
                                  ? 'VIEW ${widget.previewAssets!.length} SCREENS'
                                  : 'VIEW SCREENS',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                                color: accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: widget.isDesktop
                      ? _desktopContent(accent, gradColors, icon)
                      : _mobileContent(accent, icon),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopContent(Color accent, List<Color> gradColors, IconData icon) {
    final iconBlock = _IconBlock(
      icon: icon,
      accent: accent,
      gradColors: gradColors,
      hovered: _hovered,
    );
    final contentBlock = _ContentBlock(
      project: widget.project,
      accent: accent,
      hovered: _hovered,
    );
    return widget.flipLayout
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: contentBlock),
              const SizedBox(width: 40),
              iconBlock,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconBlock,
              const SizedBox(width: 40),
              Expanded(flex: 3, child: contentBlock),
            ],
          );
  }

  Widget _mobileContent(Color accent, IconData icon) {
    final gradColors = widget.meta['gradient'] as List<Color>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: accent.withOpacity(0.3), blurRadius: 16),
                ],
              ),
              child: Icon(icon, color: const Color(0xFF1A1A1A), size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.type.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      color: accent,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                      letterSpacing: -0.3,
                    ),
                  ),
                  Text(
                    widget.project.clientOrOrg,
                    style: TextStyle(
                      fontSize: 12,
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          widget.project.description,
          style: TextStyle(
            fontSize: 13,
            color: const Color(0xFF6B6B6B).withOpacity(0.90),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: widget.project.technologies
              .take(5)
              .map((t) => _TechChip(label: t, accent: accent))
              .toList(),
        ),
      ],
    );
  }
}

// ─── Icon Block ───────────────────────────
class _IconBlock extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final List<Color> gradColors;
  final bool hovered;

  const _IconBlock({
    required this.icon,
    required this.accent,
    required this.gradColors,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(hovered ? 0.45 : 0.20),
            blurRadius: hovered ? 32 : 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, color: const Color(0xFF1A1A1A), size: 44),
    );
  }
}

// ─── Content Block ────────────────────────
class _ContentBlock extends StatelessWidget {
  final Project project;
  final Color accent;
  final bool hovered;

  const _ContentBlock({
    required this.project,
    required this.accent,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: accent.withOpacity(0.25), width: 1),
          ),
          child: Text(
            project.type.toUpperCase(),
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: accent,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          project.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              width: 3,
              height: 14,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              project.clientOrOrg,
              style: TextStyle(
                fontSize: 13,
                color: accent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF1A1A1A).withOpacity(0.08), Colors.transparent],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          project.description,
          style: TextStyle(
            fontSize: 13.5,
            color: const Color(0xFF6B6B6B).withOpacity(0.90),
            height: 1.65,
          ),
        ),
        const SizedBox(height: 16),
        ...project.points
            .take(2)
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 10),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        p,
                        style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xFF6B6B6B).withOpacity(0.90),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.technologies
              .take(5)
              .map((t) => _TechChip(label: t, accent: accent))
              .toList(),
        ),
      ],
    );
  }
}

// ─── Tech Chip ────────────────────────────
class _TechChip extends StatelessWidget {
  final String label;
  final Color accent;

  const _TechChip({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: accent.withOpacity(0.2), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1A1A1A).withOpacity(0.90),
        ),
      ),
    );
  }
}

// ─── Project Lightbox ─────────────────────
// Tabbed full-screen overlay — supports
// multiple screenshots (e.g. Web / Mobile)
// ─────────────────────────────────────────
class _ProjectLightbox extends StatefulWidget {
  final List<Map<String, String>> previews;
  final String title;
  final Color accent;

  const _ProjectLightbox({
    required this.previews,
    required this.title,
    required this.accent,
  });

  static Future<void> show(
    BuildContext context, {
    required List<Map<String, String>> previews,
    required String title,
    required Color accent,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close preview',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (_, __, ___) =>
          _ProjectLightbox(previews: previews, title: title, accent: accent),
      transitionBuilder: (_, anim, __, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 0.94,
            end: 1.0,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
      ),
    );
  }

  @override
  State<_ProjectLightbox> createState() => _ProjectLightboxState();
}

class _ProjectLightboxState extends State<_ProjectLightbox> {
  int _tab = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _switchTab(int i) {
    setState(() => _tab = i);
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final multiTab = widget.previews.length > 1;

    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Backdrop
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: const Color(0xFF4A3728).withOpacity(0.45)),
          ),

          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.92,
                maxHeight: size.height * 0.92,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 22,
                          decoration: BoxDecoration(
                            color: widget.accent,
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: widget.accent.withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const Spacer(),
                        _LightboxCloseButton(
                          accent: widget.accent,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),

                  // Tab bar
                  if (multiTab)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(widget.previews.length, (i) {
                          final isSelected = _tab == i;
                          final label =
                              widget.previews[i]['label'] ?? 'Screen ${i + 1}';
                          return GestureDetector(
                            onTap: () => _switchTab(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(
                                right: i < widget.previews.length - 1 ? 8 : 0,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? widget.accent.withOpacity(0.15)
                                    : const Color(0xFFE8E0D8).withOpacity(0.40),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: isSelected
                                      ? widget.accent.withOpacity(0.50)
                                      : const Color(0xFF1A1A1A).withOpacity(0.08),
                                  width: 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: widget.accent.withOpacity(
                                            0.15,
                                          ),
                                          blurRadius: 14,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    i == 0
                                        ? Icons.computer_rounded
                                        : Icons.smartphone_rounded,
                                    color: isSelected
                                        ? widget.accent
                                        : const Color(0xFF6B6B6B).withOpacity(0.70),
                                    size: 13,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.3,
                                      color: isSelected
                                          ? widget.accent
                                          : const Color(0xFF6B6B6B).withOpacity(0.80),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                  // Image — PageView for smooth directional sliding
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(19),
                        child: PageView.builder(
                          controller: _pageController,
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (i) => setState(() => _tab = i),
                          itemCount: widget.previews.length,
                          itemBuilder: (_, i) => ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              widget.previews[i]['asset']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Hint
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Tap outside or press CLOSE to dismiss',
                      style: TextStyle(
                        fontSize: 11,
                        color: const Color(0xFF1A1A1A).withOpacity(0.25),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Lightbox Close Button ────────────────
class _LightboxCloseButton extends StatefulWidget {
  final Color accent;
  final VoidCallback onTap;

  const _LightboxCloseButton({required this.accent, required this.onTap});

  @override
  State<_LightboxCloseButton> createState() => _LightboxCloseButtonState();
}

class _LightboxCloseButtonState extends State<_LightboxCloseButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.accent.withOpacity(0.15)
                : const Color(0xFFE8E0D8).withOpacity(0.50),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? widget.accent.withOpacity(0.50)
                  : const Color(0xFF1A1A1A).withOpacity(0.10),
              width: 1,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.accent.withOpacity(0.20),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.close_rounded,
                color: _hovered
                    ? widget.accent
                    : const Color(0xFF6B6B6B).withOpacity(0.90),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                'CLOSE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: _hovered
                      ? widget.accent
                      : const Color(0xFF6B6B6B).withOpacity(0.90),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
