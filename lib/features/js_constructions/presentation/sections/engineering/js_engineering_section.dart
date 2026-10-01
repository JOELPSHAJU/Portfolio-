import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../painters/diagonal_accent_painter.dart';
import '../../painters/tech_card_background_painter.dart';
import '../../theme/js_construction_theme.dart';
import '../../widgets/engineering/structural_blueprint_system_tile.dart';

/// ZONE 04: ADVANCED ENGINEERING & PROPRIETARY CIVIL SYSTEMS
class JsEngineeringSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;

  const JsEngineeringSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: isDesktop ? 60 : (isTablet ? 30 : 16),
      vertical: 60,
    );

    return Container(
      color: JsConstructionTheme.kObsidian,
      child: Stack(
        children: [
          // 1. Realistic Construction Background Image with Worker, Scaffolding & Cranes
          Positioned.fill(
            child: Image.asset(
              'assets/foundation_construction_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
          ),

          // 2. Atmospheric vignette & gradient scrim to ensure cards & text pop
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.90),
                    Colors.black.withValues(alpha: 0.72),
                    Colors.black.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.78, 1.0],
                ),
              ),
            ),
          ),

          // 3. Subtle edge blend into obsidian background for adjacent sections
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    JsConstructionTheme.kObsidian.withValues(alpha: 0.70),
                    Colors.transparent,
                    Colors.transparent,
                    JsConstructionTheme.kObsidian.withValues(alpha: 0.75),
                  ],
                  stops: const [0.0, 0.08, 0.92, 1.0],
                ),
              ),
            ),
          ),

          // 4. Content Area
          Padding(
            padding: padding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // On desktop, keep the content container to ~68% of section width
                // so the construction worker and atmospheric background stay visible on the right
                final double contentWidth = isDesktop
                    ? (constraints.maxWidth * 0.68).clamp(620.0, 920.0)
                    : double.infinity;

                return Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Section Eyebrow & Main Title ──
                        Row(
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9F1C),
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '03 / PROPRIETARY ENGINEERING PATENTS',
                              style: GoogleFonts.spaceGrotesk(
                                color: const Color(0xFFFF9F1C),
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ZONE 04 / CIVIL & STRUCTURAL SYSTEMS',
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF64748B),
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'FOUNDATION & ADVANCED\n',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: isDesktop
                                      ? 34
                                      : (isTablet ? 28 : 22),
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                  height: 1.15,
                                ),
                              ),
                              TextSpan(
                                text: 'ARCHITECTURAL SYSTEMS',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: isDesktop
                                      ? 34
                                      : (isTablet ? 28 : 22),
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFFFF9F1C),
                                  letterSpacing: -0.5,
                                  height: 1.15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Innovative structural solutions built for strength, precision and long-term performance.',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF94A3B8),
                            fontSize: isDesktop ? 14.5 : 13,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // ── 2x2 Tech Blueprint Cards Grid ──
                        if (isDesktop || constraints.maxWidth >= 640)
                          const Column(
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: StructuralBlueprintSystemTile(
                                        num: '01',
                                        code: 'SYS-BIM-LIDAR',
                                        title:
                                            'Autonomous Drone LiDAR & Digital Twin',
                                        desc:
                                            'Daily centimeter-accurate point-cloud scans integrated with BIM Level 3 D timeline simulation.',
                                        icon: Icons.track_changes_rounded,
                                        spec: 'TOLERANCE ±2mm · RTK GPS',
                                        corner: TechCardCorner.topLeft,
                                        hasOrangeAccent: false,
                                      ),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: StructuralBlueprintSystemTile(
                                        num: '02',
                                        code: 'SYS-STL-METALLURGY',
                                        title:
                                            'High-Tensile Structural Steelwork',
                                        desc:
                                            'Robotic flux-cored arc welding and automated ultrasonic non-destructive testing for supertall nodes.',
                                        icon: Icons.handyman_rounded,
                                        spec: 'GRADE 65 · ASTM A992 SPEC',
                                        corner: TechCardCorner.topRight,
                                        hasOrangeAccent: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: StructuralBlueprintSystemTile(
                                        num: '03',
                                        code: 'SYS-CNC-POST-TENSION',
                                        title:
                                            'Post-Tensioned Concrete & Pre-Cast',
                                        desc:
                                            'Self-consolidating high-performance concrete with internal fiber reinforcement for 100+ year design life.',
                                        icon: Icons.view_in_ar_rounded,
                                        spec: 'C50/60 · CO2-MINERALIZED',
                                        corner: TechCardCorner.topLeft,
                                        hasOrangeAccent: false,
                                      ),
                                    ),
                                    SizedBox(width: 18),
                                    Expanded(
                                      child: StructuralBlueprintSystemTile(
                                        num: '04',
                                        code: 'SYS-HYD-SEISMIC',
                                        title:
                                            'Seismic Viscous & Tuned Mass Dampers',
                                        desc:
                                            'Advanced hydraulic sway mitigation absorbing wind drift on towers up to 600m height.',
                                        icon: Icons.monitor_heart_rounded,
                                        spec: 'CAT 5 HURRICANE · ZONE 4',
                                        corner: TechCardCorner.topRight,
                                        hasOrangeAccent: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          const Column(
                            children: [
                              StructuralBlueprintSystemTile(
                                num: '01',
                                code: 'SYS-BIM-LIDAR',
                                title: 'Autonomous Drone LiDAR & Digital Twin',
                                desc:
                                    'Daily centimeter-accurate point-cloud scans integrated with BIM Level 3 D timeline simulation.',
                                icon: Icons.track_changes_rounded,
                                spec: 'TOLERANCE ±2mm · RTK GPS',
                                corner: TechCardCorner.topLeft,
                                hasOrangeAccent: false,
                              ),
                              SizedBox(height: 16),
                              StructuralBlueprintSystemTile(
                                num: '02',
                                code: 'SYS-STL-METALLURGY',
                                title: 'High-Tensile Structural Steelwork',
                                desc:
                                    'Robotic flux-cored arc welding and automated ultrasonic non-destructive testing for supertall nodes.',
                                icon: Icons.handyman_rounded,
                                spec: 'GRADE 65 · ASTM A992 SPEC',
                                corner: TechCardCorner.topRight,
                                hasOrangeAccent: true,
                              ),
                              SizedBox(height: 16),
                              StructuralBlueprintSystemTile(
                                num: '03',
                                code: 'SYS-CNC-POST-TENSION',
                                title: 'Post-Tensioned Concrete & Pre-Cast',
                                desc:
                                    'Self-consolidating high-performance concrete with internal fiber reinforcement for 100+ year design life.',
                                icon: Icons.view_in_ar_rounded,
                                spec: 'C50/60 · CO2-MINERALIZED',
                                corner: TechCardCorner.topLeft,
                                hasOrangeAccent: false,
                              ),
                              SizedBox(height: 16),
                              StructuralBlueprintSystemTile(
                                num: '04',
                                code: 'SYS-HYD-SEISMIC',
                                title: 'Seismic Viscous & Tuned Mass Dampers',
                                desc:
                                    'Advanced hydraulic sway mitigation absorbing wind drift on towers up to 600m height.',
                                icon: Icons.monitor_heart_rounded,
                                spec: 'CAT 5 HURRICANE · ZONE 4',
                                corner: TechCardCorner.topRight,
                                hasOrangeAccent: true,
                              ),
                            ],
                          ),

                        const SizedBox(height: 24),

                        // ── Bottom Pagination / HUD Blueprint Accents ──
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9F1C),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF64748B),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF334155),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const CustomPaint(
                          size: Size(50, 20),
                          painter: DiagonalAccentPainter(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
