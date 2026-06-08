import 'package:flutter/material.dart';
import '../../../domain/entities/experience.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';


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
            child: _buildSectionHeader('CAREER PATH', 'Professional Experience'),
          ),
          const SizedBox(height: 24),

          // Timeline layout
          if (experiences.isEmpty)
            const Center(
              child: Text(
                'No experience data found.',
                style: TextStyle(color: const Color(0xFF3D2410)),
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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator column
          Column(
            children: [
              // Glowing Node
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: index == 0
                      ? BrandColors.primaryGradient
                      : const LinearGradient(colors: [Color(0xFF16092A), Color(0xFF0F051D)]),
                  border: Border.all(
                    color: index == 0
                        ? BrandColors.primaryNeon.withOpacity(0.5)
                        : const Color(0xFFC8973E).withOpacity(0.30),
                    width: 2,
                  ),
                  boxShadow: index == 0
                      ? [
                          BoxShadow(
                            color: BrandColors.primaryNeon.withOpacity(0.5),
                            blurRadius: 10,
                          )
                        ]
                      : null,
                ),
              ),
              // Line connector
              Expanded(
                child: Container(
                  width: 2,
                  color: BrandColors.glassBorder.withOpacity(0.15),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),

          // Main Card column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: GlassContainer(
                borderRadius: 20.0,
                padding: const EdgeInsets.all(24.0),
                customBorder: Border.all(
                  color: (index == 0 ? BrandColors.primaryNeon : BrandColors.secondaryNeon).withOpacity(0.18),
                  width: 1.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Duration & Location Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: (index == 0 ? BrandColors.primaryNeon : BrandColors.secondaryNeon).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            exp.duration,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: index == 0 ? BrandColors.primaryNeon : BrandColors.secondaryNeon,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, color: BrandColors.accentNeon, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              exp.location,
                              style: const TextStyle(fontSize: 12, color: BrandColors.accentNeon),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Job Title & Company
                    Text(
                      exp.role,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exp.company,
                      style: const TextStyle(
                        fontSize: 14,
                        color: BrandColors.secondaryNeon,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Accomplishment points
                    Column(
                      children: exp.points.map((pt) => _buildAccomplishmentPoint(pt)).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Tech Stack Tags used
                    const Divider(color: BrandColors.glassBorder, height: 1),
                    const SizedBox(height: 16),
                    const Text(
                      'KEY ARCHITECTURE & TOOLING:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3D2410),
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: exp.technologies.map((tech) => _buildTechTag(tech)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccomplishmentPoint(String point) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 10.0),
            child: Icon(Icons.lens, color: BrandColors.primaryNeon, size: 6),
          ),
          Expanded(
            child: Text(
              point,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF3D2410),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechTag(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF7A5232).withOpacity(0.70),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BrandColors.glassBorder.withOpacity(0.06)),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: BrandColors.accentNeon,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
