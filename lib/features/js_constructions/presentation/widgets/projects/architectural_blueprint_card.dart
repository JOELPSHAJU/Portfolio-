import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../../domain/entities/construction_project.dart';
import '../../painters/blueprint_grid_painter.dart';
import '../../painters/hazard_stripe_painter.dart';
import '../../theme/js_construction_theme.dart';

/// Architectural Blueprint Project Card (Technical Drafting Table Concept)
class ArchitecturalBlueprintCard extends StatefulWidget {
  final ConstructionProject project;
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onInspect;

  const ArchitecturalBlueprintCard({
    super.key,
    required this.project,
    required this.isDesktop,
    required this.isTablet,
    required this.onInspect,
  });

  @override
  State<ArchitecturalBlueprintCard> createState() =>
      _ArchitecturalBlueprintCardState();
}

class _ArchitecturalBlueprintCardState
    extends State<ArchitecturalBlueprintCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final double cardHeight = widget.isDesktop
        ? 510.0
        : (widget.isTablet ? 490.0 : 470.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: JsConstructionTheme.kSafetyAmber.withValues(
                alpha: _isHovered ? 0.35 : 0.08,
              ),
              blurRadius: _isHovered ? 30 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // High-Res Architectural Photograph
              AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                child: AppImage(
                  assetPath: p.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // Architectural Blueprint Drafting Table Grid Overlay
              Positioned.fill(
                child: CustomPaint(
                  painter: BlueprintGridPainter(
                    lineColor: Color(_isHovered ? 0x2200C0FF : 0x12FFFFFF),
                    step: 28.0,
                  ),
                ),
              ),

              // Architectural Darkening Scrim
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.70),
                      Colors.black.withValues(alpha: 0.15),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.65),
                      JsConstructionTheme.kObsidian.withValues(
                        alpha: 0.98,
                      ),
                    ],
                    stops: const [0.0, 0.20, 0.45, 0.70, 1.0],
                  ),
                ),
              ),

              // Galvanized Outer Metal Border
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _isHovered
                        ? JsConstructionTheme.kSafetyAmber
                        : JsConstructionTheme.kSiteBorder,
                    width: _isHovered ? 1.8 : 1.2,
                  ),
                ),
              ),

              // Corner Drafting Table Rivets
              _buildCornerRivet(top: 8, left: 8),
              _buildCornerRivet(top: 8, right: 8),
              _buildCornerRivet(bottom: 8, left: 8),
              _buildCornerRivet(bottom: 8, right: 8),

              // Bottom Hazard Warning Stripe
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 3,
                child: CustomPaint(painter: HazardStripePainter()),
              ),

              // Top Technical Drawing Headers & Drawing Set Tag
              Positioned(
                top: 14,
                left: 14,
                right: 14,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: JsConstructionTheme.kSafetyAmber
                                    .withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.domain_rounded,
                                  size: 11,
                                  color: JsConstructionTheme.kSafetyAmber,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    p.badge,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: JsConstructionTheme.kSafetyAmber,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: JsConstructionTheme.kSiteBorder,
                            ),
                          ),
                          child: Text(
                            p.drawingCode.isNotEmpty ? p.drawingCode : p.year,
                            style: GoogleFonts.spaceGrotesk(
                              color: JsConstructionTheme.kBlueprintCyan,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Blueprint Architectural Specs Pedestal
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(widget.isDesktop ? 22.0 : 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 14,
                                height: 2,
                                color: JsConstructionTheme.kSafetyAmber,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                p.location,
                                style: GoogleFonts.spaceGrotesk(
                                  color: JsConstructionTheme.kSafetyAmberGlow,
                                  fontSize: widget.isDesktop ? 10 : 9,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            p.height,
                            style: GoogleFonts.spaceGrotesk(
                              color: JsConstructionTheme.kSteelMuted,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.title,
                        style: GoogleFonts.plusJakartaSans(
                          color: JsConstructionTheme.kSteel,
                          fontSize: widget.isDesktop ? 22 : 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        p.desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: JsConstructionTheme.kSteelMuted,
                          fontSize: 12.5,
                          height: 1.45,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: widget.onInspect,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: JsConstructionTheme.kSteel,
                                side: BorderSide(
                                  color: JsConstructionTheme.kSafetyAmber
                                      .withValues(alpha: 0.5),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: Text(
                                'VIEW ARCHITECTURAL SPECS',
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildCornerRivet({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF3A3F50),
          border: Border.all(
            color: JsConstructionTheme.kSafetyAmber.withValues(
              alpha: 0.5,
            ),
            width: 0.8,
          ),
        ),
      ),
    );
  }
}
