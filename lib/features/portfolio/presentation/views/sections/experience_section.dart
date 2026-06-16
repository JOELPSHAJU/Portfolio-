import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../domain/entities/experience.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

// ─── Mathematical Clipper: Angled Corners ────────────────────────────────────

class _AngledClipper extends CustomClipper<Path> {
  final double cutSize;
  _AngledClipper({this.cutSize = 30.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    // Top-left
    path.moveTo(0, 0);
    // Top-right (cut)
    path.lineTo(size.width - cutSize, 0);
    path.lineTo(size.width, cutSize);
    // Bottom-right
    path.lineTo(size.width, size.height);
    // Bottom-left (cut)
    path.lineTo(cutSize, size.height);
    path.lineTo(0, size.height - cutSize);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_AngledClipper old) => old.cutSize != cutSize;
}

// ─── Angled Border Painter ───────────────────────────────────────────────────

class _AngledBorderPainter extends CustomPainter {
  final Color color;
  final double cutSize;
  _AngledBorderPainter({required this.color, required this.cutSize});

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
    
    // Draw accents on the cuts
    final accentPaint = Paint()
      ..color = color.withOpacity(1.0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
      
    final topRightCut = Path()
      ..moveTo(size.width - cutSize, 0)
      ..lineTo(size.width, cutSize);
      
    final bottomLeftCut = Path()
      ..moveTo(cutSize, size.height)
      ..lineTo(0, size.height - cutSize);

    canvas.drawPath(path, paint);
    canvas.drawPath(topRightCut, accentPaint);
    canvas.drawPath(bottomLeftCut, accentPaint);
  }

  @override
  bool shouldRepaint(_AngledBorderPainter old) => old.color != color || old.cutSize != cutSize;
}

// ─── Hexagonal & Geometric Painters ──────────────────────────────────────────

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
      // Flat-top hexagon
      final angle = i * 60 * math.pi / 180;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HexPainter old) => 
    old.color != color || old.strokeWidth != strokeWidth || old.isFilled != isFilled;
}

class _GeoPatternPainter extends CustomPainter {
  final Color color;
  _GeoPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    const spacing = 18.0;
    const r = 1.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), r, paint);
      }
    }
    
    // Decorative pentagon watermark
    final pentaPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    _drawPolygon(canvas, pentaPaint, Offset(size.width - 35, 60), 90, 5);
    _drawPolygon(canvas, pentaPaint, Offset(size.width + 20, 150), 60, 5);
  }

  void _drawPolygon(Canvas canvas, Paint paint, Offset center, double r, int sides) {
    final path = Path();
    for (var i = 0; i < sides; i++) {
      final angle = (i * 360 / sides - 90) * math.pi / 180;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_GeoPatternPainter old) => old.color != color;
}

// ─── Experience Section ──────────────────────────────────────────────────────

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

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
          // Section Header
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            direction: 25.0,
            child: _buildSectionHeader(
              'CAREER PATH',
              'Professional Experience',
            ),
          ),
          const SizedBox(height: 32),

          // Timeline layout
          if (experiences.isEmpty)
            Center(
              child: Text(
                'No experience data found.',
                style: TextStyle(color: context.palette.warmBrown),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                final exp = experiences[index];
                return FadeInSlide(
                  delay: Duration(milliseconds: 200 + (index * 150)),
                  direction: 30.0,
                  child: _buildTimelineItem(context, exp, index, isDesktop),
                );
              },
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

  Widget _buildTimelineItem(
    BuildContext context,
    Experience exp,
    int index,
    bool isDesktop,
  ) {
    final accentColor = index == 0 ? BrandColors.primaryNeon : BrandColors.secondaryNeon;
    final double cutSize = isDesktop ? 55.0 : 35.0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Mathematical Timeline node ──
          Column(
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: CustomPaint(
                  painter: _HexPainter(
                    index == 0 ? BrandColors.primaryNeon : BrandColors.glassBorder,
                    strokeWidth: 2.5,
                    isFilled: index == 0,
                  ),
                  child: index == 0
                      ? Center(
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accentColor.withOpacity(0.5),
                        BrandColors.glassBorder.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),

          // ── Geometric Card ──
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ClipPath(
                clipper: _AngledClipper(cutSize: cutSize),
                child: CustomPaint(
                  foregroundPainter: _AngledBorderPainter(
                    color: accentColor.withOpacity(0.4),
                    cutSize: cutSize,
                  ),
                  child: Container(
                    color: BrandColors.darkCard,
                    child: Stack(
                      children: [
                        // Background Pattern
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _GeoPatternPainter(accentColor.withOpacity(0.04)),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Angled Duration Badge
                                  ClipPath(
                                    clipper: _AngledClipper(cutSize: 8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      color: accentColor.withOpacity(0.12),
                                      child: Text(
                                        exp.duration,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: accentColor,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.share_location_rounded,
                                        color: accentColor,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        exp.location,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: accentColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Title
                              Text(
                                exp.role,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: context.palette.textPrimary,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Container(
                                    width: 3,
                                    height: 14,
                                    decoration: BoxDecoration(color: accentColor),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    exp.company,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: accentColor,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // Points
                              Column(
                                children: exp.points
                                    .map((pt) => _buildAccomplishmentPoint(pt, context.palette, accentColor))
                                    .toList(),
                              ),
                              const SizedBox(height: 24),

                              // Tech Stack Line
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      accentColor.withOpacity(0.3),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'SYSTEMS & ARCHITECTURE',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: accentColor.withOpacity(0.8),
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: exp.technologies
                                    .map((tech) => _buildTechTag(tech, accentColor))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccomplishmentPoint(String point, AppPalette pal, Color accentColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 12.0),
            child: SizedBox(
              width: 8,
              height: 8,
              child: CustomPaint(
                painter: _HexPainter(accentColor, isFilled: true),
              ),
            ),
          ),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 13.5,
                color: pal.warmBrown,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechTag(String name, Color accentColor) {
    return ClipPath(
      clipper: _AngledClipper(cutSize: 12.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: BrandColors.glassBorder.withOpacity(0.08),
          border: Border.all(color: accentColor.withOpacity(0.2)),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: accentColor,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
