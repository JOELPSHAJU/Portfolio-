import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/js_construction_theme.dart';

/// Monumental Site Entrance Board mounted to structural posts
class SiteEntranceSignBoard extends StatelessWidget {
  final bool isDesktop;
  final String badge;
  final String title;
  final String subtitle;
  final String body;

  const SiteEntranceSignBoard({
    super.key,
    required this.isDesktop,
    required this.badge,
    required this.title,
    required this.subtitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : 20),
      decoration: BoxDecoration(
        color: JsConstructionTheme.kSiteCharcoal.withValues(
          alpha: 0.88,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: JsConstructionTheme.kSafetyAmber.withValues(
            alpha: 0.7,
          ),
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.8),
            blurRadius: 36,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Corner mounting hex rivets
          _buildCornerBolt(top: 0, left: 0),
          _buildCornerBolt(top: 0, right: 0),
          _buildCornerBolt(bottom: 0, left: 0),
          _buildCornerBolt(bottom: 0, right: 0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: JsConstructionTheme.kSafetyAmber,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_rounded,
                      color: JsConstructionTheme.kSafetyAmber,
                      size: 15,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      badge,
                      style: GoogleFonts.spaceGrotesk(
                        color: JsConstructionTheme.kSafetyAmber,
                        fontSize: isDesktop ? 10.5 : 9.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: JsConstructionTheme.kSteel,
                  fontSize: isDesktop ? 70 : 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: isDesktop ? -1.8 : -0.8,
                  height: 1.02,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 36,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: GoogleFonts.spaceGrotesk(
                  color: JsConstructionTheme.kSafetyAmberGlow,
                  fontSize: isDesktop ? 15 : 12.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                body,
                style: GoogleFonts.plusJakartaSans(
                  color: JsConstructionTheme.kSteel.withValues(
                    alpha: 0.92,
                  ),
                  fontSize: isDesktop ? 15.5 : 13.5,
                  height: 1.6,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCornerBolt({
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
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF4B5563),
          border: Border.all(
            color: JsConstructionTheme.kSafetyAmber,
            width: 1,
          ),
        ),
      ),
    );
  }
}

/// Site Erection Notice Board for Stages 2 & 3
class SiteErectionNoticeBoard extends StatelessWidget {
  final bool isDesktop;
  final bool alignRight;
  final String tag;
  final String title;
  final String accent;
  final String desc;

  const SiteErectionNoticeBoard({
    super.key,
    required this.isDesktop,
    required this.alignRight,
    required this.tag,
    required this.title,
    required this.accent,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!alignRight) ...[
              Container(
                width: 24,
                height: 3,
                color: JsConstructionTheme.kSafetyAmber,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              tag,
              style: GoogleFonts.spaceGrotesk(
                color: JsConstructionTheme.kSafetyAmber,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
            if (alignRight) ...[
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
          title,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            color: JsConstructionTheme.kSteel,
            fontSize: isDesktop ? 50 : 28,
            fontWeight: FontWeight.w900,
            letterSpacing: isDesktop ? -1.2 : -0.5,
            height: 1.05,
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
          accent,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.spaceGrotesk(
            color: JsConstructionTheme.kSafetyAmberGlow,
            fontSize: isDesktop ? 13 : 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          desc,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: GoogleFonts.plusJakartaSans(
            color: JsConstructionTheme.kSteelMuted,
            fontSize: isDesktop ? 15 : 13,
            height: 1.6,
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }
}
