import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/purelis_colors.dart';
import '../widgets/purelis_social_icons.dart';

class TopAnnouncementSection extends StatelessWidget {
  final bool isDesktop;

  const TopAnnouncementSection({
    super.key,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PurelisColors.topBarGreen,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Offer text
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Free shipping on orders over ₹499 | Use code: PURE20 for 20% OFF 🌿',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: isDesktop ? 12.0 : 10.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Right Social Icons
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TopBarSocialIcon(type: 'f', tooltip: 'Facebook'),
              SizedBox(width: 14),
              TopBarSocialIcon(type: 'ig', tooltip: 'Instagram'),
              SizedBox(width: 14),
              TopBarSocialIcon(type: 'yt', tooltip: 'YouTube'),
            ],
          ),
        ],
      ),
    );
  }
}
