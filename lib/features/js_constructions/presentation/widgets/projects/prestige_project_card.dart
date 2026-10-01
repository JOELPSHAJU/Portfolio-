import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/construction_project.dart';

/// Prestige Project Card — full-bleed image with bottom fade overlay
class PrestigeProjectCard extends StatefulWidget {
  final PrestigeProject project;

  const PrestigeProjectCard({super.key, required this.project});

  @override
  State<PrestigeProjectCard> createState() => _PrestigeProjectCardState();
}

class _PrestigeProjectCardState extends State<PrestigeProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final proj = widget.project;
    final Color statusColor = proj.statusColor;
    final String status = proj.status;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _hovered ? 0.65 : 0.3),
              blurRadius: _hovered ? 32 : 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Full-bleed project photo ──
              AnimatedScale(
                scale: _hovered ? 1.06 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                child: Image.asset(proj.image, fit: BoxFit.cover),
              ),

              // ── Bottom-to-top dark gradient fade ──
              Positioned.fill(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        const Color(
                          0xFF0D0F14,
                        ).withValues(alpha: _hovered ? 0.92 : 0.82),
                      ],
                      stops: const [0.0, 0.35, 1.0],
                    ),
                  ),
                ),
              ),

              // ── Status badge — top left ──
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0D12).withValues(alpha: 0.82),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: statusColor,
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withValues(alpha: 0.6),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status,
                        style: GoogleFonts.spaceGrotesk(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Content overlay — slides up on hover ──
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSlide(
                  offset: _hovered ? Offset.zero : const Offset(0, 0.06),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Title + location + description
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                proj.title,
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  height: 1.25,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.black54,
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color(0xFFCBD5E1),
                                    size: 12,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    proj.location,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFFCBD5E1),
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                proj.desc,
                                style: GoogleFonts.plusJakartaSans(
                                  color: const Color(
                                    0xFFCBD5E1,
                                  ).withValues(alpha: 0.80),
                                  fontSize: 12,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Circular arrow button
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _hovered
                                  ? const Color(0xFFFF9F1C)
                                  : Colors.white.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                            color: _hovered
                                ? const Color(0xFFFF9F1C).withValues(alpha: 0.2)
                                : Colors.transparent,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: _hovered
                                ? const Color(0xFFFF9F1C)
                                : Colors.white.withValues(alpha: 0.8),
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
