import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/premium_button.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExploreWorkPressed;
  final VoidCallback onContactPressed;

  const HeroSection({
    super.key,
    required this.onExploreWorkPressed,
    required this.onContactPressed,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  final List<String> _roles = [
    'Flutter Developer',
    'Mobile Architect',
    'Clean Code Specialist',
    'AI-Assisted Builder',
  ];
  int _roleIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (mounted) {
        setState(() => _roleIndex = (_roleIndex + 1) % _roles.length);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    return isDesktop ? _buildDesktop(size) : _buildMobile(size);
  }

  // ─────────────────────────────────────────
  // DESKTOP — cinematic poster layout
  // ─────────────────────────────────────────
  Widget _buildDesktop(Size size) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.92,
      child: Stack(
        children: [
          // ── Background: deep dark gradient ──
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    BrandColors.deepIndigoBlack,
                    BrandColors.deepViolet,
                    BrandColors.deepIndigoBlack,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          // ── Giant name watermark — bottom layer ──
          Positioned.fill(
            child: FadeInSlide(
              delay: const Duration(milliseconds: 100),
              direction: 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 200,
                      left: 24,
                      right: 24,
                    ),
                    child: Text(
                      textAlign: TextAlign.center,
                      'JOEL P SHAJU\n FLUTTER DEVELOPER',
                      style: TextStyle(
                        fontSize: 200,
                        fontWeight: FontWeight.w900,
                        color: Colors.blueGrey.withValues(alpha: .2),
                        letterSpacing: 8,
                        height: 1.0,
                        shadows: [],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Subtle neon glow behind portrait ──
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.05,
            child: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: BrandColors.warmAmber.withOpacity(0.10),
                      blurRadius: 180,
                      spreadRadius: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Portrait image — center ──
          Positioned(
            left: 0,
            right: 0,
            top: size.height * 0.02,
            bottom: 0,
            child: FadeInSlide(
              delay: const Duration(milliseconds: 300),
              direction: 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size.height * 0.82,
                  child: Image.asset(
                    'assets/joel_p_shaju.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // ── Dark gradient at bottom to blend portrait into bg ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    BrandColors.deepIndigoBlack.withOpacity(0.98),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // ── Left side: role tags + subtitle ──
          Positioned(
            left: 40,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category pills
                const FadeInSlide(
                  delay: Duration(milliseconds: 400),
                  direction: 25,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      _PillTag(
                        label: 'MOBILE',
                        accent: BrandColors.primaryNeon,
                      ),
                      _PillTag(
                        label: 'FLUTTER',
                        accent: BrandColors.secondaryNeon,
                      ),
                      _PillTag(label: 'DART', accent: BrandColors.qswMid),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Animated role
                FadeInSlide(
                  delay: const Duration(milliseconds: 500),
                  direction: 20,
                  child: SizedBox(
                    height: 32,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, anim) {
                        final isEntering = child.key == ValueKey(_roleIndex);
                        return FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: isEntering ? const Offset(0, -1.0) : const Offset(0, 1.0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: anim,
                              curve: Curves.easeOutCubic,
                            )),
                            child: child,
                          ),
                        );
                      },
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      child: Text(
                        _roles[_roleIndex],
                        key: ValueKey(_roleIndex),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: BrandColors.secondaryNeon,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Short bio
                const FadeInSlide(
                  delay: Duration(milliseconds: 600),
                  direction: 20,
                  child: SizedBox(
                    width: 260,
                    child: Text(
                      'Building beautiful, scalable, production-ready Flutter apps.',
                      style: TextStyle(
                        fontSize: 14,
                        color: BrandColors.warmFaint,
                        height: 1.65,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // CTA
                FadeInSlide(
                  delay: const Duration(milliseconds: 700),
                  direction: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PremiumButton(
                        label: 'HIRE ME',
                        icon: Icons.send_rounded,
                        gradient: BrandColors.primaryGradient,
                        glowColor: BrandColors.primaryNeon,
                        onPressed: widget.onContactPressed,
                      ),
                      const SizedBox(height: 12),
                      PremiumButton(
                        label: 'DOWNLOAD RESUME',
                        icon: Icons.download_rounded,
                        gradient: const LinearGradient(
                          colors: [
                            BrandColors.darkCard,
                            BrandColors.darkSurface,
                          ],
                        ),
                        glowColor: Colors.transparent,
                        onPressed: () => _launchURL(
                          'https://joelpshaju.github.io/resume.pdf',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // ── Right side: contact info + socials ──
          Positioned(
            right: 40,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FadeInSlide(
                  delay: const Duration(milliseconds: 450),
                  direction: -25,
                  child: _SocialPill(
                    icon: Icons.phone_rounded,
                    label: '+91 8590182736',
                    onTap: () => _launchURL('tel:+918590182736'),
                  ),
                ),
                const SizedBox(height: 12),
                FadeInSlide(
                  delay: const Duration(milliseconds: 520),
                  direction: -25,
                  child: _SocialPill(
                    icon: Icons.email_rounded,
                    label: 'joelpshaju@gmail.com',
                    onTap: () => _launchURL('mailto:joelpshaju@gmail.com'),
                  ),
                ),
                const SizedBox(height: 12),
                FadeInSlide(
                  delay: const Duration(milliseconds: 590),
                  direction: -25,
                  child: _SocialPill(
                    icon: Icons.link_rounded,
                    label: 'LinkedIn',
                    onTap: () => _launchURL('https://www.linkedin.com/in/joel-p-shaju-b8aa1a292'),
                  ),
                ),
                const SizedBox(height: 12),
                FadeInSlide(
                  delay: const Duration(milliseconds: 660),
                  direction: -25,
                  child: _SocialPill(
                    icon: Icons.code_rounded,
                    label: 'GitHub',
                    onTap: () => _launchURL('https://github.com/joelpshaju'),
                  ),
                ),
                const SizedBox(height: 20),

                // Experience badge
                FadeInSlide(
                  delay: const Duration(milliseconds: 750),
                  direction: -25,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: BrandColors.qswMid.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: BrandColors.primaryNeon.withOpacity(0.22),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '2+',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: BrandColors.primaryNeon,
                            height: 1.0,
                          ),
                        ),
                        Text(
                          'Years of\nExperience',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.45),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // ── Bottom centre: scroll hint ──
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: FadeInSlide(
              delay: const Duration(milliseconds: 900),
              direction: 10,
              child: Column(
                children: [
                  Text(
                    'SCROLL TO EXPLORE',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.5,
                      color: Colors.white.withOpacity(0.25),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withOpacity(0.22),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // MOBILE layout
  // ─────────────────────────────────────────
  Widget _buildMobile(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category pills
          const FadeInSlide(
            delay: Duration(milliseconds: 100),
            direction: 20,
            child: Wrap(
              spacing: 8,
              children: [
                _PillTag(label: 'MOBILE', accent: BrandColors.primaryNeon),
                _PillTag(label: 'FLUTTER', accent: BrandColors.secondaryNeon),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Portrait with name watermark behind
          FadeInSlide(
            delay: const Duration(milliseconds: 200),
            direction: 20,
            child: SizedBox(
              height: size.height * 0.45,
              child: Stack(
                children: [
                  // Name watermark
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          'JOEL',
                          style: TextStyle(
                            fontSize: 160,
                            fontWeight: FontWeight.w900,
                            color: BrandColors.warmAmber.withOpacity(0.07),
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Portrait
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/joel_p_+shaju.png',
                        height: size.height * 0.42,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Role + bio
          FadeInSlide(
            delay: const Duration(milliseconds: 300),
            direction: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _roles[_roleIndex],
                key: ValueKey(_roleIndex),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: BrandColors.secondaryNeon,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FadeInSlide(
            delay: const Duration(milliseconds: 380),
            direction: 20,
            child: Text(
              'Building beautiful, scalable, production-ready Flutter apps.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.55),
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // CTAs
          FadeInSlide(
            delay: const Duration(milliseconds: 460),
            direction: 20,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                PremiumButton(
                  label: 'HIRE ME',
                  icon: Icons.send_rounded,
                  gradient: BrandColors.primaryGradient,
                  glowColor: BrandColors.primaryNeon,
                  onPressed: widget.onContactPressed,
                ),
                PremiumButton(
                  label: 'RESUME',
                  icon: Icons.download_rounded,
                  gradient: const LinearGradient(
                    colors: [BrandColors.darkCard, BrandColors.darkSurface],
                  ),
                  glowColor: Colors.transparent,
                  onPressed: () =>
                      _launchURL('https://joelpshaju.github.io/resume.pdf'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// SHARED MICRO WIDGETS
// ─────────────────────────────────────────
class _PillTag extends StatelessWidget {
  final String label;
  final Color accent;

  const _PillTag({required this.label, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: accent.withOpacity(0.25), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: accent,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SocialPill extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialPill({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_SocialPill> createState() => _SocialPillState();
}

class _SocialPillState extends State<_SocialPill> {
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered
                ? BrandColors.qswMid.withOpacity(0.10)
                : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered
                  ? BrandColors.primaryNeon.withOpacity(0.35)
                  : Colors.white.withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _hovered
                    ? BrandColors.primaryNeon
                    : Colors.white.withOpacity(0.35),
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: _hovered
                      ? Colors.white.withOpacity(0.90)
                      : Colors.white.withOpacity(0.45),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
