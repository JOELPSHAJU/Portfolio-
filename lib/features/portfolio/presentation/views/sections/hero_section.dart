import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:joel_portfolio/core/theme/app_colors.dart';
import 'package:joel_portfolio/core/theme/brand_colors.dart';
import 'package:joel_portfolio/core/widgets/hover_animated_text.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Hero Section ────────────────────────────────────────────────────────────

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

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return isDesktop ? _buildDesktop(size, isDark) : _buildMobile(size, isDark);
  }

  // ─────────────────────────────────────────
  // DESKTOP layout
  // ─────────────────────────────────────────
  Widget _buildDesktop(Size size, bool isDark) {
    final pal = context.palette;
    final bgColor = isDark ? const Color(0xFF070B13) : const Color(0xFFE2E8F0);

    return Container(
      width: size.width,
      height: size.height,
      color: bgColor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 1.0 : 0.15,
              child: Image.asset(
                'assets/joel_coding.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.center,
                color: isDark ? null : Colors.black,
                colorBlendMode: isDark ? null : BlendMode.saturation,
              ),
            ),
          ),

          // 2. High-end Editorial Vignette Scrim Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          bgColor.withOpacity(0.60),
                          bgColor.withOpacity(0.85),
                          bgColor,
                        ]
                      : [
                          bgColor.withOpacity(0.0),
                          bgColor.withOpacity(0.50),
                          bgColor,
                        ],
                  stops: const [0.0, 0.60, 1.0],
                ),
              ),
            ),
          ),

          // 5. Main Center Row (asymmetrical content layout)
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side editorial info column
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Monospace Badge Tag
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.06)
                                : Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.12)
                                  : Colors.black.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.greenAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'FLUTTER SPECIALIST & MOBILE SOLUTION ARCHITECT',
                                style: GoogleFonts.spaceMono(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: pal.textPrimary.withOpacity(0.85),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        HoverAnimatedText(
                          text: 'JOEL P SHAJU',
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              fontSize: (size.width * 0.055).clamp(52.0, 96.0),
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1.5,
                              color: pal.textPrimary,
                              height: 1.05,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Building world-class production mobile apps.',
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: pal.textPrimary.withOpacity(0.8),
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 540),
                          child: Text(
                            'Focused on Clean Architecture, Riverpod state models, and high-fidelity interaction design to deliver scalable enterprise systems.',
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: pal.textPrimary.withOpacity(0.6),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        Row(
                          children: [
                            _GradientHoverButton(
                              text: 'Explore Work',
                              onPressed: widget.onExploreWorkPressed,
                              isDark: isDark,
                              pal: pal,
                            ),
                            const SizedBox(width: 16),
                            _GradientHoverTextButton(
                              text: "Let's Connect",
                              onPressed: widget.onContactPressed,
                              isDark: isDark,
                              pal: pal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Right side interactive hud/metrics card
                  Flexible(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _DeveloperDashboardCard(isDark: isDark, pal: pal),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 6. Right Side Scroll Down Hint
          Positioned(
            right: size.width * 0.08,
            bottom: size.height * 0.08,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Scroll down',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: pal.textPrimary.withOpacity(0.7),
                    fontFamily: 'Outfit',
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 10),
                Icon(
                  Icons.arrow_downward_rounded,
                  size: 20,
                  color: pal.textPrimary.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  // MOBILE layout
  // ─────────────────────────────────────────
  Widget _buildMobile(Size size, bool isDark) {
    final pal = context.palette;
    final bgColor = isDark ? const Color(0xFF070B13) : const Color(0xFFE2E8F0);

    return Container(
      width: size.width,
      height: size.height,
      color: bgColor,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Interactive Star/Constellation Network (Fluid, interactive, image-less)
          Positioned.fill(child: InteractiveParticleCanvas(isDark: isDark)),

          // 2. Vector Tech Grid Blueprint Background Overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(
                color: isDark ? const Color(0xFF00E5FF) : Colors.black,
              ),
            ),
          ),

          // 3. Content layout
          Positioned.fill(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Substantial Top spacing as requested
                      const SizedBox(height: 80),

                      // Floating Glass Capsule
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 28,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.black.withOpacity(0.25)
                              : Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withOpacity(0.08)
                                : Colors.black.withOpacity(0.06),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                isDark ? 0.15 : 0.03,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Neon Badge Tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(
                                  0xFF00E5FF,
                                ).withOpacity(0.08),
                              ),
                              child: Text(
                                'SYSTEMS ARCHITECT // DEV',
                                style: GoogleFonts.spaceMono(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF00E5FF),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Name Title (interactive water text fill)
                            Center(
                              child: HoverAnimatedText(
                                text: 'JOEL P SHAJU',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  textStyle: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.0,
                                    color: pal.textPrimary,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Tagline
                            Text(
                              'Building world-class production mobile apps.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: pal.textPrimary.withOpacity(0.9),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Detailed Bio Copy
                            Text(
                              'Focused on Clean Architecture, Riverpod state models, and high-fidelity interaction design to deliver scalable enterprise systems.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: pal.textPrimary.withOpacity(0.65),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Clean Mini Stats Cards row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildMiniStat('2+', 'Yrs Exp', isDark, pal),
                          const SizedBox(width: 8),
                          _buildMiniStat('8+', 'Projects', isDark, pal),
                          const SizedBox(width: 8),
                          _buildMiniStat('99%', 'Quality', isDark, pal),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Action button row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Primary Pill button
                          GestureDetector(
                            onTap: widget.onExploreWorkPressed,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 14,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00E5FF),
                                    Color(0xFF007AFF),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF00E5FF,
                                    ).withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Explore Work',
                                    style: GoogleFonts.outfit(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Secondary Text Link
                          TextButton(
                            onPressed: widget.onContactPressed,
                            style: TextButton.styleFrom(
                              foregroundColor: pal.textPrimary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                            child: Text(
                              'Let\'s Connect',
                              style: GoogleFonts.outfit(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 5. Scroll Down Hint
          Positioned(
            right: 24,
            bottom: 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Scroll down',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: pal.textPrimary.withOpacity(0.6),
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_downward_rounded,
                  size: 14,
                  color: pal.textPrimary.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, bool isDark, dynamic pal) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.04)
            : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.06),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF00E5FF),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.spaceMono(
              fontSize: 8.5,
              fontWeight: FontWeight.w600,
              color: pal.textPrimary.withOpacity(0.55),
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveParticleCanvas extends StatefulWidget {
  final bool isDark;
  const InteractiveParticleCanvas({super.key, required this.isDark});

  @override
  State<InteractiveParticleCanvas> createState() =>
      _InteractiveParticleCanvasState();
}

class _InteractiveParticleCanvasState extends State<InteractiveParticleCanvas>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final List<_Particle> _particles = [];
  final math.Random _random = math.Random();
  Offset? _touchPosition;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 30; i++) {
      _particles.add(
        _Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          vx: (_random.nextDouble() - 0.5) * 0.0025,
          vy: (_random.nextDouble() - 0.5) * 0.0025,
          radius: _random.nextDouble() * 2.0 + 1.5,
        ),
      );
    }

    _ticker = createTicker((elapsed) {
      setState(() {
        for (var p in _particles) {
          p.update();
        }
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) => setState(() => _touchPosition = e.localPosition),
      onPointerMove: (e) => setState(() => _touchPosition = e.localPosition),
      onPointerUp: (e) => setState(() => _touchPosition = null),
      onPointerCancel: (e) => setState(() => _touchPosition = null),
      child: CustomPaint(
        painter: _ParticlePainter(
          particles: _particles,
          touchPosition: _touchPosition,
          isDark: widget.isDark,
        ),
      ),
    );
  }
}

class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
  });

  void update() {
    x += vx;
    y += vy;

    if (x < 0 || x > 1) vx = -vx;
    if (y < 0 || y > 1) vy = -vy;

    x = x.clamp(0.0, 1.0);
    y = y.clamp(0.0, 1.0);
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final Offset? touchPosition;
  final bool isDark;

  _ParticlePainter({
    required this.particles,
    required this.touchPosition,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = isDark
          ? const Color(0xFF00E5FF).withOpacity(0.5)
          : Colors.black.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = isDark
          ? const Color(0xFF00E5FF).withOpacity(0.08)
          : Colors.black.withOpacity(0.03)
      ..strokeWidth = 0.8;

    final offsets = particles
        .map((p) => Offset(p.x * size.width, p.y * size.height))
        .toList();

    for (int i = 0; i < offsets.length; i++) {
      for (int j = i + 1; j < offsets.length; j++) {
        final dist = (offsets[i] - offsets[j]).distance;
        if (dist < 100) {
          canvas.drawLine(offsets[i], offsets[j], linePaint);
        }
      }
    }

    for (int i = 0; i < offsets.length; i++) {
      canvas.drawCircle(offsets[i], particles[i].radius, dotPaint);
    }

    if (touchPosition != null && isDark) {
      final ringPaint = Paint()
        ..color = const Color(0xFF00E5FF).withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawCircle(touchPosition!, 30, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

class _GridPainter extends CustomPainter {
  final Color color;
  const _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.04)
      ..strokeWidth = 0.5;

    const double step = 25.0; // grid size
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.color != color;
}

// ─── Infinite Name Ticker Widget ──────────────────────────────────────────────

class InfiniteNameTicker extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const InfiniteNameTicker({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(seconds: 20),
  });

  @override
  State<InfiniteNameTicker> createState() => _InfiniteNameTickerState();
}

class _InfiniteNameTickerState extends State<InfiniteNameTicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repeated text block
    final String repeatedText = '${widget.text}   •   ' * 8;

    return ClipRect(
      child: OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FractionalTranslation(
              translation: Offset(-_controller.value * 0.5, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    repeatedText,
                    style: widget.style,
                    maxLines: 1,
                    softWrap: false,
                  ),
                  Text(
                    repeatedText,
                    style: widget.style,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Glassmorphic Developer Dashboard HUD Card ───────────────────────────────

class _DeveloperDashboardCard extends StatelessWidget {
  final bool isDark;
  final AppPalette pal;

  const _DeveloperDashboardCard({required this.isDark, required this.pal});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark
        ? Colors.black.withOpacity(0.4)
        : Colors.white.withOpacity(0.55);
    final borderCol = isDark
        ? Colors.white.withOpacity(0.12)
        : Colors.black.withOpacity(0.12);
    final textMuted = isDark ? Colors.white54 : Colors.black54;

    return Container(
      width: 380,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderCol, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.08),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildCircle(Colors.redAccent.withOpacity(0.7)),
              const SizedBox(width: 6),
              _buildCircle(Colors.amberAccent.withOpacity(0.7)),
              const SizedBox(width: 6),
              _buildCircle(Colors.greenAccent.withOpacity(0.7)),
              const Spacer(),
              Text(
                'SYSTEM_METRICS.sh',
                style: GoogleFonts.spaceMono(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildMetricLine('ARCHITECTURE', 'CLEAN/MVC/MVP/MVVM/MODULAR'),
          _buildMetricLine('DEVELOPMENT', 'MOBILE & WEB APPLICATIONS'),
          _buildMetricLine('EXPERIENCE', '3 YEARS'),
          _buildMetricLine('DELIVERABLES', '5+ SHIPPED APPS'),
          _buildMetricLine('CODE_METRICS', '98.8% TEST PASS'),
          const Divider(height: 32, color: Colors.white10),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'STATUS: READY FOR CONTRACTS',
                style: GoogleFonts.spaceMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildMetricLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: GoogleFonts.spaceMono(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.spaceMono(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientHoverButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDark;
  final AppPalette pal;

  const _GradientHoverButton({
    required this.text,
    required this.onPressed,
    required this.isDark,
    required this.pal,
  });

  @override
  State<_GradientHoverButton> createState() => _GradientHoverButtonState();
}

class _GradientHoverButtonState extends State<_GradientHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final pal = widget.pal;

    final gradientColors = isDark
        ? [const Color(0xFF00E5FF), const Color(0xFF007AFF)]
        : [const Color(0xFF0F172A), const Color(0xFF334155)];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? Colors.transparent
                  : pal.textPrimary.withValues(alpha: 0.35),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: (isDark ? const Color(0xFF00E5FF) : Colors.black)
                          .withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.5),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Hover Gradient (smooth opacity animation)
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    opacity: _isHovered ? 1.0 : 0.0,
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

                // Label Content Row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.text,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _isHovered ? Colors.white : pal.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: _isHovered ? Colors.white : pal.textPrimary,
                      ),
                    ],
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

class _GradientHoverTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDark;
  final AppPalette pal;

  const _GradientHoverTextButton({
    required this.text,
    required this.onPressed,
    required this.isDark,
    required this.pal,
  });

  @override
  State<_GradientHoverTextButton> createState() =>
      _GradientHoverTextButtonState();
}

class _GradientHoverTextButtonState extends State<_GradientHoverTextButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final pal = widget.pal;
    final isDark = widget.isDark;

    Widget textWidget = Text(
      widget.text,
      style: GoogleFonts.outfit(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: _isHovered
            ? (isDark ? Colors.white : pal.textPrimary)
            : pal.textPrimary.withValues(alpha: 0.8),
      ),
    );

    if (_isHovered && isDark) {
      textWidget = ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(
            colors: [Color(0xFF00E5FF), Color(0xFF007AFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
        },
        child: textWidget,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: textWidget,
        ),
      ),
    );
  }
}
