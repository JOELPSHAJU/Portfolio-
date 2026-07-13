import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/experience.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';
import 'package:clean_riverpod_template/core/widgets/hover_animated_text.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experiences;

  const ExperienceSection({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    final isTablet = size.width >= 600 && size.width < 900;

    final sidePadding = isDesktop
        ? size.width * 0.08
        : (isTablet ? 40.0 : 24.0);
    final pal = context.palette;

    return Container(
      color: pal.surface,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Matrix / Kinetic Typography
          Positioned(
            top: 40,
            left: 10,
            child: Text(
              'CAREER.SYS',
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
              vertical: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                FadeInSlide(
                  delay: const Duration(milliseconds: 100),
                  direction: 25.0,
                  child: _buildEditorialHeader(pal),
                ),

                const SizedBox(height: 60),

                if (experiences.isEmpty)
                  Center(
                    child: Text(
                      '// NO_DATA_FOUND',
                      style: GoogleFonts.spaceMono(
                        color: BrandColors.warmBrown,
                        fontWeight: FontWeight.bold,
                      ),
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
                        child: _ExperienceEditorialCard(
                          exp: exp,
                          index: index,
                          isDesktop: isDesktop,
                        ),
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
                '02 / EXPERIENCE_SYS',
                style: GoogleFonts.spaceMono(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.warmBrown,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              HoverAnimatedText(
                text: 'BUILDING ENTERPRISE\nDIGITAL ECOSYSTEMS.',
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

class _ExperienceEditorialCard extends StatefulWidget {
  final Experience exp;
  final int index;
  final bool isDesktop;

  const _ExperienceEditorialCard({
    required this.exp,
    required this.index,
    required this.isDesktop,
  });

  @override
  State<_ExperienceEditorialCard> createState() =>
      _ExperienceEditorialCardState();
}

class _ExperienceEditorialCardState extends State<_ExperienceEditorialCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final pal = context.palette;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAppStation = widget.exp.company.toLowerCase().contains(
      'appstation',
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 32),
        padding: EdgeInsets.all(widget.isDesktop ? 40 : 24),
        decoration: BoxDecoration(
          color: _hovered
              ? pal.card.withValues(alpha: 0.6)
              : pal.card.withValues(alpha: 0.3),
          border: Border(
            left: BorderSide(
              color: _hovered ? pal.textPrimary : BrandColors.warmBrown,
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
          children: [
            // Over-title (Duration & Location)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '// ${widget.exp.duration.toUpperCase()}',
                  style: GoogleFonts.spaceMono(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: pal.textPrimary.withValues(alpha: 0.5),
                    letterSpacing: 2,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: pal.textPrimary.withValues(alpha: 0.5),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.exp.location.toUpperCase(),
                      style: GoogleFonts.spaceMono(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: pal.textPrimary.withValues(alpha: 0.5),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Header Row: Role & Company Logo
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HoverAnimatedText(
                        text: widget.exp.role.toUpperCase(),
                        style: GoogleFonts.anton(
                          fontSize: widget.isDesktop ? 36 : 28,
                          height: 1.1,
                          color: pal.textPrimary,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.exp.company.toUpperCase(),
                        style: GoogleFonts.spaceMono(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: BrandColors.warmBrown,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isAppStation) ...[
                  const SizedBox(width: 16),
                  Image.asset(
                    'assets/appstation_logo.png',
                    height: widget.isDesktop ? 80 : 36,
                    fit: BoxFit.contain,
                  ),
                ],
              ],
            ),

            const SizedBox(height: 32),

            // Bullet Points
            ...widget.exp.points.map((pt) => _buildPoint(pt, pal)).toList(),

            const SizedBox(height: 32),

            // Tech Stack
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.exp.technologies
                  .map((t) => _buildTechTag(t, pal))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(String point, AppPalette pal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '—',
            style: GoogleFonts.outfit(
              color: BrandColors.warmBrown,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              point,
              style: GoogleFonts.outfit(
                fontSize: 15,
                height: 1.8,
                color: pal.textPrimary.withValues(alpha: 0.75),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechTag(String name, AppPalette pal) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: pal.textPrimary.withValues(alpha: 0.03),
        border: Border.all(color: pal.textPrimary.withValues(alpha: 0.1)),
      ),
      child: Text(
        name.toUpperCase(),
        style: GoogleFonts.spaceMono(
          color: pal.textPrimary.withValues(alpha: 0.7),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
