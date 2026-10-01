import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/trust_badge.dart';
import '../theme/purelis_colors.dart';
import '../widgets/purelis_social_icons.dart';
import '../widgets/skincare_button.dart';
import '../widgets/trust_badge_item.dart';

class FooterSection extends StatefulWidget {
  final bool isDesktop;
  final bool isTablet;
  final GlobalKey? sectionKey;

  const FooterSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    this.sectionKey,
  });

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final TextEditingController _newsletterController = TextEditingController();

  @override
  void dispose() {
    _newsletterController.dispose();
    super.dispose();
  }

  void _handleSubscribe() {
    final email = _newsletterController.text.trim();
    if (email.isNotEmpty && email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: PurelisColors.topBarGreen,
          content: Text(
            'Thank you for subscribing to Purelis Skincare updates!',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
        ),
      );
      _newsletterController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: PurelisColors.errorRed,
          content: Text(
            'Please enter a valid email address.',
            style: GoogleFonts.outfit(color: Colors.white),
          ),
        ),
      );
    }
  }

  void _handleLearnMore() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: PurelisColors.topBarGreen,
        content: Text(
          'Purelis Skincare: Certified cruelty-free, vegan & eco-formulated.',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.sectionKey,
      color: PurelisColors.footerBg,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isDesktop ? 60 : 20,
        vertical: 50,
      ),
      child: widget.isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column 1: Trust Badges
                Expanded(flex: 3, child: _buildTrustBadgesColumn()),
                const SizedBox(width: 40),
                // Column 2: Newsletter Subscription
                Expanded(flex: 4, child: _buildNewsletterColumn()),
                const SizedBox(width: 50),
                // Column 3: About Purelis
                Expanded(flex: 4, child: _buildAboutColumn()),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTrustBadgesColumn(),
                const Divider(height: 50, color: PurelisColors.dividerFooter),
                _buildNewsletterColumn(),
                const Divider(height: 50, color: PurelisColors.dividerFooter),
                _buildAboutColumn(),
              ],
            ),
    );
  }

  Widget _buildTrustBadgesColumn() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrustBadgeItem(
          badge: TrustBadge(
            icon: 'local_shipping_outlined',
            title: 'FREE SHIPPING',
            subtitle: 'On orders over ₹499',
          ),
        ),
        SizedBox(height: 22),
        TrustBadgeItem(
          badge: TrustBadge(
            icon: 'cached_rounded',
            title: 'EASY RETURNS',
            subtitle: '14 days return policy',
          ),
        ),
        SizedBox(height: 22),
        TrustBadgeItem(
          badge: TrustBadge(
            icon: 'verified_user_outlined',
            title: 'SECURE PAYMENT',
            subtitle: '100% secure checkout',
          ),
        ),
      ],
    );
  }

  Widget _buildNewsletterColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUBSCRIBE TO OUR NEWSLETTER',
          style: GoogleFonts.outfit(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: PurelisColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Get exclusive offers, beauty tips & new product updates.',
          style: GoogleFonts.outfit(
            fontSize: 12.5,
            color: PurelisColors.textMuted,
          ),
        ),
        const SizedBox(height: 18),

        // Input + Subscribe button row
        Row(
          children: [
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: PurelisColors.inputBorder),
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: _newsletterController,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: PurelisColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Enter your email address',
                    hintStyle: GoogleFonts.outfit(
                      fontSize: 12.5,
                      color: const Color(0xFF9E9E9E),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 11),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SkincareButton(
              label: 'SUBSCRIBE',
              onTap: _handleSubscribe,
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Social Icons Row
        const Row(
          children: [
            FooterSocialIcon(type: 'f', tooltip: 'Facebook'),
            SizedBox(width: 14),
            FooterSocialIcon(type: 'ig', tooltip: 'Instagram'),
            SizedBox(width: 14),
            FooterSocialIcon(type: 'yt', tooltip: 'YouTube'),
            SizedBox(width: 14),
            FooterSocialIcon(type: 'p', tooltip: 'Pinterest'),
          ],
        ),
      ],
    );
  }

  Widget _buildAboutColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ABOUT PURELIS',
          style: GoogleFonts.outfit(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: PurelisColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'At Purelis, we believe in the power of nature and science working together to bring out your natural glow. Pure, effective and derived with care for you and the planet.',
          style: GoogleFonts.outfit(
            fontSize: 12.5,
            color: const Color(0xFF4C584E),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 14),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: _handleLearnMore,
            child: Text(
              'LEARN MORE',
              style: GoogleFonts.outfit(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: PurelisColors.topBarGreen,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
