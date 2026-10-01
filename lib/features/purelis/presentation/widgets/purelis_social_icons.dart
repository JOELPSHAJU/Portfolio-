import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBarSocialIcon extends StatelessWidget {
  final String type;
  final String tooltip;
  final VoidCallback? onTap;

  const TopBarSocialIcon({
    super.key,
    required this.type,
    required this.tooltip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 16,
            height: 16,
            child: Center(
              child: type == 'f'
                  ? Text(
                      'f',
                      style: GoogleFonts.libreBaskerville(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : type == 'ig'
                  ? const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 13,
                    )
                  : const Icon(
                      Icons.play_circle_outline_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class FooterSocialIcon extends StatelessWidget {
  final String type;
  final String tooltip;
  final VoidCallback? onTap;

  const FooterSocialIcon({
    super.key,
    required this.type,
    required this.tooltip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD6D2C7)),
            ),
            child: Center(
              child: type == 'f'
                  ? Text(
                      'f',
                      style: GoogleFonts.libreBaskerville(
                        color: const Color(0xFF2C3E2F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : type == 'ig'
                  ? const Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xFF2C3E2F),
                      size: 14,
                    )
                  : type == 'yt'
                  ? const Icon(
                      Icons.play_arrow_rounded,
                      color: Color(0xFF2C3E2F),
                      size: 16,
                    )
                  : Text(
                      'P',
                      style: GoogleFonts.cormorantGaramond(
                        color: const Color(0xFF2C3E2F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
