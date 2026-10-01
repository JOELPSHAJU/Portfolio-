import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../painters/dossier_card_background_painter.dart';

/// Field Superintendent Dossier Badge Card (Zone 05 Leadership)
class FieldSuperintendentDossierCard extends StatefulWidget {
  final String name;
  final String role;
  final String cred;
  final String badgeId;
  final IconData icon;

  const FieldSuperintendentDossierCard({
    super.key,
    required this.name,
    required this.role,
    required this.cred,
    required this.badgeId,
    this.icon = Icons.engineering_rounded,
  });

  @override
  State<FieldSuperintendentDossierCard> createState() =>
      _FieldSuperintendentDossierCardState();
}

class _FieldSuperintendentDossierCardState
    extends State<FieldSuperintendentDossierCard> {
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
          painter: DossierCardBackgroundPainter(
            stepDown: 12.0,
            cornerRadius: 8.0,
            borderColor: _isHovered
                ? const Color(0xFFFF9F1C).withValues(alpha: 0.85)
                : const Color(0xFF223548),
            fillColor: const Color(0xF0070B12),
            isHovered: _isHovered,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Row: Circular Avatar nestled on left + Corps ID Badge on right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Avatar Container
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0x28FF9F1C),
                        shape: BoxShape.circle,
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
                          size: 20,
                        ),
                      ),
                    ),
                    // Corps ID Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF090D14),
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: const Color(
                            0xFFFF9F1C,
                          ).withValues(alpha: 0.55),
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        widget.badgeId,
                        style: GoogleFonts.spaceGrotesk(
                          color: const Color(0xFFFF9F1C),
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  widget.name,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),

                // Role (Safety Amber)
                Text(
                  widget.role,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color(0xFFFF9F1C),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 8),

                // Credentials / Specialty
                Text(
                  widget.cred,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF94A3B8),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
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
