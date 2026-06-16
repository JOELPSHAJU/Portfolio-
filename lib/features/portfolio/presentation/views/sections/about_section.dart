import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:clean_riverpod_template/core/theme/app_colors.dart';
import 'package:clean_riverpod_template/core/theme/brand_colors.dart';
import 'package:clean_riverpod_template/core/widgets/glass_container.dart';
import 'package:clean_riverpod_template/core/widgets/gradient_text.dart';
import 'package:clean_riverpod_template/core/widgets/fade_in_slide.dart';

// ─── Hexagon Clipper ──────────────────────────────────────────────────────────

class _HexClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy);
    for (var i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * math.pi / 180;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_HexClipper old) => false;
}

// ─── Geometric dot-grid background painter ────────────────────────────────────

class _GeoPainter extends CustomPainter {
  final Color color;
  _GeoPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const spacing = 22.0;
    const r = 1.5;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), r, paint);
      }
    }

    // Large faint hex outline — decorative watermark in top-right corner
    final hexPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    _drawHex(canvas, hexPaint, Offset(size.width - 25, 30), 130);
    _drawHex(canvas, hexPaint, Offset(size.width + 40, 90), 80);
  }

  void _drawHex(Canvas canvas, Paint paint, Offset center, double r) {
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * math.pi / 180;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_GeoPainter old) => old.color != color;
}

// ─── Hexagon border painter ───────────────────────────────────────────────────

class _HexBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  _HexBorderPainter(this.color, {this.strokeWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy) - strokeWidth / 2;
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * math.pi / 180;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HexBorderPainter old) => old.color != color || old.strokeWidth != strokeWidth;
}

// ─── Pillar icon hex painter (small hex frame behind icon) ───────────────────

class _MiniHexPainter extends CustomPainter {
  final Color color;
  _MiniHexPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = math.min(cx, cy) - 1;
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * math.pi / 180;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_MiniHexPainter old) => old.color != color;
}

// ─── About Section ────────────────────────────────────────────────────────────

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    final pal = context.palette;

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
            child: _buildSectionHeader(),
          ),
          const SizedBox(height: 20),
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 4,
                        child: FadeInSlide(
                          delay: const Duration(milliseconds: 250),
                          direction: 30.0,
                          child: _buildBiographyCard(pal),
                        ),
                      ),
                      const SizedBox(width: 36),
                      Expanded(
                        flex: 5,
                        child: FadeInSlide(
                          delay: const Duration(milliseconds: 400),
                          direction: 30.0,
                          child: _buildPillarsGrid(isDesktop, pal),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInSlide(
                      delay: const Duration(milliseconds: 250),
                      direction: 30.0,
                      child: _buildBiographyCard(pal),
                    ),
                    const SizedBox(height: 36),
                    FadeInSlide(
                      delay: const Duration(milliseconds: 400),
                      direction: 30.0,
                      child: _buildPillarsGrid(isDesktop, pal),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ABOUT ME',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: BrandColors.primaryNeon,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 8),
        GradientText(
          'Engineering Scalable Mobile Solutions',
          gradient: BrandColors.primaryGradient,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 2.5,
          decoration: BoxDecoration(
            color: BrandColors.primaryNeon,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildBiographyCard(AppPalette pal) {
    return GlassContainer(
      borderRadius: 20.0,
      padding: const EdgeInsets.all(0), // handled internally with Stack
      customBorder: Border.all(
        color: BrandColors.primaryNeon.withOpacity(0.18),
        width: 1.5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19),
        child: Stack(
          children: [
            // ── Geometric dot-grid background ──────────────────────────
            Positioned.fill(
              child: CustomPaint(
                painter: _GeoPainter(BrandColors.primaryNeon.withOpacity(0.04)),
              ),
            ),

            // ── Content ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Header: hexagonal avatar + name
                  Row(
                    children: [
                      _HexAvatar(),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Who I Am',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: pal.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Joel P Shaju',
                              style: TextStyle(
                                fontSize: 13,
                                color: BrandColors.primaryNeon,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Flutter Developer · 2+ yrs',
                              style: TextStyle(
                                fontSize: 11,
                                color: pal.warmBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Bio paragraphs
                  Text(
                    'I am an innovative Flutter Developer with 2+ years of experience constructing production-grade cross-platform apps for iOS, Android and Web. My engineering philosophy revolves around creating codebase structures that are robust, testable, and highly responsive to end-user needs.',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: pal.warmBrown,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Having developed enterprise software like Kahramaa (Qatar Water & Electricity Corp) and Khadoom (ESS Portal), I specialize in architecting modular monorepos (via Melos), integrating secure authentication systems (Entra ID, biometric credentials), and managing complex API session states.',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: pal.warmBrown,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Education highlight
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: BrandColors.primaryNeon.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: BrandColors.primaryNeon.withOpacity(0.14),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Small hex icon frame
                        SizedBox(
                          width: 54,
                          height: 54,
                          child: CustomPaint(
                            painter: _HexBorderPainter(
                              BrandColors.primaryNeon.withOpacity(0.5),
                              strokeWidth: 2.0,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.school_rounded,
                                color: BrandColors.primaryNeon,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Diploma in Computer Engineering',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                  color: pal.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarsGrid(bool isDesktop, AppPalette pal) {
    final cards = [
      _buildPillarCard(icon: Icons.layers_rounded,         title: 'Clean Architecture',    description: 'Segregating concerns into Domain, Data, and Presentation layers for highly testable, modular repositories.',          accentColor: BrandColors.primaryNeon,   pal: pal),
      _buildPillarCard(icon: Icons.security_rounded,       title: 'Security & Auth',       description: 'Implementing token refresh cycles, biometric login, Microsoft Entra ID, OAuth2, and encrypted storage.',             accentColor: BrandColors.secondaryNeon, pal: pal),
      _buildPillarCard(icon: Icons.bolt_rounded,           title: 'State Orchestration',   description: 'Orchestrating complex reactive UI workflows using Riverpod, Bloc, and GetIt dependency injection.',                   accentColor: BrandColors.successNeon,   pal: pal),
      _buildPillarCard(icon: Icons.psychology_rounded,     title: 'AI-Assisted Velocity',  description: 'Pairing with Claude, Cursor, and Copilot to optimize velocity, enforce lint guidelines, and refine quality.',        accentColor: BrandColors.accentNeon,    pal: pal),
    ];

    if (!isDesktop) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            cards[i],
            if (i < cards.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var row = 0; row < cards.length; row += 2) ...[
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: cards[row]),
                  const SizedBox(width: 16),
                  Expanded(
                    child: row + 1 < cards.length
                        ? cards[row + 1]
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
          if (row + 2 < cards.length) const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildPillarCard({
    required IconData icon,
    required String title,
    required String description,
    required Color accentColor,
    required AppPalette pal,
  }) {
    return GlassContainer(
      borderRadius: 18.0,
      padding: const EdgeInsets.all(0),
      customBorder: Border.all(color: accentColor.withOpacity(0.18), width: 1.2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: Stack(
          children: [
            // Subtle dot-grid tinted with accent
            Positioned.fill(
              child: CustomPaint(
                painter: _GeoPainter(accentColor.withOpacity(0.03)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Hexagonal icon frame
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CustomPaint(
                      painter: _HexBorderPainter(accentColor.withOpacity(0.45), strokeWidth: 2.0),
                      child: Center(
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: accentColor, size: 24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: pal.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: pal.warmBrown, height: 1.45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Hexagonal Avatar widget ──────────────────────────────────────────────────

class _HexAvatar extends StatefulWidget {
  const _HexAvatar();

  @override
  State<_HexAvatar> createState() => _HexAvatarState();
}

class _HexAvatarState extends State<_HexAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _glow = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glow,
      builder: (_, __) {
        return SizedBox(
          width: 110,
          height: 110,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer glow hex border (pulses)
              CustomPaint(
                size: const Size(110, 110),
                painter: _HexBorderPainter(
                  BrandColors.primaryNeon.withOpacity(0.20 + _glow.value * 0.35),
                  strokeWidth: 2.0,
                ),
              ),

              // Inner filled hex with gradient border
              SizedBox(
                width: 96,
                height: 96,
                child: CustomPaint(
                  painter: _HexBorderPainter(
                    BrandColors.primaryNeon,
                    strokeWidth: 3.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: ClipPath(
                      clipper: _HexClipper(),
                      child: Image.asset(
                        'assets/joel_p_shaju.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
