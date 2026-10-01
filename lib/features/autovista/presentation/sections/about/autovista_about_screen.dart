import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_pillar_card.dart';
import '../../widgets/autovista_screen_header_banner.dart';
import '../../widgets/autovista_stat_item.dart';

class AutovistaAboutScreen extends StatelessWidget {
  final bool isDesktop;

  const AutovistaAboutScreen({super.key, required this.isDesktop});

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 38, color: Colors.grey.shade200);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutovistaScreenHeaderBanner(
          tag: 'PRESTIGE MOBILITY SINCE 2012',
          title: 'THE GO DRIVE STORY',
          subtitle:
              'Redefining luxury vehicle rental through unmatched automotive precision, transparent hospitality, and obsessive attention to customer care.',
          isDesktop: isDesktop,
        ),

        // Brand Narrative Split Section
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isDesktop ? 6 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pioneering Luxury On Demand',
                      style: GoogleFonts.anton(
                        fontSize: 26,
                        color: Colors.black87,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Go Drive was founded on a simple premise: renting a luxury car should be as exhilarating, seamless, and refined as owning one.\n\nFrom our flagship lounge in Kochi to international operations in Dubai, we cater to high-profile executives, visiting luminaries, and passionate driving enthusiasts who refuse to compromise on quality.',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AutovistaColors.cardDark,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'EST. 2012',
                            style: GoogleFonts.spaceMono(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Kochi • Mumbai • Bengaluru • Delhi • Dubai',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isDesktop)
                const SizedBox(width: 40)
              else
                const SizedBox(height: 24),
              Expanded(
                flex: isDesktop ? 6 : 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: const SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: AppImage(
                      assetPath: 'assets/autovista_test_drive.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 4 Milestone Metric Counters
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
            ),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const AutovistaStatItem(num: '15+', label: 'Years Experience'),
                if (isDesktop) _buildVerticalDivider(),
                const AutovistaStatItem(num: '450+', label: 'Luxury Vehicles'),
                if (isDesktop) _buildVerticalDivider(),
                const AutovistaStatItem(num: '48,000+', label: 'Happy Drivers'),
                if (isDesktop) _buildVerticalDivider(),
                const AutovistaStatItem(num: '99.8%', label: 'On-Time Handover'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 36),

        // Core Pillars
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Our Pillars of Excellence',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Flex(
                direction: isDesktop ? Axis.horizontal : Axis.vertical,
                children: [
                  const Expanded(
                    child: AutovistaPillarCard(
                      title: 'Pristine Detailing',
                      desc:
                          'Every car goes through a 150-point diagnostic check and complete interior sterilization prior to key handover.',
                      icon: Icons.clean_hands_outlined,
                    ),
                  ),
                  SizedBox(
                    width: isDesktop ? 16 : 0,
                    height: isDesktop ? 0 : 16,
                  ),
                  const Expanded(
                    child: AutovistaPillarCard(
                      title: 'Transparent Pricing',
                      desc:
                          'Zero hidden insurance deductions, crystal-clear fuel policy, and 48-hour automated deposit refund settlement.',
                      icon: Icons.receipt_long_outlined,
                    ),
                  ),
                  SizedBox(
                    width: isDesktop ? 16 : 0,
                    height: isDesktop ? 0 : 16,
                  ),
                  const Expanded(
                    child: AutovistaPillarCard(
                      title: 'Personal Concierge',
                      desc:
                          'A dedicated fleet manager assigned to your trip 24/7 for route assistance, parking help, and support.',
                      icon: Icons.support_agent_rounded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}
