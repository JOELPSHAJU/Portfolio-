import 'package:flutter/material.dart';
import '../../../domain/entities/skill.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

class SkillsSection extends StatelessWidget {
  final List<Skill> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    final isTablet = size.width >= 600 && size.width < 900;

    // Group skills by category
    final Map<String, List<Skill>> groupedSkills = {};
    for (var skill in skills) {
      if (!groupedSkills.containsKey(skill.category)) {
        groupedSkills[skill.category] = [];
      }
      groupedSkills[skill.category]!.add(skill);
    }

    final List<Map<String, dynamic>> categoriesMeta = [
      {
        'name': 'Languages',
        'icon': Icons.terminal_rounded,
        'color': BrandColors.orangeFlame, // Sunset Orange
        'skills': groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('lang'), orElse: () => '') != ''
            ? groupedSkills[groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('lang'))]
            : <Skill>[],
      },
      {
        'name': 'Mobile Platforms',
        'icon': Icons.phone_iphone_rounded,
        'color': BrandColors.errorRed, // Neon Crimson
        'skills': groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('mobile'), orElse: () => '') != ''
            ? groupedSkills[groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('mobile'))]
            : <Skill>[],
      },
      {
        'name': 'Architecture',
        'icon': Icons.layers_rounded,
        'color': BrandColors.orangeNeon, // Deep Amber
        'skills': groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('arch'), orElse: () => '') != ''
            ? groupedSkills[groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('arch'))]
            : <Skill>[],
      },
      {
        'name': 'State Flow',
        'icon': Icons.schema_rounded,
        'color': BrandColors.errorDark, // Rose Crimson
        'skills': groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('state'), orElse: () => '') != ''
            ? groupedSkills[groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('state'))]
            : <Skill>[],
      },
      {
        'name': 'APIs & Sync',
        'icon': Icons.lan_rounded,
        'color': BrandColors.orangeBright, // Light Orange
        'skills': groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('api'), orElse: () => '') != ''
            ? groupedSkills[groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('api'))]
            : <Skill>[],
      },
      {
        'name': 'DevOps & Tooling',
        'icon': Icons.build_circle_rounded,
        'color': BrandColors.orangeAccent, // Amber Yellow
        'skills': groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('tool'), orElse: () => '') != ''
            ? groupedSkills[groupedSkills.keys.firstWhere((k) => k.toLowerCase().contains('tool'))]
            : <Skill>[],
      },
    ];

    int gridColumns = 1;
    if (isDesktop) {
      gridColumns = 3;
    } else if (isTablet) {
      gridColumns = 2;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40.0 : 20.0,
        vertical: 30.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            direction: 25.0,
            child: _buildSectionHeader('MY TOOLKIT', 'Technical Capabilities'),
          ),
          const SizedBox(height: 36),

          // Desktop/Tablet: Wrap grid — cards self-size to their content
          gridColumns > 1
              ? Builder(builder: (context) {
                  final spacing = 20.0;
                  final totalPadding = isDesktop ? 80.0 : 40.0;
                  final cardWidth =
                      (size.width - totalPadding - spacing * (gridColumns - 1)) / gridColumns;
                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: List.generate(categoriesMeta.length, (index) {
                      final cat = categoriesMeta[index];
                      return SizedBox(
                        width: cardWidth,
                        child: FadeInSlide(
                          delay: Duration(milliseconds: 150 + (index * 50)),
                          direction: 20.0,
                          child: _CategoryCard(cat: cat),
                        ),
                      );
                    }),
                  );
                })
              : Column(
                  children: List.generate(categoriesMeta.length, (index) {
                    final cat = categoriesMeta[index];
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: index < categoriesMeta.length - 1 ? 16 : 0),
                      child: FadeInSlide(
                        delay: Duration(milliseconds: 100 + (index * 50)),
                        direction: 15.0,
                        child: _CategoryCard(cat: cat),
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
      ],
    );
  }
}

class _CategoryCard extends StatefulWidget {
  final Map<String, dynamic> cat;

  const _CategoryCard({required this.cat});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final List<Skill> list = List<Skill>.from(widget.cat['skills']);
    final Color color = widget.cat['color'];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -6, 0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: BrandColors.darkSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? color.withOpacity(0.4) : BrandColors.warmMid.withOpacity(0.70),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered ? color.withOpacity(0.12) : Colors.transparent,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.cat['name'].toString().toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: BrandColors.textPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                Icon(
                  widget.cat['icon'],
                  color: color,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 2.0,
              width: _isHovered ? 60 : 40,
              color: color,
            ),
            const SizedBox(height: 20),
            // Skill rows — plain Column, no Expanded needed
            Column(
              children: List.generate(
                list.length > 5 ? 5 : list.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      bottom: index < (list.length > 5 ? 5 : list.length) - 1
                          ? 12
                          : 0),
                  child: _SkillGaugeRow(
                    skill: list[index],
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillGaugeRow extends StatefulWidget {
  final Skill skill;
  final Color color;

  const _SkillGaugeRow({
    required this.skill,
    required this.color,
  });

  @override
  State<_SkillGaugeRow> createState() => _SkillGaugeRowState();
}

class _SkillGaugeRowState extends State<_SkillGaugeRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Determine mock value based on skill name length to vary gauges cleanly
    final double mockValue = 75.0 + (widget.skill.name.length % 5) * 5.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: _isHovered ? widget.color.withOpacity(0.04) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Skill name
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: _isHovered ? Colors.white : BrandColors.warmBrown,
              ),
            ),
            // Progress gauge track
            Row(
              children: [
                Container(
                  width: 50,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: BrandColors.warmMid.withOpacity(0.70),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: mockValue / 100,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: _isHovered
                                ? [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.5),
                                      blurRadius: 4,
                                      spreadRadius: 0.5,
                                    )
                                  ]
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${mockValue.toInt()}%',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: _isHovered ? widget.color : BrandColors.warmGold.withOpacity(0.30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
