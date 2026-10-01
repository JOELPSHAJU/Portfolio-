import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/js_construction_theme.dart';
import '../common/site_signboards.dart';

/// Timed Overlays for the Construction Hero Scroll-driven Video stages
class HeroTimedOverlays extends StatelessWidget {
  final double progress;
  final bool isDesktop;
  final VoidCallback? onExploreProjectsTap;

  const HeroTimedOverlays({
    super.key,
    required this.progress,
    required this.isDesktop,
    this.onExploreProjectsTap,
  });

  static double calculateOverlayOpacity(
    double progress,
    double start,
    double end,
  ) {
    if (progress < start || progress > end) return 0.0;
    final span = end - start;
    final mid = start + span / 2;

    if (start == 0.0) {
      if (progress <= 0.18) return 1.0;
      return (1.0 - ((progress - 0.18) / 0.10)).clamp(0.0, 1.0);
    }
    if (end == 1.0) {
      return ((progress - start) / (span * 0.4)).clamp(0.0, 1.0);
    }
    if (progress <= mid) {
      return ((progress - start) / (span * 0.3)).clamp(0.0, 1.0);
    } else {
      return (1.0 - ((progress - mid) / (span * 0.5))).clamp(0.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final opacity1 = calculateOverlayOpacity(progress, 0.00, 0.28);
    final opacity2 = calculateOverlayOpacity(progress, 0.28, 0.58);
    final opacity3 = calculateOverlayOpacity(progress, 0.58, 0.85);
    final opacity4 = calculateOverlayOpacity(progress, 0.85, 1.00);

    return Stack(
      children: [
        if (opacity1 > 0.01) _buildStage1Entrance(isDesktop, opacity1),
        if (opacity2 > 0.01) _buildStage2Structural(isDesktop, opacity2),
        if (opacity3 > 0.01)
          _buildStage3CivilInfrastructure(isDesktop, opacity3),
        if (opacity4 > 0.01)
          _buildStage4MasterworkGate(isDesktop, opacity4, onExploreProjectsTap),
      ],
    );
  }

  // ── Stage 1: SITE ENTRANCE & OFFICIAL PROJECT IDENTIFICATION BOARD ────────
  Widget _buildStage1Entrance(bool isDesktop, double opacity) {
    return Stack(
      children: [
        Positioned(
          top: isDesktop ? 90 : 64,
          left: isDesktop ? 60 : 20,
          right: isDesktop ? null : 20,
          child: Opacity(
            opacity: opacity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 780 : double.infinity,
              ),
              child: SiteEntranceSignBoard(
                isDesktop: isDesktop,
                badge: isDesktop
                    ? 'GLOBAL EPC CLASS A  •  ZERO-INCIDENT SAFETY  •  EST. 1994'
                    : 'GLOBAL EPC BUILDERS  •  EST. 1994',
                title: 'JS CONSTRUCTIONS',
                subtitle: 'ENGINEERING MONUMENTAL FUTURES',
                body:
                    'Architectural master-builders creating the worlds most daring supertall commercial towers, post-tensioned civil infrastructure, and ultra-prime private estates.',
              ),
            ),
          ),
        ),

        // Bottom-Right Live Site Telemetry HUD
        Positioned(
          bottom: 38,
          right: isDesktop ? 60 : 20,
          child: Opacity(
            opacity: opacity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFieldTelemetryChip(
                  icon: Icons.shield_rounded,
                  label: 'ZERO-INCIDENT OSHA',
                  val: '18M MAN-HOURS',
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 12),
                  _buildFieldTelemetryChip(
                    icon: Icons.corporate_fare_rounded,
                    label: 'ACTIVE CONTRACTS',
                    val: r'$4.8B CONTRACTED',
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Stage 2: STRUCTURAL METALLURGY ERECTION ZONE ──────────────────────────
  Widget _buildStage2Structural(bool isDesktop, double opacity) {
    return Positioned(
      top: isDesktop ? 110 : 80,
      right: isDesktop ? 60 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 660 : double.infinity,
          ),
          child: SiteErectionNoticeBoard(
            isDesktop: isDesktop,
            alignRight: isDesktop,
            tag: '01 / STRUCTURAL METALLURGY',
            title: 'SUPERTALL TOWERS &\nTITANIUM EXOSKELETONS',
            accent: 'ROBOTIC WELDING & HIGH-TENSILE GRADE 65 STEEL',
            desc:
                'High-tensile Grade 65 structural steel trusses fabricated with robotic automated welding, capable of withstanding Cat 5 hurricane wind loads and seismic shear.',
          ),
        ),
      ),
    );
  }

  // ── Stage 3: MASSIVE CIVIL INFRASTRUCTURE & POST-TENSIONED SLABS ──────────
  Widget _buildStage3CivilInfrastructure(bool isDesktop, double opacity) {
    return Positioned(
      top: isDesktop ? 130 : 80,
      left: isDesktop ? 60 : 20,
      right: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 680 : double.infinity,
          ),
          child: SiteErectionNoticeBoard(
            isDesktop: isDesktop,
            alignRight: false,
            tag: '02 / MASSIVE INFRASTRUCTURE',
            title: 'POST-TENSIONED CONCRETE &\nPARAMETRIC ARCHITECTURE',
            accent: 'CARBON-CURED CONCRETE & LASER GPS LEVELING',
            desc:
                'Specialized high-density, carbon-cured concrete poured with precision laser GPS leveling, achieving 120-year design life across ports, bridges, and civic landmarks.',
          ),
        ),
      ),
    );
  }

  // ── Stage 4: PORTFOLIO ACCESS PORTAL ──────────────────────────────────────
  Widget _buildStage4MasterworkGate(
    bool isDesktop,
    double opacity,
    VoidCallback? onTap,
  ) {
    return Positioned(
      bottom: isDesktop ? 65 : 40,
      right: isDesktop ? 60 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 640 : double.infinity,
          ),
          child: Column(
            crossAxisAlignment: isDesktop
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isDesktop) ...[
                    Container(
                      width: 24,
                      height: 3,
                      color: JsConstructionTheme.kSafetyAmber,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '03 / MASTERWORK COLLECTION',
                    style: GoogleFonts.spaceGrotesk(
                      color: JsConstructionTheme.kSafetyAmber,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 8),
                    Container(
                      width: 24,
                      height: 3,
                      color: JsConstructionTheme.kSafetyAmber,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'PRECISION CRAFT\nAT SCALE',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.plusJakartaSans(
                  color: JsConstructionTheme.kSteel,
                  fontSize: isDesktop ? 54 : 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isDesktop ? -1.5 : -0.6,
                  height: 1.04,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'EXPLORE COMPLETED & ACTIVE MEGASPACES',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.spaceGrotesk(
                  color: JsConstructionTheme.kSafetyAmberGlow,
                  fontSize: isDesktop ? 13 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 18),
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 26 : 18,
                    vertical: isDesktop ? 15 : 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        JsConstructionTheme.kSafetyAmber,
                        Color(0xFFD97706),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: JsConstructionTheme.kSafetyAmber.withValues(
                          alpha: 0.4,
                        ),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'INSPECT ACTIVE SITE WORKS',
                          style: GoogleFonts.spaceGrotesk(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: isDesktop ? 12 : 10.5,
                            letterSpacing: 0.5,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldTelemetryChip({
    required IconData icon,
    required String label,
    required String val,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.75),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: JsConstructionTheme.kSiteBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: JsConstructionTheme.kSafetyAmber, size: 14),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.spaceGrotesk(
                      color: JsConstructionTheme.kSteelMuted,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    val,
                    style: GoogleFonts.spaceGrotesk(
                      color: JsConstructionTheme.kSteel,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
