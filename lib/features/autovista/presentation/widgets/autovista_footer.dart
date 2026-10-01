import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/autovista_colors.dart';
import 'autovista_brand_speedometer_icon.dart';

class AutovistaFooter extends StatelessWidget {
  final bool isDesktop;

  const AutovistaFooter({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AutovistaColors.footerDark,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: 48,
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 32,
            runSpacing: 32,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              // Logo & Slogan (Left)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const AutovistaBrandSpeedometerIcon(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'GO DRIVE',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              'PREMIUM CAR RENTAL',
                              style: GoogleFonts.spaceMono(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: AutovistaColors.primaryRed,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your trusted companion for luxury car rentals, airport transfers, and unforgettable road journeys.',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        height: 1.6,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),

              // Links 1: Rental Fleet
              _buildFooterColumn('Rental Fleet', const [
                'Luxury Sedans',
                'Sports & Exotics',
                'SUVs & Vans',
                'Long-Term Leases',
              ]),

              // Links 2: Company
              _buildFooterColumn('Company', const [
                'About Go Drive',
                'Our Team',
                'Rental Terms',
                'Press & Media',
              ]),

              // Links 3: Customer Care
              _buildFooterColumn('Customer Care', const [
                'Rental FAQs',
                'Insurance & Protection',
                'Damage Coverage',
                'Cancellation Policy',
              ]),

              // Connect With Us
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Connect With Us',
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _buildSocialCircle(Icons.facebook_rounded),
                      const SizedBox(width: 10),
                      _buildSocialCircle(Icons.camera_alt_outlined),
                      const SizedBox(width: 10),
                      _buildSocialCircle(Icons.smart_display_rounded),
                      const SizedBox(width: 10),
                      _buildSocialCircle(Icons.work_rounded),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.mail_outline_rounded,
                        size: 14,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'support@godrive.com',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Kochi, Kerala',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 36),
          Divider(color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 16),
          Text(
            '© Go Drive Car Rental 2026. All rights reserved.',
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String header, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 14),
        ...links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  Icons.chevron_right_rounded,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                const SizedBox(width: 4),
                Text(
                  link,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSocialCircle(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: Colors.white),
    );
  }
}
