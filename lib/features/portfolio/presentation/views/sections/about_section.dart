import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
          // Section Title
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            direction: 25.0,
            child: _buildSectionHeader(
              'ABOUT ME',
              'Engineering Scalable Mobile Solutions',
            ),
          ),
          const SizedBox(height: 20),

          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: FadeInSlide(
                        delay: const Duration(milliseconds: 250),
                        direction: 30.0,
                        child: _buildBiographyCard(),
                      ),
                    ),
                    const SizedBox(width: 36),
                    Expanded(
                      flex: 5,
                      child: FadeInSlide(
                        delay: const Duration(milliseconds: 400),
                        direction: 30.0,
                        child: _buildPillarsGrid(isDesktop),
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInSlide(
                      delay: const Duration(milliseconds: 250),
                      direction: 30.0,
                      child: _buildBiographyCard(),
                    ),
                    const SizedBox(height: 36),
                    FadeInSlide(
                      delay: const Duration(milliseconds: 400),
                      direction: 30.0,
                      child: _buildPillarsGrid(isDesktop),
                    ),
                  ],
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

  Widget _buildBiographyCard() {
    return GlassContainer(
      borderRadius: 24.0,
      padding: const EdgeInsets.all(28.0),
      customBorder: Border.all(
        color: BrandColors.primaryNeon.withOpacity(0.2),
        width: 1.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: BrandColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: BrandColors.primaryNeon.withOpacity(0.35),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(2), // Border thickness
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: BrandColors.darkCard,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/joel_p_shaju.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Who I Am',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF141010),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Joel P Shaju',
                      style: TextStyle(
                        fontSize: 13,
                        color: BrandColors.secondaryNeon,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'I am an innovative Flutter Developer with 2+ years of experience constructing production-grade cross-platform apps for iOS and Android. My engineering philosophy revolves around creating codebase structures that are robust, testable, and highly responsive to end-user needs.',
            style: TextStyle(
              fontSize: 14.5,
              color: Color(0xFFD4B896),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Having developed enterprise software like Kahramaa (Qatar Water & Electricity Corp) and Khadoom (ESS Portal), I specialize in architecting modular monorepos (via Melos), integrating secure authentication systems (Entra ID, biometric credentials), and managing complex API session states (token refreshes). I frequently leverage advanced AI-assisted editors (Cursor, Claude, Copilot) to accelerate coding speed, refine test coverage, and uphold clean code guidelines.',
            style: TextStyle(
              fontSize: 14.5,
              color: Color(0xFFD4B896),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          // Education highlight
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1008).withOpacity(0.02),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: BrandColors.glassBorder.withOpacity(0.06),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.school_rounded,
                  color: BrandColors.secondaryNeon,
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diploma in Computer Engineering',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF141010),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Govt. Polytechnic College, Kaduthuruthy (2020 – 2023)',
                        style: TextStyle(
                          fontSize: 12,
                          color: BrandColors.accentNeon,
                        ),
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

  Widget _buildPillarsGrid(bool isDesktop) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isDesktop ? 2 : 1,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: isDesktop ? 1.3 : 1.6,
      children: [
        _buildPillarCard(
          icon: Icons.layers_rounded,
          title: 'Clean Architecture',
          description:
              'Segregating concerns cleanly into Domain, Data, and Presentation layers for highly testable, independent, and modular repositories.',
          accentColor: BrandColors.primaryNeon,
        ),
        _buildPillarCard(
          icon: Icons.security_rounded,
          title: 'Security & Auth',
          description:
              'Implementing token refresh cycles, biometric login integrations, Microsoft Entra ID (Azure AD), OAuth2, and encrypted keystore storage.',
          accentColor: BrandColors.secondaryNeon,
        ),
        _buildPillarCard(
          icon: Icons.bolt_rounded,
          title: 'State Orchestration',
          description:
              'Orchestrating complex, predictive UI reactive workflows using Riverpod, Bloc, and GetIt dependency injection frameworks.',
          accentColor: BrandColors.successNeon,
        ),
        _buildPillarCard(
          icon: Icons.psychology_rounded,
          title: 'AI-Assisted Velocity',
          description:
              'Pairing with Claude, Cursor, and Copilot tools to optimize developer velocity, enforce lint guidelines, and refine algorithm quality.',
          accentColor: BrandColors.accentNeon,
        ),
      ],
    );
  }

  Widget _buildPillarCard({
    required IconData icon,
    required String title,
    required String description,
    required Color accentColor,
  }) {
    return GlassContainer(
      borderRadius: 20.0,
      padding: const EdgeInsets.all(20.0),
      customBorder: Border.all(color: accentColor.withOpacity(0.2), width: 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF141010),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12.5,
                color: BrandColors.accentNeon,
                height: 1.4,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
