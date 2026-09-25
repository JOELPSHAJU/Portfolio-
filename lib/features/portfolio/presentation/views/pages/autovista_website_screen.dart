import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';

typedef AutoVistaWebsiteScreen = GoDriveWebsiteScreen;

/// Full interactive web application recreating the Go Drive Car Rental platform
/// with complete car rental terminology, fleet rates, filter options, and luxury aesthetic.
class GoDriveWebsiteScreen extends StatefulWidget {
  const GoDriveWebsiteScreen({super.key});

  @override
  State<GoDriveWebsiteScreen> createState() => _GoDriveWebsiteScreenState();
}

class _GoDriveWebsiteScreenState extends State<GoDriveWebsiteScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _newsletterController = TextEditingController();

  int _selectedSidebarIdx = 0;
  int _selectedTopNavIdx = 0;
  String _selectedType = 'Any Type';
  String _selectedLocation = 'Any Location';
  String _selectedDuration = 'Any Duration';
  String _selectedPrice = 'Any Budget';

  String _selectedFleetFilter = 'All Vehicles';
  String _selectedLocationFilter = 'All Hubs';
  String _contactCar = 'BMW 5 Series M-Sport';
  String _contactLocation = 'Kochi Airport Hub (COK)';

  final Set<String> _wishlist = {};

  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _contactMsgController = TextEditingController();

  final List<Map<String, dynamic>> _sidebarItems = [
    {'title': 'Home', 'icon': Icons.home_rounded},
    {'title': 'Rental Fleet', 'icon': Icons.directions_car_rounded},
    {'title': 'Luxury Collection', 'icon': Icons.stars_rounded},
    {'title': 'SUVs & Vans', 'icon': Icons.airport_shuttle_rounded},
    {'title': 'Electric Fleet', 'icon': Icons.bolt_rounded},
    {'title': 'Rental Deals', 'icon': Icons.local_offer_outlined},
    {
      'title': 'Chauffeur Service',
      'icon': Icons.airline_seat_recline_extra_rounded,
    },
    {'title': 'Rental Locations', 'icon': Icons.location_on_outlined},
    {'title': 'Contact & Help', 'icon': Icons.support_agent_rounded},
  ];

  final List<String> _topNavLinks = [
    'Home',
    'Our Fleet',
    'Rental Deals',
    'Services',
    'Locations',
    'About Us',
    'Insurance',
    'Contact',
  ];

  final List<Map<String, dynamic>> _cars = [
    {
      'id': 'bmw_5',
      'tag': 'Popular',
      'tagColor': const Color(0xFFE50914),
      'name': 'BMW 5 Series',
      'specs': '2024 | Automatic | Unlimited Miles',
      'price': '\₹16,500',
      'period': '/ day',
      'image': 'assets/car_bmw_5.jpg',
    },
    {
      'id': 'range_rover',
      'tag': 'Luxury SUV',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Range Rover Sport',
      'specs': '2022 | All-Wheel Drive | 5 Seats',
      'price': '\₹14,250',
      'period': '/ day',
      'image': 'assets/car_range_rover.jpg',
    },
    {
      'id': 'audi_a6',
      'tag': 'Instant Book',
      'tagColor': const Color(0xFFE50914),
      'name': 'Audi A6',
      'specs': '2024 | Automatic | GPS Navigation',
      'price': '\₹15,500',
      'period': '/ day',
      'image': 'assets/car_audi_a6.jpg',
    },
    {
      'id': 'mercedes_e',
      'tag': 'Executive',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Mercedes-Benz E-Class',
      'specs': '2023 | Automatic | Premium Sound',
      'price': '\₹13,780',
      'period': '/ day',
      'image': 'assets/car_mercedes_e.jpg',
    },
  ];

  final List<Map<String, dynamic>> _allFleetCars = [
    {
      'id': 'bmw_5',
      'tag': 'Popular Sedan',
      'tagColor': const Color(0xFFE50914),
      'name': 'BMW 5 Series M-Sport',
      'category': 'Luxury Sedans',
      'specs': '2024 | Automatic | Twin-Turbo | 5 Seats',
      'price': '₹16,500',
      'period': '/ day',
      'image': 'assets/car_bmw_5.jpg',
      'rating': '4.95',
      'trips': '142 trips',
      'speed': '250 km/h',
    },
    {
      'id': 'range_rover',
      'tag': 'Luxury 4x4',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Range Rover Sport HSE',
      'category': 'Performance SUVs',
      'specs': '2023 | All-Wheel Drive | Panoramic Sunroof',
      'price': '₹14,250',
      'period': '/ day',
      'image': 'assets/car_range_rover.jpg',
      'rating': '4.98',
      'trips': '98 trips',
      'speed': '235 km/h',
    },
    {
      'id': 'porsche_911',
      'tag': 'Flagship Supercar',
      'tagColor': const Color(0xFFE50914),
      'name': 'Porsche 911 Carrera GTS',
      'category': 'Sports & Exotics',
      'specs': '2024 | PDK Automatic | 473 HP | Sport Exhaust',
      'price': '₹42,000',
      'period': '/ day',
      'image': 'assets/autovista_hero_porsche.jpg',
      'rating': '5.00',
      'trips': '64 trips',
      'speed': '312 km/h',
    },
    {
      'id': 'audi_a6',
      'tag': 'Instant Book',
      'tagColor': const Color(0xFFE50914),
      'name': 'Audi A6 Matrix LED',
      'category': 'Luxury Sedans',
      'specs': '2024 | Quattro AWD | Virtual Cockpit',
      'price': '₹15,500',
      'period': '/ day',
      'image': 'assets/car_audi_a6.jpg',
      'rating': '4.91',
      'trips': '119 trips',
      'speed': '250 km/h',
    },
    {
      'id': 'mercedes_e',
      'tag': 'Executive VIP',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Mercedes-Benz E-Class AMG',
      'category': 'Luxury Sedans',
      'specs': '2023 | 9G-Tronic | Burmester Audio',
      'price': '₹13,780',
      'period': '/ day',
      'image': 'assets/car_mercedes_e.jpg',
      'rating': '4.96',
      'trips': '156 trips',
      'speed': '240 km/h',
    },
    {
      'id': 'macan_gts',
      'tag': 'Performance SUV',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Porsche Macan GTS',
      'category': 'Performance SUVs',
      'specs': '2023 | Twin-Turbo V6 | Air Suspension',
      'price': '₹28,500',
      'period': '/ day',
      'image': 'assets/autovista_test_drive.jpg',
      'rating': '4.97',
      'trips': '82 trips',
      'speed': '272 km/h',
    },
    {
      'id': 'bmw_m4',
      'tag': 'Track Star',
      'tagColor': const Color(0xFFE50914),
      'name': 'BMW M4 Competition Coupé',
      'category': 'Sports & Exotics',
      'specs': '2024 | 503 HP | M Carbon Buckets',
      'price': '₹38,000',
      'period': '/ day',
      'image': 'assets/autovista_newsletter_car.jpg',
      'rating': '4.99',
      'trips': '53 trips',
      'speed': '290 km/h',
    },
    {
      'id': 'mercedes_eqs',
      'tag': 'Zero Emission',
      'tagColor': const Color(0xFF107C41),
      'name': 'Mercedes EQS 580 4MATIC',
      'category': 'Electric & Hybrid',
      'specs': '2024 | Electric | 700km Range | Hyperscreen',
      'price': '₹24,000',
      'period': '/ day',
      'image': 'assets/car_mercedes_e.jpg',
      'rating': '4.94',
      'trips': '45 trips',
      'speed': '210 km/h',
    },
  ];

  final List<Map<String, dynamic>> _dealsCars = [
    {
      'id': 'bmw_5_deal',
      'tag': 'Weekend Special',
      'tagColor': const Color(0xFFE50914),
      'name': 'BMW 5 Series M-Sport',
      'discount': '25% OFF',
      'originalPrice': '₹22,000',
      'dealPrice': '₹16,500',
      'period': '/ day',
      'savings': 'Save ₹5,500/day',
      'image': 'assets/car_bmw_5.jpg',
      'badge': 'Limited Availability',
    },
    {
      'id': 'range_rover_deal',
      'tag': 'SUV Getaway',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Range Rover Sport HSE',
      'discount': '27% OFF',
      'originalPrice': '₹19,500',
      'dealPrice': '₹14,250',
      'period': '/ day',
      'savings': 'Save ₹5,250/day',
      'image': 'assets/car_range_rover.jpg',
      'badge': 'Top Rated',
    },
    {
      'id': 'macan_gts_deal',
      'tag': 'Power Pass',
      'tagColor': const Color(0xFFE50914),
      'name': 'Porsche Macan GTS',
      'discount': '20% OFF',
      'originalPrice': '₹35,500',
      'dealPrice': '₹28,500',
      'period': '/ day',
      'savings': 'Save ₹7,000/day',
      'image': 'assets/autovista_test_drive.jpg',
      'badge': 'Instant Confirmation',
    },
    {
      'id': 'mercedes_e_deal',
      'tag': 'Corporate Flash',
      'tagColor': const Color(0xFF2C3038),
      'name': 'Mercedes-Benz E-Class AMG',
      'discount': '23% OFF',
      'originalPrice': '₹18,000',
      'dealPrice': '₹13,780',
      'period': '/ day',
      'savings': 'Save ₹4,220/day',
      'image': 'assets/car_mercedes_e.jpg',
      'badge': 'Free Airport Delivery',
    },
  ];

  final List<Map<String, dynamic>> _hubs = [
    {
      'city': 'Kochi',
      'name': 'Cochin International Airport (COK)',
      'terminal': 'Terminal 3 VIP Arrivals Lounge',
      'address': 'Airport Road, Nedumbassery, Kochi, Kerala 683111',
      'type': 'Airport Hubs',
      'hours': 'Open 24 Hours / 7 Days',
      'fleet': '42 Vehicles Available',
      'phone': '+91 98470 11001',
      'is24x7': true,
    },
    {
      'city': 'Mumbai',
      'name': 'Chhatrapati Shivaji International T2 (BOM)',
      'terminal': 'Level P4 Premium Valet Lounge',
      'address': 'Sahar, Andheri East, Mumbai, Maharashtra 400099',
      'type': 'Airport Hubs',
      'hours': 'Open 24 Hours / 7 Days',
      'fleet': '58 Vehicles Available',
      'phone': '+91 98470 11002',
      'is24x7': true,
    },
    {
      'city': 'Mumbai',
      'name': 'Bandra Kurla Complex (BKC) Flagship',
      'terminal': 'Maker Maxity, North Avenue',
      'address': 'Bandra Kurla Complex, Bandra East, Mumbai 400051',
      'type': 'City Centers',
      'hours': '8:00 AM – 11:00 PM',
      'fleet': '34 Vehicles Available',
      'phone': '+91 98470 11003',
      'is24x7': false,
    },
    {
      'city': 'Bengaluru',
      'name': 'Kempegowda International Airport (BLR)',
      'terminal': 'Terminal 1 & 2 Car Rental Concourse',
      'address': 'KIAL Rd, Devanahalli, Bengaluru, Karnataka 560300',
      'type': 'Airport Hubs',
      'hours': 'Open 24 Hours / 7 Days',
      'fleet': '46 Vehicles Available',
      'phone': '+91 98470 11004',
      'is24x7': true,
    },
    {
      'city': 'Delhi NCR',
      'name': 'Indira Gandhi International T3 (DEL)',
      'terminal': 'Aerocity Hospitality District, Worldmark 1',
      'address': 'Aerocity, New Delhi, Delhi 110037',
      'type': 'Airport Hubs',
      'hours': 'Open 24 Hours / 7 Days',
      'fleet': '50 Vehicles Available',
      'phone': '+91 98470 11005',
      'is24x7': true,
    },
    {
      'city': 'Goa',
      'name': 'Manohar International Airport Mopa (GOX)',
      'terminal': 'North Goa Express Rental Lounge',
      'address': 'Mopa, Pernem, Goa 403512',
      'type': 'Airport Hubs',
      'hours': 'Open 24 Hours / 7 Days',
      'fleet': '30 Vehicles Available',
      'phone': '+91 98470 11006',
      'is24x7': true,
    },
    {
      'city': 'Dubai',
      'name': 'Downtown Boulevard & DXB T3',
      'terminal': 'Sheikh Zayed Road & Terminal 3 VIP Concierge',
      'address': 'Financial Centre Road, Downtown Dubai, UAE',
      'type': 'City Centers',
      'hours': 'Open 24 Hours / 7 Days',
      'fleet': '65 Vehicles Available',
      'phone': '+971 4 800 5634',
      'is24x7': true,
    },
  ];

  final List<Map<String, dynamic>> _services = [
    {
      'title': 'Airport Delivery',
      'sub': 'Direct delivery to terminal gate',
      'icon': Icons.flight_takeoff_rounded,
    },
    {
      'title': 'Chauffeur Drive',
      'sub': 'Executive chauffeured transport',
      'icon': Icons.airline_seat_recline_extra_rounded,
    },
    {
      'title': 'Doorstep Drop-off',
      'sub': 'Delivered right to your hotel or home',
      'icon': Icons.home_work_outlined,
    },
    {
      'title': 'Long-Term Rental',
      'sub': 'Flexible weekly & monthly discounts',
      'icon': Icons.calendar_month_outlined,
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _newsletterController.dispose();
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactPhoneController.dispose();
    _contactMsgController.dispose();
    super.dispose();
  }

  void _selectTopNav(int idx) {
    setState(() {
      _selectedTopNavIdx = idx;
      if (idx == 0) {
        _selectedSidebarIdx = 0;
      } else if (idx == 1) {
        _selectedSidebarIdx = 1;
      } else if (idx == 2) {
        _selectedSidebarIdx = 5;
      } else if (idx == 3) {
        _selectedSidebarIdx = 6;
      } else if (idx == 4) {
        _selectedSidebarIdx = 7;
      } else if (idx == 7) {
        _selectedSidebarIdx = 8;
      }
    });
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1100;

    return Scaffold(
      backgroundColor: const Color(0xFF090B10),
      body: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Left Sidebar (Visible on Desktop) ──────────────────────────
              if (isDesktop)
                Container(
                  width: 230,
                  height: size.height,
                  color: const Color(0xFF0C0E14),
                  child: _buildSidebar(),
                ),

              // ── Main Content Viewport ──────────────────────────────────────
              Expanded(
                child: Container(
                  color: const Color(0xFFF6F8FB),
                  height: size.height,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Top Navbar Header
                        _buildTopHeader(isDesktop),

                        // Mobile Top Navigation Pills
                        if (!isDesktop) _buildMobileTopNav(),

                        // Dynamic Screen View based on _selectedTopNavIdx
                        _buildActiveContent(size, isDesktop),

                        // Persistent Footer across all screens
                        _buildFooter(isDesktop),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Floating Go Back to Portfolio Button (Top-Right) ──────────────
          Positioned(top: 16, right: 24, child: _buildFloatingBackButton()),
        ],
      ),
    );
  }

  // ── Floating Go Back Button ────────────────────────────────────────────────
  Widget _buildFloatingBackButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'PORTFOLIO',
                    style: GoogleFonts.spaceMono(
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Left Sidebar Widget ────────────────────────────────────────────────────
  Widget _buildSidebar() {
    return Column(
      children: [
        // Brand Logo
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          child: Row(
            children: [
              _buildBrandSpeedometerIcon(),
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
                      fontSize: 7.5,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE50914),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Navigation Items
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: _sidebarItems.length,
            itemBuilder: (context, idx) {
              final item = _sidebarItems[idx];
              final isSelected = _selectedSidebarIdx == idx;

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      int targetNav = 0;
                      if (idx == 0) {
                        targetNav = 0;
                      } else if (idx >= 1 && idx <= 4) {
                        targetNav = 1;
                      } else if (idx == 5) {
                        targetNav = 2;
                      } else if (idx == 6) {
                        targetNav = 3;
                      } else if (idx == 7) {
                        targetNav = 4;
                      } else if (idx == 8) {
                        targetNav = 7;
                      }

                      setState(() {
                        _selectedSidebarIdx = idx;
                        _selectedTopNavIdx = targetNav;
                        if (idx == 2) {
                          _selectedFleetFilter = 'Luxury Sedans';
                        } else if (idx == 3) {
                          _selectedFleetFilter = 'Performance SUVs';
                        } else if (idx == 4) {
                          _selectedFleetFilter = 'Electric & Hybrid';
                        } else if (idx == 1) {
                          _selectedFleetFilter = 'All Vehicles';
                        }
                      });

                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFE50914)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 18,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item['title'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Need Help Box at Bottom
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914).withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.headset_mic_rounded,
                        color: Color(0xFFE50914),
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '24/7 Rental Help',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "We're here for your trip!",
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton.icon(
                    onPressed: () => _selectTopNav(7),
                    icon: const Icon(Icons.support_agent_rounded, size: 14),
                    label: Text(
                      'Rental Support',
                      style: GoogleFonts.outfit(fontSize: 11),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50914),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Top Header Navigation Bar ──────────────────────────────────────────────
  Widget _buildTopHeader(bool isDesktop) {
    return Container(
      color: const Color(0xFF0C0E14),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // If not desktop, show logo on header
          if (!isDesktop)
            Row(
              children: [
                _buildBrandSpeedometerIcon(),
                const SizedBox(width: 8),
                Text(
                  'GO DRIVE',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

          // Center Horizontal Navigation Links
          if (isDesktop)
            Row(
              children: _topNavLinks.asMap().entries.map((entry) {
                final idx = entry.key;
                final title = entry.value;
                final isActive = idx == _selectedTopNavIdx;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _selectTopNav(idx),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFFE50914)
                                  : Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: isActive ? 20 : 0,
                            color: const Color(0xFFE50914),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

          // Right "Rent a Car Now" CTA Button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _selectTopNav(1),
              child: Container(
                margin: const EdgeInsets.only(
                  right: 120,
                ), // gap for floating portfolio btn
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.vpn_key_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Rent a Car Now',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Mobile / Small Screens Horizontal Sub-Navbar ───────────────────────────
  Widget _buildMobileTopNav() {
    return Container(
      height: 48,
      color: const Color(0xFF0C0E14),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _topNavLinks.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, idx) {
          final isActive = idx == _selectedTopNavIdx;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _selectTopNav(idx),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFE50914)
                      : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFFE50914)
                        : Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  _topNavLinks[idx],
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Dynamic Screen View Switcher ───────────────────────────────────────────
  Widget _buildActiveContent(Size size, bool isDesktop) {
    switch (_selectedTopNavIdx) {
      case 1:
        return _buildFleetScreen(isDesktop);
      case 2:
        return _buildDealsScreen(isDesktop);
      case 3:
        return _buildServicesScreen(isDesktop);
      case 4:
        return _buildLocationsScreen(isDesktop);
      case 5:
        return _buildAboutUsScreen(isDesktop);
      case 6:
        return _buildInsuranceScreen(isDesktop);
      case 7:
        return _buildContactScreen(isDesktop);
      case 0:
      default:
        return _buildHomeScreen(size, isDesktop);
    }
  }

  // ── Screen 0: Home Page Content ────────────────────────────────────────────
  Widget _buildHomeScreen(Size size, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Hero Section
        _buildHeroSection(size, isDesktop),

        // 2. Search Filter Floating Bar
        _buildSearchFilterBar(isDesktop),

        // 3. Value Propositions Bar
        _buildValueProps(isDesktop),

        const SizedBox(height: 36),

        // 4. Popular Vehicles & Side Banners
        _buildPopularVehiclesSection(isDesktop),

        const SizedBox(height: 48),

        // 5. Newsletter "Stay in the Loop" Banner
        _buildNewsletterBanner(isDesktop),

        const SizedBox(height: 50),
      ],
    );
  }

  // ── Reusable Screen Header Banner ──────────────────────────────────────────
  Widget _buildScreenHeaderBanner({
    required String tag,
    required String title,
    required String subtitle,
    required bool isDesktop,
  }) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF090B10),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: isDesktop ? 42 : 28,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 3, height: 14, color: const Color(0xFFE50914)),
              const SizedBox(width: 8),
              Text(
                tag,
                style: GoogleFonts.spaceMono(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFE50914),
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.anton(
              fontSize: isDesktop ? 38 : 28,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              subtitle,
              style: GoogleFonts.outfit(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.7),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Screen 1: Our Fleet View ───────────────────────────────────────────────
  Widget _buildFleetScreen(bool isDesktop) {
    final categories = [
      'All Vehicles',
      'Luxury Sedans',
      'Performance SUVs',
      'Sports & Exotics',
      'Electric & Hybrid',
    ];

    final filtered = _selectedFleetFilter == 'All Vehicles'
        ? _allFleetCars
        : _allFleetCars
            .where((c) => c['category'] == _selectedFleetFilter)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
          tag: 'PRESTIGE FLEET COLLECTION',
          title: 'EXPLORE OUR LUXURY FLEET',
          subtitle:
              'Browse our handpicked fleet of high-performance supercars, executive sedans, and luxury SUVs ready for immediate self-drive or chauffeur dispatch.',
          isDesktop: isDesktop,
        ),

        // Fleet Filter Chips Bar
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 16,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((cat) {
                final isSelected = _selectedFleetFilter == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFleetFilter = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE50914)
                              : const Color(0xFFF1F3F6),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFE50914)
                                : Colors.black.withValues(alpha: 0.06),
                          ),
                        ),
                        child: Text(
                          cat,
                          style: GoogleFonts.outfit(
                            fontSize: 12.5,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Fleet Counter & Amenities Info Strip
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${filtered.length} Premium Vehicles',
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFFE50914),
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '100% Sanitized & Detailed',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Responsive Fleet Cars Grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 2 * 20) / 3
                  : constraints.maxWidth > 700
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: filtered.map((car) {
                  return SizedBox(
                    width: cardWidth,
                    child: _buildFleetCarCard(car),
                  );
                }).toList(),
              );
            },
          ),
        ),

        const SizedBox(height: 40),

        // Fleet Guarantee Banner
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1218),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914).withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        color: Color(0xFFE50914),
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Certified Fleet Guarantee',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Every vehicle undergoes 150-point diagnostic inspections and comes with complimentary 24/7 roadside assist.',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.65),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (!isDesktop) const SizedBox(height: 16),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _selectTopNav(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE50914),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'View Protection Plans',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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

        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildFleetCarCard(Map<String, dynamic> car) {
    final isWishlisted = _wishlist.contains(car['id']);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Tag Overlay & Wishlist Button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: SizedBox(
                  height: 175,
                  width: double.infinity,
                  child: AppImage(
                    assetPath: car['image'] as String,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: car['tagColor'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    car['tag'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isWishlisted) {
                          _wishlist.remove(car['id']);
                        } else {
                          _wishlist.add(car['id'] as String);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isWishlisted
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 16,
                        color: isWishlisted
                            ? const Color(0xFFE50914)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category & Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      car['category'] as String,
                      style: GoogleFonts.spaceMono(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFE50914),
                        letterSpacing: 0.8,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${car['rating']} (${car['trips']})',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Name
                Text(
                  car['name'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),

                // Specs
                Text(
                  car['specs'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade200, height: 1),
                const SizedBox(height: 14),

                // Price & Reserve CTA Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['price'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFE50914),
                          ),
                        ),
                        Text(
                          car['period'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 10.5,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${car['name']} specs: ${car['specs']}. Top Speed: ${car['speed']}',
                                  ),
                                  backgroundColor: const Color(0xFF161922),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.info_outline_rounded,
                                size: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Selected ${car['name']}! Our luxury concierge will confirm your booking.',
                                  ),
                                  backgroundColor: const Color(0xFFE50914),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE50914),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Reserve Now',
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Screen 2: Rental Deals View ────────────────────────────────────────────
  Widget _buildDealsScreen(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
          tag: 'SPECIAL RENTAL PRIVILEGES',
          title: 'EXCLUSIVE OFFERS & DISCOUNTS',
          subtitle:
              'Unlock exclusive weekend passes, seasonal luxury discounts, and corporate leasing privileges tailored for passionate drivers.',
          isDesktop: isDesktop,
        ),

        // Featured Weekend Escape Card Banner
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 24,
          ),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE50914), Color(0xFF8B0000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE50914).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'LIMITED TIME OFFER',
                        style: GoogleFonts.spaceMono(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE50914),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'WEEKEND ESCAPE PASS - 35% OFF',
                      style: GoogleFonts.anton(
                        fontSize: isDesktop ? 28 : 22,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Book 3 or more days on any luxury vehicle and receive 35% off plus complimentary airport drop.',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                if (!isDesktop) const SizedBox(height: 20),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Promo code WEEKEND35 applied to your reservation session!',
                          ),
                          backgroundColor: Colors.black87,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Claim Weekend Pass',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE50914),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Promo Coupon Cards
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Voucher Coupons',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 14),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isDesktop
                      ? (constraints.maxWidth - 2 * 16) / 3
                      : constraints.maxWidth;

                  final coupons = [
                    {
                      'code': 'AUTOVISTA20',
                      'discount': '20% OFF',
                      'title': 'Luxury Sedans Discount',
                      'desc': 'Valid on bookings of 2 days or more across all BMW and Audi models.',
                    },
                    {
                      'code': 'FIRSTDRIVE',
                      'discount': '₹2,500 OFF',
                      'title': 'First-Time Driver Gift',
                      'desc': 'Instant discount on your first verified rental reservation.',
                    },
                    {
                      'code': 'MONTHLYPRO',
                      'discount': '40% OFF',
                      'title': 'Long-Term Subscription',
                      'desc': 'Special privilege rates for 30+ day vehicle bookings with concierge.',
                    },
                  ];

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: coupons.map((c) {
                      return SizedBox(
                        width: cardWidth,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE50914)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      c['discount']!,
                                      style: GoogleFonts.spaceMono(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFE50914),
                                      ),
                                    ),
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Promo code ${c['code']} copied to clipboard!',
                                            ),
                                            backgroundColor: const Color(0xFFE50914),
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.copy_rounded,
                                            size: 13,
                                            color: Color(0xFFE50914),
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            c['code']!,
                                            style: GoogleFonts.spaceMono(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                c['title']!,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                c['desc']!,
                                style: GoogleFonts.outfit(
                                  fontSize: 11.5,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 36),

        // Discounted Fleet Section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spotlight Deal Vehicles',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = isDesktop
                      ? (constraints.maxWidth - 3 * 16) / 4
                      : constraints.maxWidth > 650
                          ? (constraints.maxWidth - 16) / 2
                          : constraints.maxWidth;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: _dealsCars.map((deal) {
                      return SizedBox(
                        width: cardWidth,
                        child: _buildDealCarCard(deal),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildDealCarCard(Map<String, dynamic> deal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: AppImage(
                    assetPath: deal['image'] as String,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    deal['discount'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deal['name'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  deal['savings'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deal['originalPrice'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        Text(
                          deal['dealPrice'] as String,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFE50914),
                          ),
                        ),
                      ],
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Deal claimed for ${deal['name']} at ${deal['dealPrice']}${deal['period']}!',
                              ),
                              backgroundColor: const Color(0xFFE50914),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE50914),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Book Deal',
                            style: GoogleFonts.outfit(
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Screen 3: Services View ────────────────────────────────────────────────
  Widget _buildServicesScreen(bool isDesktop) {
    final detailedServices = [
      {
        'title': 'Executive Chauffeur Drive',
        'sub':
            'Professional, multilingual chauffeurs in sharp business attire. Trained in diplomatic etiquette, privacy, and smooth navigation.',
        'icon': Icons.airline_seat_recline_extra_rounded,
        'features': [
          'English-speaking certified chauffeurs',
          'Complimentary onboard Wi-Fi & water',
          'Flight delay tracking & airport pickup',
        ],
      },
      {
        'title': 'Airport VIP Meet & Greet',
        'sub':
            'Direct curbside terminal delivery. Step off your aircraft and straight into the driver’s seat with zero waiting at rental desks.',
        'icon': Icons.flight_takeoff_rounded,
        'features': [
          'Curbside terminal departure & arrival',
          'Luggage concierge assistance',
          'Fast-track digital paperwork verification',
        ],
      },
      {
        'title': 'Wedding & Gala Convoys',
        'sub':
            'Coordinated luxury convoys and decorated flagship vehicles for weddings, VIP film sets, and high-profile private delegations.',
        'icon': Icons.celebration_rounded,
        'features': [
          'Bespoke ribbon and floral styling',
          'Synchronized multi-car arrival logistics',
          'Dedicated backup automobile on standby',
        ],
      },
      {
        'title': 'Corporate Long-Term Fleet',
        'sub':
            'Flexible 1 to 24-month corporate leasing solutions without balance-sheet liabilities, depreciation losses, or servicing downtime.',
        'icon': Icons.business_center_rounded,
        'features': [
          'Tax-deductible commercial invoicing',
          'Scheduled doorstep maintenance service',
          'Immediate loaner car during maintenance',
        ],
      },
      {
        'title': 'Doorstep Express Delivery',
        'sub':
            'Handover at your private residence, hotel lobby, or airstrip hanger. Delivered cleaned, detailed, and fueled in under 90 minutes.',
        'icon': Icons.home_work_rounded,
        'features': [
          '90-minute rapid doorstep dispatch',
          'Contactless digital key handover',
          'Live GPS delivery tracking to your door',
        ],
      },
      {
        'title': 'Weekend Supercar Track Experience',
        'sub':
            'Unleash high-horsepower precision on private circuits and curated scenic mountain passes with escort pilots and route planning.',
        'icon': Icons.speed_rounded,
        'features': [
          'Professional telemetry telemetry briefing',
          'Lead & chase support vehicle escort',
          'GoPro 4K video recording bundle included',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
          tag: 'BESPOKE MOBILITY SOLUTIONS',
          title: 'TAILORED AUTOMOTIVE SERVICES',
          subtitle:
              'From self-drive exotics to executive chauffeur transit and corporate fleet programs, discover mobility designed entirely around your prestige.',
          isDesktop: isDesktop,
        ),

        // Services 6-Card Grid
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 20) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: detailedServices.map((srv) {
                  return SizedBox(
                    width: cardWidth,
                    child: Container(
                      padding: const EdgeInsets.all(24),
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
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE50914)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  srv['icon'] as IconData,
                                  color: const Color(0xFFE50914),
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  srv['title'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            srv['sub'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 12.5,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.grey.shade200),
                          const SizedBox(height: 10),
                          ...(srv['features'] as List<String>).map((feat) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: Color(0xFFE50914),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    feat,
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 14),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Concierge inquiry submitted for ${srv['title']}! We will reach out shortly.',
                                    ),
                                    backgroundColor: const Color(0xFFE50914),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F1218),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Inquire Service',
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
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
                  );
                }).toList(),
              );
            },
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  // ── Screen 4: Locations View ───────────────────────────────────────────────
  Widget _buildLocationsScreen(bool isDesktop) {
    final locationFilterOptions = [
      'All Hubs',
      'Airport Hubs',
      'City Centers',
    ];

    final filteredHubs = _selectedLocationFilter == 'All Hubs'
        ? _hubs
        : _hubs.where((h) => h['type'] == _selectedLocationFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
          tag: 'NATIONAL & INTERNATIONAL NETWORK',
          title: 'OUR RENTAL HUBS & HUBS',
          subtitle:
              'Strategically stationed at premier airport terminals, financial districts, and luxury hotel concourses across major cities.',
          isDesktop: isDesktop,
        ),

        // Location Filter Chips
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 14,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: locationFilterOptions.map((type) {
                final isSelected = _selectedLocationFilter == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLocationFilter = type;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFE50914)
                              : const Color(0xFFF1F3F6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          type,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Hub Cards
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 30,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 20) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: filteredHubs.map((hub) {
                  return SizedBox(
                    width: cardWidth,
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.06),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F1218),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  hub['city'] as String,
                                  style: GoogleFonts.spaceMono(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2E7D32),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    hub['hours'] as String,
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            hub['name'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hub['terminal'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: const Color(0xFFE50914),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 15,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  hub['address'] as String,
                                  style: GoogleFonts.outfit(
                                    fontSize: 11.5,
                                    color: Colors.grey.shade600,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 15,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                hub['phone'] as String,
                                style: GoogleFonts.outfit(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                hub['fleet'] as String,
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Selected ${hub['name']} as pickup location!',
                                          ),
                                          backgroundColor: const Color(0xFFE50914),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE50914),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Select Hub',
                                        style: GoogleFonts.outfit(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Opening map directions to ${hub['name']}...',
                                          ),
                                          backgroundColor: const Color(0xFF161922),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'View Map',
                                        style: GoogleFonts.outfit(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  // ── Screen 5: About Us View ────────────────────────────────────────────────
  Widget _buildAboutUsScreen(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
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
                            color: const Color(0xFF0F1218),
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
                        Text(
                          'Kochi • Mumbai • Bengaluru • Delhi • Dubai',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
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
                  child: SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: const AppImage(
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
                _buildStatItem('15+', 'Years Experience'),
                if (isDesktop) _buildVerticalDivider(),
                _buildStatItem('450+', 'Luxury Vehicles'),
                if (isDesktop) _buildVerticalDivider(),
                _buildStatItem('48,000+', 'Happy Drivers'),
                if (isDesktop) _buildVerticalDivider(),
                _buildStatItem('99.8%', 'On-Time Handover'),
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
                  Expanded(
                    child: _buildPillarCard(
                      'Pristine Detailing',
                      'Every car goes through a 150-point diagnostic check and complete interior sterilization prior to key handover.',
                      Icons.clean_hands_outlined,
                    ),
                  ),
                  SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
                  Expanded(
                    child: _buildPillarCard(
                      'Transparent Pricing',
                      'Zero hidden insurance deductions, crystal-clear fuel policy, and 48-hour automated deposit refund settlement.',
                      Icons.receipt_long_outlined,
                    ),
                  ),
                  SizedBox(width: isDesktop ? 16 : 0, height: isDesktop ? 0 : 16),
                  Expanded(
                    child: _buildPillarCard(
                      'Personal Concierge',
                      'A dedicated fleet manager assigned to your trip 24/7 for route assistance, parking help, and support.',
                      Icons.support_agent_rounded,
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

  Widget _buildStatItem(String num, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Text(
            num,
            style: GoogleFonts.anton(
              fontSize: 32,
              color: const Color(0xFFE50914),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillarCard(String title, String desc, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFE50914), size: 24),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Screen 6: Insurance & Protection View ───────────────────────────────────
  Widget _buildInsuranceScreen(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
          tag: 'ZERO WORRIES ON THE ROAD',
          title: 'COMPREHENSIVE COVERAGE & PROTECTION',
          subtitle:
              'Drive with ultimate confidence. Choose the protection tier tailored to your peace of mind with crystal-clear coverage terms.',
          isDesktop: isDesktop,
        ),

        // 3-Tier Protection Plans
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 36,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 2 * 20) / 3
                  : constraints.maxWidth;

              final plans = [
                {
                  'tier': 'Silver Standard',
                  'cost': 'Included Free',
                  'excess': '₹25,000 max liability',
                  'isFeatured': false,
                  'items': [
                    'Third-party bodily injury & property liability',
                    'Basic collision damage waiver (CDW)',
                    '24/7 National roadside breakdown support',
                    'Towing coverage up to 50 km',
                  ],
                },
                {
                  'tier': 'Gold Comprehensive',
                  'cost': '₹1,499 / day',
                  'excess': '₹5,000 reduced excess',
                  'isFeatured': false,
                  'items': [
                    'Reduced collision liability to just ₹5,000',
                    'Windscreen and glass crack coverage',
                    'Tyre puncture and alloy wheel scuff repair',
                    'Personal accident cover for all passengers',
                  ],
                },
                {
                  'tier': 'Platinum Zero-Excess',
                  'cost': '₹2,999 / day',
                  'excess': '₹0 ZERO EXCESS (Full Shield)',
                  'isFeatured': true,
                  'items': [
                    '100% Zero Deductible / Zero Customer Excess',
                    'Key loss replacement & emergency locksmith',
                    'Interior leather accidental stain cover',
                    'Free additional companion driver license',
                    'Instant replacement car dispatch guarantee',
                  ],
                },
              ];

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                children: plans.map((p) {
                  final isFeatured = p['isFeatured'] as bool;
                  return SizedBox(
                    width: cardWidth,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isFeatured ? const Color(0xFF0F1218) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isFeatured
                              ? const Color(0xFFE50914)
                              : Colors.black.withValues(alpha: 0.06),
                          width: isFeatured ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isFeatured)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE50914),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'RECOMMENDED CHOICE',
                                style: GoogleFonts.spaceMono(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          Text(
                            p['tier'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isFeatured ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            p['cost'] as String,
                            style: GoogleFonts.anton(
                              fontSize: 24,
                              color: const Color(0xFFE50914),
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            p['excess'] as String,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isFeatured
                                  ? Colors.white.withValues(alpha: 0.7)
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Divider(
                            color: isFeatured
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.grey.shade200,
                          ),
                          const SizedBox(height: 12),
                          ...(p['items'] as List<String>).map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.check_circle_rounded,
                                    size: 14,
                                    color: Color(0xFFE50914),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: GoogleFonts.outfit(
                                        fontSize: 12,
                                        color: isFeatured
                                            ? Colors.white.withValues(alpha: 0.85)
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Selected ${p['tier']} protection plan for your journey!',
                                    ),
                                    backgroundColor: const Color(0xFFE50914),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isFeatured
                                      ? const Color(0xFFE50914)
                                      : const Color(0xFF0F1218),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Select Plan',
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
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
                  );
                }).toList(),
              );
            },
          ),
        ),

        const SizedBox(height: 60),
      ],
    );
  }

  // ── Screen 7: Contact View ─────────────────────────────────────────────────
  Widget _buildContactScreen(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScreenHeaderBanner(
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
                    _buildContactCard(
                      '24/7 Dispatch Helpline',
                      '+91 98470 12345',
                      Icons.phone_in_talk_rounded,
                    ),
                    const SizedBox(height: 12),
                    _buildContactCard(
                      'WhatsApp Concierge',
                      '+91 98470 54321',
                      Icons.chat_bubble_outline_rounded,
                    ),
                    const SizedBox(height: 12),
                    _buildContactCard(
                      'Reservation Email',
                      'concierge@godrive.com',
                      Icons.email_outlined,
                    ),
                    const SizedBox(height: 12),
                    _buildContactCard(
                      'Central Flagship Hub',
                      'Go Drive Luxury Lounge, Aerocity & Kochi Marina Hub',
                      Icons.location_on_outlined,
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
                        value: _contactCar,
                        items: [
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
                        value: _contactLocation,
                        items: [
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
                          hintText: 'e.g. Flight arrival time, chauffeur request, infant child seat...',
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
                                backgroundColor: Color(0xFFE50914),
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
                              color: const Color(0xFFE50914),
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

  Widget _buildContactCard(String title, String val, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE50914).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFE50914), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  val,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero Section ───────────────────────────────────────────────────────────
  Widget _buildHeroSection(Size size, bool isDesktop) {
    return Container(
      width: double.infinity,
      height: isDesktop ? 480 : 380,
      color: const Color(0xFF090B10),
      child: Stack(
        children: [
          // Background Hero Porsche Car Image
          Positioned.fill(
            child: const AppImage(
              assetPath: 'assets/autovista_hero_porsche.jpg',
              fit: BoxFit.cover,
              alignment: Alignment(0.4, 0),
            ),
          ),

          // High-End Luxury Dark Vignette Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF090B10).withValues(alpha: 0.95),
                    const Color(0xFF090B10).withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.45, 0.9],
                ),
              ),
            ),
          ),

          // Hero Text Content on Left
          Positioned(
            top: 0,
            bottom: 0,
            left: isDesktop ? 48 : 24,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Accent Tag
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 14,
                          color: const Color(0xFFE50914),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'POWER. PERFORMANCE. FREEDOM.',
                          style: GoogleFonts.spaceMono(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withValues(alpha: 0.85),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Massive Headline
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'RENT THE\n',
                            style: GoogleFonts.anton(
                              fontSize: isDesktop ? 54 : 40,
                              letterSpacing: 1.5,
                              height: 1.0,
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: 'EXPERIENCE',
                            style: GoogleFonts.anton(
                              fontSize: isDesktop ? 54 : 40,
                              letterSpacing: 1.5,
                              height: 1.0,
                              color: const Color(0xFFE50914),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'Explore our premium fleet of luxury, sports,\nand executive rental cars on your own terms.',
                      style: GoogleFonts.outfit(
                        fontSize: 14.5,
                        height: 1.5,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 26),

                    // Book Your Rental Pill CTA Button & Slider indicators
                    Row(
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE50914),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Book Your Rental',
                                  style: GoogleFonts.outfit(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Color(0xFFE50914),
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Carousel dots
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE50914),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 6,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Search Filter Floating Bar ─────────────────────────────────────────────
  Widget _buildSearchFilterBar(bool isDesktop) {
    return Transform.translate(
      offset: const Offset(0, -32),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFilterSelector(
                'Vehicle Type',
                _selectedType,
                Icons.directions_car_outlined,
                ['Any Type', 'Sedan', 'Luxury SUV', 'Sports Coupe', 'Electric'],
                (val) => setState(() => _selectedType = val),
              ),
              if (isDesktop) _buildVerticalDivider(),
              _buildFilterSelector(
                'Pick-up Location',
                _selectedLocation,
                Icons.location_on_outlined,
                [
                  'Any Location',
                  'Kalamasery',
                  'Maradu',
                  'Infopark',
                  'Edapally',
                ],
                (val) => setState(() => _selectedLocation = val),
              ),
              if (isDesktop) _buildVerticalDivider(),
              _buildFilterSelector(
                'Rental Duration',
                _selectedDuration,
                Icons.calendar_today_outlined,
                [
                  'Any Duration',
                  'Daily (1-3 Days)',
                  'Weekly (7 Days)',
                  'Monthly (30+ Days)',
                ],
                (val) => setState(() => _selectedDuration = val),
              ),
              if (isDesktop) _buildVerticalDivider(),
              _buildFilterSelector(
                'Daily Budget',
                _selectedPrice,
                Icons.sell_outlined,
                [
                  'Any Budget',
                  'Under \₹12000/day',
                  'Under \₹15000/day',
                  'Under \₹25000/day',
                  '\₹30000+/day',
                ],
                (val) => setState(() => _selectedPrice = val),
              ),
              const SizedBox(width: 16),

              // Find Rental Car Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Find Rental Car',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
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

  Widget _buildFilterSelector(
    String label,
    String currentValue,
    IconData icon,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: Colors.black87,
              ),
              isDense: true,
              items: options.map((opt) {
                return DropdownMenuItem(
                  value: opt,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 15, color: Colors.grey.shade700),
                      const SizedBox(width: 8),
                      Text(
                        opt,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 38, color: Colors.grey.shade200);
  }

  // ── Value Propositions Bar ─────────────────────────────────────────────────
  Widget _buildValueProps(bool isDesktop) {
    final props = [
      {
        'title': 'Sanitized Fleet',
        'sub': '100% clean, inspected vehicles',
        'icon': Icons.verified_outlined,
      },
      {
        'title': 'Best Rate Guarantee',
        'sub': 'Transparent pricing, no hidden fees',
        'icon': Icons.military_tech_outlined,
      },
      {
        'title': '24/7 Roadside Assist',
        'sub': 'Always on call for your trip',
        'icon': Icons.headset_mic_outlined,
      },
      {
        'title': 'Flexible Rental Terms',
        'sub': 'Free cancellation up to 24h',
        'icon': Icons.credit_card_outlined,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: props.map((p) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    p['icon'] as IconData,
                    size: 20,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['title'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      p['sub'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Popular Vehicles & Side Banners ────────────────────────────────────────
  Widget _buildPopularVehiclesSection(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title & "View Entire Fleet" Link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Rental Fleet',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Text(
                      'View Entire Fleet',
                      style: GoogleFonts.outfit(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFE50914),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: Color(0xFFE50914),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4 Vehicle Cards Row
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = isDesktop
                  ? (constraints.maxWidth - 3 * 16) / 4
                  : constraints.maxWidth > 650
                  ? (constraints.maxWidth - 16) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _cars.map((car) {
                  return SizedBox(
                    width: cardWidth,
                    child: _buildVehicleCard(car),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 36),

          // Split Row: "Ready to Hit the Road?" & "Our Services"
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ready To Hit The Road Banner Card
              Expanded(
                flex: isDesktop ? 5 : 0,
                child: _buildReadyToHitRoadBanner(),
              ),

              if (isDesktop)
                const SizedBox(width: 24)
              else
                const SizedBox(height: 24),

              // Our Services 4-card Row
              Expanded(flex: isDesktop ? 7 : 0, child: _buildServicesBlock()),
            ],
          ),
        ],
      ),
    );
  }

  // Single Vehicle Card
  Widget _buildVehicleCard(Map<String, dynamic> car) {
    final isWishlisted = _wishlist.contains(car['id']);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag and Wishlist Icon overlay on Image
          Stack(
            children: [
              // Car Photo
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: const Color(0xFFF1F3F6),
                  child: AppImage(assetPath: car['image'], fit: BoxFit.cover),
                ),
              ),

              // Tag badge (Rental Status / Category)
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: car['tagColor'] as Color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    car['tag'],
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Car Details
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['name'],
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  car['specs'],
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          car['price'],
                          style: GoogleFonts.outfit(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFE50914),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          car['period'] as String? ?? '/ day',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isWishlisted) {
                              _wishlist.remove(car['id']);
                            } else {
                              _wishlist.add(car['id']);
                            }
                          });
                        },
                        child: Icon(
                          isWishlisted
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                          color: isWishlisted
                              ? const Color(0xFFE50914)
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // "Ready to Hit the Road?" Dark Banner
  Widget _buildReadyToHitRoadBanner() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFF0F1218),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          // Background Car Rear Light Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: const Opacity(
                opacity: 0.85,
                child: AppImage(
                  assetPath: 'assets/autovista_test_drive.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ),

          // Left Gradient Scrim
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF0F1218),
                    const Color(0xFF0F1218).withValues(alpha: 0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 0.85],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'READY TO\nHIT THE ',
                        style: GoogleFonts.anton(
                          fontSize: 22,
                          letterSpacing: 1,
                          height: 1.1,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'ROAD?',
                        style: GoogleFonts.anton(
                          fontSize: 22,
                          letterSpacing: 1,
                          height: 1.1,
                          color: const Color(0xFFE50914),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Book your rental today and\nfeel the ultimate driving thrill.',
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 14),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Rent Now',
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // "Our Services" Block
  Widget _buildServicesBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rental Services',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: _services.map((srv) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      srv['icon'] as IconData,
                      color: Colors.black87,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      srv['title'] as String,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      srv['sub'] as String,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.outfit(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Newsletter "Stay in the Loop" Banner ───────────────────────────────────
  Widget _buildNewsletterBanner(bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1218),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Dark luxury car background silhouette
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 350,
              child: const Opacity(
                opacity: 0.35,
                child: AppImage(
                  assetPath: 'assets/autovista_newsletter_car.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left text & email icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE50914),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.mail_outline_rounded,
                        color: Color(0xFFE50914),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stay in the Loop',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Subscribe to get exclusive rental discounts, weekend specials and fleet news.',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                if (!isDesktop) const SizedBox(height: 20),

                // Right Email input + Subscribe button
                Container(
                  width: isDesktop ? 360 : double.infinity,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: TextField(
                            controller: _newsletterController,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your email for rental deals',
                              hintStyle: GoogleFonts.outfit(
                                fontSize: 12.5,
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            if (_newsletterController.text.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Thank you for subscribing to Go Drive VIP rental deals!',
                                  ),
                                  backgroundColor: Color(0xFFE50914),
                                ),
                              );
                              _newsletterController.clear();
                            }
                          },
                          child: Container(
                            height: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE50914),
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(7),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Subscribe',
                              style: GoogleFonts.outfit(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Footer ─────────────────────────────────────────────────────────────────
  Widget _buildFooter(bool isDesktop) {
    return Container(
      color: const Color(0xFF080A0E),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 20,
        vertical: 48,
      ),
      child: Column(
        children: [
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo & Slogan (Left)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildBrandSpeedometerIcon(),
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
                                color: const Color(0xFFE50914),
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

              if (!isDesktop) const SizedBox(height: 30),

              // Links 1: Rental Fleet
              _buildFooterColumn('Rental Fleet', [
                'Luxury Sedans',
                'Sports & Exotics',
                'SUVs & Vans',
                'Long-Term Leases',
              ]),

              if (!isDesktop) const SizedBox(height: 24),

              // Links 2: Company
              _buildFooterColumn('Company', [
                'About Go Drive',
                'Our Team',
                'Rental Terms',
                'Press & Media',
              ]),

              if (!isDesktop) const SizedBox(height: 24),

              // Links 3: Customer Care
              _buildFooterColumn('Customer Care', [
                'Rental FAQs',
                'Insurance & Protection',
                'Damage Coverage',
                'Cancellation Policy',
              ]),

              if (!isDesktop) const SizedBox(height: 24),

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

  // Speedometer Brand Logo Icon
  Widget _buildBrandSpeedometerIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Color(0xFFE50914),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(Icons.speed_rounded, color: Colors.white, size: 18),
      ),
    );
  }
}
