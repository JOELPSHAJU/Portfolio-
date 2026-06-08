import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

class CertificationsSection extends StatelessWidget {
  const CertificationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    final certifications = [
      {
        'title': 'Microsoft Learn Student Ambassador',
        'issuer': 'Microsoft',
        'category': 'COMMUNITY & LEADERSHIP',
        'icon': Icons.verified_user_rounded,
        'description':
            'Conducted technical workshops, spoke on cloud integrations, and mentored student developers across the region.',
        'accent': BrandColors.primaryNeon,
        'gradient': [
          const Color(0xFF10B981).withOpacity(0.18),
          const Color(0xFFF0FDF4).withOpacity(0.80),
        ],
      },
      {
        'title': 'Flutter Certified Specialist',
        'issuer': 'Advanced Mobile Academy',
        'category': 'CERTIFICATION',
        'icon': Icons.bookmark_added_rounded,
        'description':
            'Verified proficiency in state management, Clean Architecture, and performance optimization.',
        'accent': BrandColors.secondaryNeon,
        'gradient': [
          const Color(0xFF06B6D4).withOpacity(0.18),
          const Color(0xFFEFF6FF).withOpacity(0.80),
        ],
      },
      {
        'title': 'Technical Systems Workshop',
        'issuer': 'Appstation Core Team',
        'category': 'WORKSHOP',
        'icon': Icons.developer_mode_rounded,
        'description':
            'Deep dive into Melos monorepos, Microsoft SSO, and multi-tenant authentication patterns.',
        'accent': BrandColors.accentNeon,
        'gradient': [
          const Color(0xFF8C5E28).withOpacity(0.15),
          const Color(0xFFF8FAFC).withOpacity(0.80),
        ],
      },
      {
        'title': 'Cloud & DevOps Webinar Leader',
        'issuer': 'Developer Community',
        'category': 'PRESENTATION',
        'icon': Icons.cloud_done_rounded,
        'description':
            'Shared deployment strategies for Flutter web nodes and server backends on AWS infrastructure.',
        'accent': BrandColors.primaryNeon,
        'gradient': [
          const Color(0xFF10B981).withOpacity(0.18),
          const Color(0xFFF0FDF4).withOpacity(0.80),
        ],
      },
    ];

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
            child: _buildSectionHeader('CREDENTIALS', 'Certifications & Workshops'),
          ),
          const SizedBox(height: 36),
          isDesktop
              ? _buildDesktopBento(certifications)
              : _buildMobileBento(certifications),
        ],
      ),
    );
  }

  Widget _buildDesktopBento(List<Map<String, dynamic>> certs) {
    return Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: FadeInSlide(
                  delay: const Duration(milliseconds: 200),
                  direction: 30.0,
                  child: _BentoFeaturedCard(cert: certs[0]),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 1,
                child: FadeInSlide(
                  delay: const Duration(milliseconds: 280),
                  direction: 30.0,
                  child: _BentoCompactCard(cert: certs[1]),
                ),
              ),
            ],
          ),
        const SizedBox(height: 14),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: FadeInSlide(
                  delay: const Duration(milliseconds: 360),
                  direction: 30.0,
                  child: _BentoCompactCard(cert: certs[2]),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 2,
                child: FadeInSlide(
                  delay: const Duration(milliseconds: 440),
                  direction: 30.0,
                  child: _BentoFeaturedCard(cert: certs[3]),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildMobileBento(List<Map<String, dynamic>> certs) {
    return Column(
      children: [
        for (int i = 0; i < certs.length; i++) ...[
          FadeInSlide(
            delay: Duration(milliseconds: 200 + (i * 80)),
            direction: 30.0,
            child: _BentoMobileCard(cert: certs[i]),
          ),
          if (i < certs.length - 1) const SizedBox(height: 14),
        ],
      ],
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

// ─────────────────────────────────────────
// FEATURED CARD — glassmorphism + diagonal gradient overlay
// ─────────────────────────────────────────
class _BentoFeaturedCard extends StatefulWidget {
  final Map<String, dynamic> cert;
  const _BentoFeaturedCard({required this.cert});

  @override
  State<_BentoFeaturedCard> createState() => _BentoFeaturedCardState();
}

class _BentoFeaturedCardState extends State<_BentoFeaturedCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.cert['accent'] as Color;
    final gradientColors = widget.cert['gradient'] as List<Color>;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.5)
                : const Color(0xFF1C1008).withOpacity(0.04),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? accent.withOpacity(0.12) : const Color(0xFF1C1008).withOpacity(0.06),
              blurRadius: _hovered ? 40 : 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // Base dark layer
              Container(color: const Color(0xFFF7F1E6)),

              // Diagonal gradient overlay
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _hovered ? 1.0 : 0.6,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // Frosted noise texture overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF1C1008).withOpacity(0.01),
                        Colors.transparent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category row with icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Frosted pill tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1008).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: accent.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            widget.cert['category'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: accent,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        // Icon in frosted circle
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1008).withOpacity(0.04),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: accent.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            widget.cert['icon'] as IconData,
                            color: accent,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    Text(
                      widget.cert['title'] as String,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        letterSpacing: -0.2,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Issuer with small left accent line
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
                          widget.cert['issuer'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: accent,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Text(
                      widget.cert['description'] as String,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: const Color(0xFF1C1008).withOpacity(0.55),
                        height: 1.65,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// COMPACT CARD — frosted glass, top accent bar
// ─────────────────────────────────────────
class _BentoCompactCard extends StatefulWidget {
  final Map<String, dynamic> cert;
  const _BentoCompactCard({required this.cert});

  @override
  State<_BentoCompactCard> createState() => _BentoCompactCardState();
}

class _BentoCompactCardState extends State<_BentoCompactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.cert['accent'] as Color;
    final gradientColors = widget.cert['gradient'] as List<Color>;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.5)
                : const Color(0xFFE8E0D8).withOpacity(0.60),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? accent.withOpacity(0.10) : const Color(0xFF1C1008).withOpacity(0.06),
              blurRadius: _hovered ? 35 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // Base
              Container(color: const Color(0xFFF7F1E6)),

              // Diagonal gradient overlay
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _hovered ? 1.0 : 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top accent bar + icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: _hovered ? 50 : 28,
                          height: 3,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1008).withOpacity(0.04),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: accent.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            widget.cert['icon'] as IconData,
                            color: accent,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Category
                    Text(
                      widget.cert['category'] as String,
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                        color: accent.withOpacity(0.85),
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      widget.cert['title'] as String,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.3,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      widget.cert['issuer'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      widget.cert['description'] as String,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: const Color(0xFF1C1008).withOpacity(0.55),
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// MOBILE CARD — horizontal glassmorphism row
// ─────────────────────────────────────────
class _BentoMobileCard extends StatefulWidget {
  final Map<String, dynamic> cert;
  const _BentoMobileCard({required this.cert});

  @override
  State<_BentoMobileCard> createState() => _BentoMobileCardState();
}

class _BentoMobileCardState extends State<_BentoMobileCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.cert['accent'] as Color;
    final gradientColors = widget.cert['gradient'] as List<Color>;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _hovered
                ? accent.withOpacity(0.45)
                : const Color(0xFFE8E0D8).withOpacity(0.60),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? accent.withOpacity(0.08) : const Color(0xFF1C1008).withOpacity(0.05),
              blurRadius: _hovered ? 28 : 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Stack(
            children: [
              Container(color: const Color(0xFFF7F1E6)),
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 280),
                  opacity: _hovered ? 0.9 : 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1C1008).withOpacity(0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: accent.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                          widget.cert['icon'] as IconData, color: accent, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.cert['category'] as String,
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: accent,
                              letterSpacing: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.cert['title'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A1A1A),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.cert['issuer'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: accent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.cert['description'] as String,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: const Color(0xFF1C1008).withOpacity(0.55),
                              height: 1.5,
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
        ),
      ),
    );
  }
}
