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
  String _selectedType = 'Any Type';
  String _selectedLocation = 'Any Location';
  String _selectedDuration = 'Any Duration';
  String _selectedPrice = 'Any Budget';

  final Set<String> _wishlist = {};

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
    super.dispose();
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

                        // 2. Hero Section
                        _buildHeroSection(size, isDesktop),

                        // 3. Search Filter Floating Bar
                        _buildSearchFilterBar(isDesktop),

                        // 4. Value Propositions Bar
                        _buildValueProps(isDesktop),

                        const SizedBox(height: 36),

                        // 5. Popular Vehicles & Side Banners
                        _buildPopularVehiclesSection(isDesktop),

                        const SizedBox(height: 48),

                        // 6. Newsletter "Stay in the Loop" Banner
                        _buildNewsletterBanner(isDesktop),

                        const SizedBox(height: 50),

                        // 7. Footer
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
                    onTap: () => setState(() => _selectedSidebarIdx = idx),
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
                    onPressed: () {},
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
                final isActive = idx == 0;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
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
                        if (isActive)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 2,
                            width: 18,
                            color: const Color(0xFFE50914),
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

          // Right "Rent a Car Now" CTA Button
          MouseRegion(
            cursor: SystemMouseCursors.click,
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
