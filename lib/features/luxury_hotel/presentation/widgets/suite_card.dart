import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../domain/entities/suite.dart';
import '../theme/luxury_hotel_colors.dart';

class SuiteCard extends StatefulWidget {
  final Suite suite;
  final String sanctuaryNumber;
  final bool isDesktop;
  final bool isTablet;
  final VoidCallback onReserve;
  final VoidCallback onExplore;

  const SuiteCard({
    super.key,
    required this.suite,
    required this.sanctuaryNumber,
    required this.isDesktop,
    required this.isTablet,
    required this.onReserve,
    required this.onExplore,
  });

  @override
  State<SuiteCard> createState() => _SuiteCardState();
}

class _SuiteCardState extends State<SuiteCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.suite;
    final isPremier = s.id == 'royal_penthouse';
    final double cardHeight = widget.isDesktop
        ? 520.0
        : (widget.isTablet ? 480.0 : 470.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: kGold.withValues(
                alpha: _isHovered ? 0.30 : (isPremier ? 0.12 : 0.05),
              ),
              blurRadius: _isHovered ? 32 : 18,
              spreadRadius: _isHovered ? 2 : 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── 1. The Architectural Photograph (The 100% Star Attraction) ──
              AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 650),
                curve: Curves.easeOutCubic,
                child: AppImage(
                  assetPath: s.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),

              // ── 2. Atmospheric Haute-Luxury Gradient Scrims ───────────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.65),
                      Colors.black.withValues(alpha: 0.10),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.50),
                      const Color(0xFF08090D).withValues(alpha: 0.96),
                    ],
                    stops: const [0.0, 0.18, 0.42, 0.68, 1.0],
                  ),
                ),
              ),

              // ── 3. Subtle Outer Gold Highlight Border ─────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isHovered
                        ? kGold
                        : (isPremier
                            ? kGold.withValues(alpha: 0.45)
                            : kGold.withValues(alpha: 0.20)),
                    width: _isHovered ? 1.8 : 1.2,
                  ),
                ),
              ),

              // ── 4. Floating Top Architectural Badges ───────────────────────
              Positioned(
                top: widget.isDesktop ? 18 : 12,
                left: widget.isDesktop ? 18 : 12,
                right: widget.isDesktop ? 18 : 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Sanctuary Identifier Badge
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.isDesktop ? 14 : 10,
                              vertical: widget.isDesktop ? 7 : 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.68),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: isPremier
                                    ? kGold
                                    : kGold.withValues(alpha: 0.40),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isPremier
                                      ? Icons.hotel_class_rounded
                                      : Icons.star_rounded,
                                  size: widget.isDesktop ? 13 : 11,
                                  color: kGold,
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    widget.isDesktop
                                        ? 'SANCTUARY ${widget.sanctuaryNumber}  •  ${s.badge}'
                                        : '0${widget.sanctuaryNumber} • ${s.badge}',
                                    style: GoogleFonts.spaceMono(
                                      color: kGold,
                                      fontSize: widget.isDesktop ? 10 : 8.5,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: widget.isDesktop
                                          ? 1.5
                                          : 0.8,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Price Tag Glass Pill
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.isDesktop ? 16 : 10,
                            vertical: widget.isDesktop ? 7 : 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: kGold.withValues(alpha: 0.45),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                s.price,
                                style: GoogleFonts.cinzel(
                                  color: kGold,
                                  fontSize: widget.isDesktop ? 16 : 13.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                ' ${s.period}',
                                style: GoogleFonts.outfit(
                                  color: kIvory.withValues(alpha: 0.85),
                                  fontSize: widget.isDesktop ? 11 : 9.5,
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

              // ── 5. Center Gallery Reticle (Appears on Hover) ───────────────
              Positioned.fill(
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 280),
                    opacity: _isHovered ? 1.0 : 0.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: InkWell(
                          onTap: widget.onExplore,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 13,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.70),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: kGold,
                                width: 1.4,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kGold.withValues(alpha: 0.40),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.fullscreen_rounded,
                                  color: kGold,
                                  size: 19,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'VIEW ARCHITECTURAL GALLERY',
                                  style: GoogleFonts.cinzel(
                                    color: kIvory,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ── 6. Bottom Floating Editorial Pedestal ─────────────────────
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(widget.isDesktop ? 26.0 : 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Subtitle & Specs Row
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 16,
                                height: 1.5,
                                color: kGold,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${s.category.toUpperCase()} SANCTUARY',
                                style: GoogleFonts.spaceMono(
                                  color: kGoldLight,
                                  fontSize: widget.isDesktop ? 10 : 8.5,
                                  letterSpacing: widget.isDesktop ? 2 : 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFloatingSpec(
                                Icons.square_foot_rounded,
                                s.sqm,
                              ),
                              const SizedBox(width: 6),
                              _buildFloatingSpec(
                                Icons.people_outline_rounded,
                                s.guests,
                              ),
                              if (widget.isDesktop) ...[
                                const SizedBox(width: 6),
                                _buildFloatingSpec(
                                  Icons.visibility_outlined,
                                  s.view,
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Grand Cinzel Sanctuary Title
                      Text(
                        s.title,
                        style: GoogleFonts.cinzel(
                          color: kIvory,
                          fontSize: widget.isDesktop
                              ? 26
                              : (widget.isTablet ? 22 : 19),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.95),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Description
                      Text(
                        s.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          color: kIvory.withValues(alpha: 0.88),
                          fontSize: 13,
                          height: 1.45,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.9),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Bottom Action Row
                      if (widget.isDesktop || widget.isTablet)
                        Row(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.shield_outlined,
                                  color: kGold,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Dedicated Royal Butler & Helipad Transfer',
                                  style: GoogleFonts.spaceMono(
                                    color: kGoldLight.withValues(alpha: 0.8),
                                    fontSize: 9.5,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            OutlinedButton(
                              onPressed: widget.onExplore,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: kIvory,
                                side: BorderSide(
                                  color: kGold.withValues(alpha: 0.45),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Text(
                                'EXPLORE',
                                style: GoogleFonts.cinzel(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: widget.onReserve,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kGold,
                                foregroundColor: kObsidian,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 12,
                                ),
                                elevation: 6,
                                shadowColor: kGold.withValues(alpha: 0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'RESERVE',
                                    style: GoogleFonts.cinzel(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: widget.onExplore,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: kIvory,
                                  side: BorderSide(
                                    color: kGold.withValues(alpha: 0.45),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  'EXPLORE',
                                  style: GoogleFonts.cinzel(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: widget.onReserve,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kGold,
                                  foregroundColor: kObsidian,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'RESERVE',
                                      style: GoogleFonts.cinzel(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 12,
                                    ),
                                  ],
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

  Widget _buildFloatingSpec(IconData icon, String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: kGold.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: kGold),
              const SizedBox(width: 5),
              Text(
                text,
                style: GoogleFonts.spaceMono(
                  color: kIvory,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
