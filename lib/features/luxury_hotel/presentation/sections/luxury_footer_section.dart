import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/luxury_hotel_colors.dart';

class LuxuryFooterSection extends StatelessWidget {
  final bool isDesktop;
  final bool isTablet;

  const LuxuryFooterSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF040508),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 24,
        vertical: 70,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop ? 40 : 24),
            decoration: BoxDecoration(
              color: kCharcoal,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kGold.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'THE CONNOISSEURS SOCIETY',
                        style: GoogleFonts.spaceMono(
                          color: kGold,
                          fontSize: 11,
                          letterSpacing: 2.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Receive Private Suite Releases & Sommelier Invitations',
                        style: GoogleFonts.cinzel(
                          color: kIvory,
                          fontSize: isDesktop ? 22 : 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isDesktop) ...[
                  const SizedBox(width: 32),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: GoogleFonts.outfit(color: kIvory),
                      decoration: InputDecoration(
                        hintText: 'Enter your private email...',
                        hintStyle: GoogleFonts.outfit(color: kMuted),
                        filled: true,
                        fillColor: kObsidian,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: kGold.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: kGold),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kCharcoal,
                          content: Text(
                            'Thank you. Your invitation to the Connoisseurs Circle is confirmed.',
                            style: GoogleFonts.outfit(color: kGold),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGold,
                      foregroundColor: kObsidian,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'JOIN',
                      style: GoogleFonts.cinzel(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 60),

          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.hotel_class_rounded,
                          color: kGold,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'THE LUMINA PALACE',
                          style: GoogleFonts.cinzel(
                            color: kIvory,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Cap d’Antibes • French Riviera\n43°32\'58.4"N 7°07\'16.2"E\nDirect Private Helipad 06/24',
                      style: GoogleFonts.outfit(
                        color: kMuted,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                _buildFooterLinks('SANCTUARIES', const [
                  'Royal Imperial Penthouse',
                  'Platinum Ocean Suite',
                  'The Azure Lagoon Villa',
                  'Grand Horizon Suite',
                  'Private Island Cabanas',
                ]),
                _buildFooterLinks('EXPERIENCES', const [
                  "L'Étoile Céeste (3 Michelin)",
                  'Mirage Raw Bar & Lounge',
                  'Soma Thalasso Grotto Spa',
                  'Superyacht Catamaran Berth',
                  'Helicopter Transfers',
                ]),
                _buildFooterLinks('PRIVATE CONCIERGE', const [
                  '+33 (0)4 93 61 38 00',
                  'butler@luminapalace.com',
                  'Helipad Desk: Desk-7 Bravo',
                  'Les Clefs d’Or Sanctioned',
                  'Press & Architecture Inquiries',
                ]),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THE LUMINA PALACE & SPA',
                  style: GoogleFonts.cinzel(
                    color: kIvory,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cap d’Antibes • French Riviera • Private Marina & Helipad',
                  style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
                ),
              ],
            ),

          const SizedBox(height: 50),
          Divider(color: kGold.withValues(alpha: 0.15)),
          const SizedBox(height: 24),

          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Text(
                '© 2026 THE LUMINA PALACE & SPA RESORT. ALL RIGHTS RESERVED.',
                style: GoogleFonts.spaceMono(
                  color: kMuted.withValues(alpha: 0.6),
                  fontSize: 10,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'PORTFOLIO SHOWCASE UI • FLUTTER WEB',
                style: GoogleFonts.spaceMono(
                  color: kGold.withValues(alpha: 0.8),
                  fontSize: 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.cinzel(
            color: kGold,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 14),
        ...links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              link,
              style: GoogleFonts.outfit(color: kMuted, fontSize: 13),
            ),
          );
        }),
      ],
    );
  }
}
