import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/fleet_machine.dart';
import '../../painters/hazard_stripe_painter.dart';
import '../../theme/js_construction_theme.dart';

/// Heavy Industrial Plant Spotlight Dock
class HeavyMachineSpotlightDock extends StatelessWidget {
  final FleetMachine machine;
  final bool isDesktop;
  final bool isTablet;

  const HeavyMachineSpotlightDock({
    super.key,
    required this.machine,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 36 : 20),
      decoration: BoxDecoration(
        color: JsConstructionTheme.kConcreteSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: JsConstructionTheme.kSafetyAmber.withValues(
            alpha: 0.5,
          ),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Hazard caution line across top of dock
          SizedBox(
            height: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: const CustomPaint(painter: HazardStripePainter()),
            ),
          ),
          const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 768;

              final machineVisual = Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: isWide ? 380 : 260,
                    height: isWide ? 300 : 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          JsConstructionTheme.kSafetyAmber.withValues(
                            alpha: 0.25,
                          ),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    machine.image,
                    height: isWide ? 320 : 220,
                    fit: BoxFit.contain,
                  ),
                ],
              );

              final machineDetails = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: JsConstructionTheme.kSafetyAmber.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: JsConstructionTheme.kSafetyAmber,
                          ),
                        ),
                        child: Text(
                          machine.tag,
                          style: GoogleFonts.spaceGrotesk(
                            color: JsConstructionTheme.kSafetyAmber,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFF22C55E),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'TELEMETRY: OPERATIONAL',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFF22C55E),
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    machine.name,
                    style: GoogleFonts.plusJakartaSans(
                      color: JsConstructionTheme.kSteel,
                      fontSize: isDesktop ? 26 : 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MODEL: ${machine.model} • ${machine.role}',
                    style: GoogleFonts.spaceGrotesk(
                      color: JsConstructionTheme.kSafetyAmberGlow,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    machine.desc,
                    style: GoogleFonts.plusJakartaSans(
                      color: JsConstructionTheme.kSteelMuted,
                      fontSize: 13.5,
                      height: 1.55,
                      letterSpacing: -0.1,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Heavy Spec Pillars
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: JsConstructionTheme.kObsidian,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: JsConstructionTheme.kSiteBorder,
                      ),
                    ),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 12,
                      children: [
                        _buildSpecPill(
                          'OPERATING WEIGHT',
                          machine.weight,
                        ),
                        _buildSpecPill(
                          'POWERTRAIN',
                          machine.power,
                        ),
                        _buildSpecPill(
                          'DIG / BUCKET CAPACITY',
                          machine.depth,
                        ),
                        _buildSpecPill(
                          'CYCLE VELOCITY',
                          machine.speed,
                        ),
                      ],
                    ),
                  ),
                ],
              );

              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: machineVisual),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: machineDetails),
                  ],
                );
              } else {
                return Column(
                  children: [
                    machineVisual,
                    const SizedBox(height: 20),
                    machineDetails,
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpecPill(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            color: JsConstructionTheme.kSafetyAmber,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: GoogleFonts.spaceGrotesk(
            color: JsConstructionTheme.kSteel,
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
