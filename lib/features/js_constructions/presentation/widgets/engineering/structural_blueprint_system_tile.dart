import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../painters/tech_card_background_painter.dart';

/// Structural Blueprint System Tile (Zone 04 Engineering)
class StructuralBlueprintSystemTile extends StatefulWidget {
  final String num;
  final String code;
  final String title;
  final String desc;
  final String spec;
  final IconData icon;
  final TechCardCorner corner;
  final bool hasOrangeAccent;

  const StructuralBlueprintSystemTile({
    super.key,
    required this.num,
    required this.code,
    required this.title,
    required this.desc,
    required this.spec,
    required this.icon,
    this.corner = TechCardCorner.topLeft,
    this.hasOrangeAccent = false,
  });

  @override
  State<StructuralBlueprintSystemTile> createState() =>
      _StructuralBlueprintSystemTileState();
}

class _StructuralBlueprintSystemTileState
    extends State<StructuralBlueprintSystemTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        child: CustomPaint(
          painter: TechCardBackgroundPainter(
            corner: widget.corner,
            chamfer: 24.0,
            cornerRadius: 6.0,
            borderColor: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
                : const Color(0xFF223041),
            fillColor: const Color(0xF00A0E17),
            hasOrangeAccent: widget.hasOrangeAccent,
            isHovered: _isHovered,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row: Icon Box + (Number & Code)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Box
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0x24FF9F1C),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _isHovered
                              ? const Color(0xFFFF9F1C)
                              : const Color(0xFFFF9F1C).withValues(alpha: 0.55),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.icon,
                          color: const Color(0xFFFF9F1C),
                          size: 22,
                        ),
                      ),
                    ),
                    // Number + Code
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.num,
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF64748B),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.code,
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFF64748B),
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Card Title
                Text(
                  widget.title,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Text(
                  widget.desc,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF94A3B8),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom Tag / Spec Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4.5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C1017),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: const Color(0xFFFF9F1C).withValues(alpha: 0.55),
                      width: 1.0,
                    ),
                  ),
                  child: Text(
                    widget.spec,
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFFF9F1C),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
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
