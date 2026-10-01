import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/autovista_colors.dart';
import '../../widgets/autovista_contact_card.dart';
import '../../widgets/autovista_screen_header_banner.dart';

class AutovistaContactScreen extends StatefulWidget {
  final bool isDesktop;

  const AutovistaContactScreen({super.key, required this.isDesktop});

  @override
  State<AutovistaContactScreen> createState() => _AutovistaContactScreenState();
}

class _AutovistaContactScreenState extends State<AutovistaContactScreen> {
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _contactMsgController = TextEditingController();

  String _contactCar = 'BMW 5 Series M-Sport';
  String _contactLocation = 'Kochi Airport Hub (COK)';

  @override
  void dispose() {
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactPhoneController.dispose();
    _contactMsgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = widget.isDesktop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutovistaScreenHeaderBanner(
          tag: 'WE ARE HERE 24/7',
          title: 'CONNECT WITH OUR CONCIERGE',
          subtitle:
              'Our luxury mobility specialists are available around the clock to organize your car reservations, airport transfers, and corporate fleet leasing.',
          isDesktop: isDesktop,
        ),

        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column: Contact Touchpoints
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VIP Concierge Desk',
                      style: GoogleFonts.anton(
                        fontSize: 22,
                        letterSpacing: 1,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Direct channels to our reservation and roadside dispatch specialists.',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const AutovistaContactCard(
                      title: '24/7 Dispatch Helpline',
                      val: '+91 98470 12345',
                      icon: Icons.phone_in_talk_rounded,
                    ),
                    const SizedBox(height: 12),
                    const AutovistaContactCard(
                      title: 'WhatsApp Concierge',
                      val: '+91 98470 54321',
                      icon: Icons.chat_bubble_outline_rounded,
                    ),
                    const SizedBox(height: 12),
                    const AutovistaContactCard(
                      title: 'Reservation Email',
                      val: 'concierge@godrive.com',
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 12),
                    const AutovistaContactCard(
                      title: 'Central Flagship Hub',
                      val:
                          'Go Drive Luxury Lounge, Aerocity & Kochi Marina Hub',
                      icon: Icons.location_on_outlined,
                    ),
                  ],
                ),
              ),

              if (isDesktop)
                const SizedBox(width: 40)
              else
                const SizedBox(height: 36),

              // Right Column: Interactive Concierge Inquiry Form
              Expanded(
                flex: isDesktop ? 7 : 0,
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.06),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Send Inquiry / Booking Request',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Our representative will contact you within 15 minutes.',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      TextField(
                        controller: _contactNameController,
                        style: GoogleFonts.outfit(fontSize: 13),
                        decoration: InputDecoration(
                          labelText: 'Your Full Name',
                          hintText: 'e.g. Rahul Sharma',
                          labelStyle: GoogleFonts.outfit(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Phone Field
                      TextField(
                        controller: _contactPhoneController,
                        style: GoogleFonts.outfit(fontSize: 13),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: '+91 98470 XXXXX',
                          labelStyle: GoogleFonts.outfit(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Email Field
                      TextField(
                        controller: _contactEmailController,
                        style: GoogleFonts.outfit(fontSize: 13),
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'yourname@example.com',
                          labelStyle: GoogleFonts.outfit(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Preferred Vehicle Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _contactCar,
                        items: const [
                          'BMW 5 Series M-Sport',
                          'Range Rover Sport HSE',
                          'Porsche 911 Carrera GTS',
                          'Audi A6 Matrix LED',
                          'Mercedes-Benz E-Class AMG',
                          'Mercedes EQS 580 4MATIC',
                        ].map((car) {
                          return DropdownMenuItem(
                            value: car,
                            child: Text(
                              car,
                              style: GoogleFonts.outfit(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => _contactCar = val);
                        },
                        decoration: InputDecoration(
                          labelText: 'Preferred Vehicle',
                          labelStyle: GoogleFonts.outfit(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Pickup Hub Dropdown
                      DropdownButtonFormField<String>(
                        initialValue: _contactLocation,
                        items: const [
                          'Kochi Airport Hub (COK)',
                          'Mumbai Chhatrapati Shivaji T2 (BOM)',
                          'Bengaluru Kempegowda Hub (BLR)',
                          'Delhi NCR Indira Gandhi T3 (DEL)',
                          'Goa Manohar Airport Mopa (GOX)',
                          'Dubai Downtown Hub',
                        ].map((loc) {
                          return DropdownMenuItem(
                            value: loc,
                            child: Text(
                              loc,
                              style: GoogleFonts.outfit(fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _contactLocation = val);
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Preferred Pickup Hub',
                          labelStyle: GoogleFonts.outfit(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Message Notes Field
                      TextField(
                        controller: _contactMsgController,
                        maxLines: 3,
                        style: GoogleFonts.outfit(fontSize: 13),
                        decoration: InputDecoration(
                          labelText: 'Trip Notes / Specific Requests',
                          hintText:
                              'e.g. Flight arrival time, chauffeur request, infant child seat...',
                          labelStyle: GoogleFonts.outfit(fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.all(14),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Submit Button
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Thank you! Your concierge request has been submitted. Our team will contact you shortly.',
                                ),
                                backgroundColor: AutovistaColors.primaryRed,
                                duration: Duration(seconds: 3),
                              ),
                            );
                            _contactNameController.clear();
                            _contactPhoneController.clear();
                            _contactEmailController.clear();
                            _contactMsgController.clear();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AutovistaColors.primaryRed,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Submit Concierge Request',
                              style: GoogleFonts.outfit(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}
