import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class HeroStageFour extends StatelessWidget {
  final bool isDesktop;
  final double opacity;
  final VoidCallback onExploreSuites;

  const HeroStageFour({
    super.key,
    required this.isDesktop,
    required this.opacity,
    required this.onExploreSuites,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: isDesktop ? 70 : 40,
      right: isDesktop ? 64 : 20,
      left: isDesktop ? null : 20,
      child: Opacity(
        opacity: opacity,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : double.infinity,
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
                    Container(width: 24, height: 2, color: kGold),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '03 / THE COLLECTION',
                    style: GoogleFonts.spaceMono(
                      color: kGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3,
                    ),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 8),
                    Container(width: 24, height: 2, color: kGold),
                  ],
                ],
              ),
              const SizedBox(height: 14),
              Text(
                'YOUR SANCTUARY\nAWAITS',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.cinzel(
                  color: kIvory,
                  fontSize: isDesktop ? 54 : 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  height: 1.08,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.95),
                      blurRadius: 36,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'IMPERIAL PENTHOUSES & OVERWATER VILLAS',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.syne(
                  color: kGoldLight,
                  fontSize: isDesktop ? 14 : 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Explore our signature architectural suites featuring private infinity horizon plunges, 24/7 personal butler guild, and dedicated yacht moorings.',
                textAlign: isDesktop ? TextAlign.right : TextAlign.left,
                style: GoogleFonts.outfit(
                  color: kIvory.withValues(alpha: 0.88),
                  fontSize: isDesktop ? 15 : 13,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 24),
              InkWell(
                onTap: onExploreSuites,
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 26 : 18,
                    vertical: isDesktop ? 15 : 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kGold, Color(0xFFD4AF37)],
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: kGold.withValues(alpha: 0.4),
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
                          'EXPLORE SUITES & VILLAS',
                          style: GoogleFonts.spaceMono(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: isDesktop ? 12 : 10,
                            letterSpacing: isDesktop ? 2 : 1.2,
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
}
