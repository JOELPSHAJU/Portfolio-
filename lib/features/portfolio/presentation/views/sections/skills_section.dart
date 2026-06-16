import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../domain/entities/skill.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

// ─── Mathematical Clippers & Painters ────────────────────────────────────────

class _AngledClipper extends CustomClipper<Path> {
  final double cutSize;
  _AngledClipper({this.cutSize = 30.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - cutSize, 0);
    path.lineTo(size.width, cutSize);
    path.lineTo(size.width, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_AngledClipper old) => old.cutSize != cutSize;
}

class _AngledBorderPainter extends CustomPainter {
  final Color color;
  final double cutSize;
  final bool isHovered;
  final Color accent;
  
  _AngledBorderPainter({required this.color, required this.cutSize, this.isHovered = false, required this.accent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - cutSize, 0);
    path.lineTo(size.width, cutSize);
    path.lineTo(size.width, size.height);
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();
    canvas.drawPath(path, paint);

    if (isHovered) {
      final accentPaint = Paint()
        ..color = accent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0;
        
      final topRightCut = Path()
        ..moveTo(size.width - cutSize, 0)
        ..lineTo(size.width, cutSize);
        
      final bottomLeftCut = Path()
        ..moveTo(cutSize, size.height)
        ..lineTo(0, size.height - cutSize);
        
      canvas.drawPath(topRightCut, accentPaint);
      canvas.drawPath(bottomLeftCut, accentPaint);
    }
  }

  @override
  bool shouldRepaint(_AngledBorderPainter old) => old.color != color || old.cutSize != cutSize || old.isHovered != isHovered;
}

class _HexPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final bool isFilled;
  
  _HexPainter(this.color, {this.strokeWidth = 2.0, this.isFilled = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy) - (isFilled ? 0 : strokeWidth / 2);
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = i * 60 * math.pi / 180;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HexPainter old) => old.color != color || old.strokeWidth != strokeWidth || old.isFilled != isFilled;
}

// ─────────────────────────────────────────────────────────────────────────────

class _Cat {
  final String number;
  final String name;
  final IconData icon;
  final Color accent;
  final List<Skill> skills;
  const _Cat({required this.number, required this.name, required this.icon, required this.accent, required this.skills});
}

// ─────────────────────────────────────────────────────────────────────────────

class SkillsSection extends StatefulWidget {
  final List<Skill> skills;
  const SkillsSection({super.key, required this.skills});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int? _open = 0; // which accordion is expanded

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    final Map<String, List<Skill>> g = {};
    for (final s in widget.skills) {
      g.putIfAbsent(s.category, () => []).add(s);
    }
    List<Skill> pick(String f) => g.entries
        .where((e) => e.key.toLowerCase().contains(f))
        .expand((e) => e.value)
        .toList();

    final cats = <_Cat>[
      _Cat(number: '01', name: 'Languages',   icon: Icons.terminal_rounded,     accent: BrandColors.primaryNeon,   skills: pick('lang')),
      _Cat(number: '02', name: 'Mobile',       icon: Icons.phone_iphone_rounded, accent: BrandColors.accentNeon,    skills: pick('mobile')),
      _Cat(number: '03', name: 'Architecture', icon: Icons.layers_rounded,       accent: BrandColors.secondaryNeon, skills: pick('arch')),
      _Cat(number: '04', name: 'State Flow',   icon: Icons.schema_rounded,       accent: BrandColors.warningNeon,   skills: pick('state')),
      _Cat(number: '05', name: 'APIs & Sync',  icon: Icons.lan_rounded,          accent: BrandColors.orangeFlame,   skills: pick('api')),
      _Cat(number: '06', name: 'DevOps',       icon: Icons.build_circle_rounded, accent: BrandColors.errorRed,      skills: pick('tool')),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40.0 : 20.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            direction: 25.0,
            child: _header(),
          ),
          const SizedBox(height: 40),

          // Accordion list
          ...List.generate(cats.length, (i) {
            return FadeInSlide(
              delay: Duration(milliseconds: 150 + i * 60),
              direction: 18.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _AccordionRow(
                  cat: cats[i],
                  isOpen: _open == i,
                  isDesktop: isDesktop,
                  onToggle: () => setState(() => _open = _open == i ? null : i),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _header() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MY TOOLKIT',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: BrandColors.secondaryNeon, letterSpacing: 2.0),
          ),
          const SizedBox(height: 8),
          GradientText(
            'Technical Capabilities',
            gradient: BrandColors.primaryGradient,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -0.5),
          ),
          const SizedBox(height: 8),
          Container(
            width: 50, height: 2.5,
            decoration: BoxDecoration(gradient: BrandColors.cyanGradient, borderRadius: BorderRadius.circular(2)),
          ),
        ],
      );
}

// ─── Accordion Row ────────────────────────────────────────────────────────────

class _AccordionRow extends StatefulWidget {
  final _Cat cat;
  final bool isOpen;
  final bool isDesktop;
  final VoidCallback onToggle;

  const _AccordionRow({required this.cat, required this.isOpen, required this.isDesktop, required this.onToggle});

  @override
  State<_AccordionRow> createState() => _AccordionRowState();
}

class _AccordionRowState extends State<_AccordionRow> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _expand;
  late Animation<double> _fade;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 320));
    _expand = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _fade   = CurvedAnimation(parent: _ctrl, curve: const Interval(0.2, 1.0, curve: Curves.easeOut));
    if (widget.isOpen) _ctrl.value = 1.0;
  }

  @override
  void didUpdateWidget(_AccordionRow old) {
    super.didUpdateWidget(old);
    widget.isOpen ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.cat;
    final isOpen = widget.isOpen;
    final double cutSize = widget.isDesktop ? 30.0 : 20.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipPath(
        clipper: _AngledClipper(cutSize: cutSize),
        child: CustomPaint(
          foregroundPainter: _AngledBorderPainter(
            color: isOpen
                ? c.accent.withOpacity(0.35)
                : _hovered
                    ? c.accent.withOpacity(0.18)
                    : BrandColors.glassBorder,
            cutSize: cutSize,
            isHovered: isOpen || _hovered,
            accent: c.accent,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: isOpen
                ? c.accent.withOpacity(0.04)
                : _hovered
                    ? BrandColors.darkCard.withOpacity(0.8)
                    : BrandColors.darkCard,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header row ──────────────────────────────────────────────
                GestureDetector(
                  onTap: widget.onToggle,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Row(
                      children: [
                        // Hexagon Number badge
                        SizedBox(
                          width: 44,
                          height: 44,
                          child: CustomPaint(
                            painter: _HexPainter(
                              isOpen ? c.accent : BrandColors.glassBorder,
                              strokeWidth: isOpen ? 2.0 : 1.2,
                              isFilled: isOpen,
                            ),
                            child: Center(
                              child: Text(
                                c.number,
                                style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w900,
                                  color: isOpen ? BrandColors.darkSurface : BrandColors.textMuted,
                                  fontFamily: 'monospace', letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),

                        // Icon
                        Icon(c.icon, color: isOpen ? c.accent : BrandColors.textMuted, size: 22),
                        const SizedBox(width: 14),

                        // Name
                        Text(
                          c.name,
                          style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700,
                            color: isOpen ? c.accent : BrandColors.textOnDark,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Spacer(),

                        // Skill count angled pill
                        if (widget.isDesktop)
                          ClipPath(
                            clipper: _AngledClipper(cutSize: 8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                              color: isOpen ? c.accent.withOpacity(0.15) : BrandColors.glassBorder.withOpacity(0.1),
                              child: Text(
                                '${c.skills.length} skills',
                                style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600,
                                  color: isOpen ? c.accent : BrandColors.textMuted,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 16),

                        // Chevron
                        AnimatedBuilder(
                          animation: _expand,
                          builder: (_, __) => Transform.rotate(
                            angle: _expand.value * 3.14159,
                            child: Icon(Icons.keyboard_arrow_down_rounded,
                              color: isOpen ? c.accent : BrandColors.textMuted, size: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Expandable body ──────────────────────────────────────────
                SizeTransition(
                  sizeFactor: _expand,
                  axisAlignment: -1,
                  child: FadeTransition(
                    opacity: _fade,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top divider
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          color: c.accent.withOpacity(0.18),
                        ),
                        const SizedBox(height: 20),

                        // Skill chips in a wrap
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: c.skills.isEmpty
                              ? const Text('No entries.', style: TextStyle(color: BrandColors.textMuted, fontSize: 13))
                              : _SkillWrap(skills: c.skills, accent: c.accent, isDesktop: widget.isDesktop),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Skill Wrap inside expanded body ─────────────────────────────────────────

class _SkillWrap extends StatelessWidget {
  final List<Skill> skills;
  final Color accent;
  final bool isDesktop;

  const _SkillWrap({required this.skills, required this.accent, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: skills.map((s) => _SkillPill(skill: s, accent: accent)).toList(),
    );
  }
}

class _SkillPill extends StatefulWidget {
  final Skill skill;
  final Color accent;
  const _SkillPill({required this.skill, required this.accent});

  @override
  State<_SkillPill> createState() => _SkillPillState();
}

class _SkillPillState extends State<_SkillPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: ClipPath(
        clipper: _AngledClipper(cutSize: 10.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          color: _hovered ? widget.accent.withOpacity(0.14) : BrandColors.darkSurface,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hexagon dot instead of circle
              SizedBox(
                width: 8,
                height: 8,
                child: CustomPaint(
                  painter: _HexPainter(
                    _hovered ? widget.accent : widget.accent.withOpacity(0.5),
                    isFilled: true,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                widget.skill.name,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: _hovered ? FontWeight.w700 : FontWeight.w600,
                  color: _hovered ? widget.accent : BrandColors.textOnDark,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
