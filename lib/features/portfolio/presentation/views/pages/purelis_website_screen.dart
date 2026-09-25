import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';

/// Complete interactive, pixel-perfect recreation of the Purelis Skincare website.
/// Matches 100% of the visual layout, color palette, typography, product showcases,
/// promotional banners, and e-commerce interactions.
class PurelisWebsiteScreen extends StatefulWidget {
  const PurelisWebsiteScreen({super.key});

  @override
  State<PurelisWebsiteScreen> createState() => _PurelisWebsiteScreenState();
}

class _PurelisWebsiteScreenState extends State<PurelisWebsiteScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _newsletterController = TextEditingController();

  // Color Palette - exact match to reference
  static const Color kTopBarGreen = Color(0xFF1E3822);
  static const Color kHeroBg = Color(0xFFEBE7DE);
  static const Color kPromoBg = Color(0xFFE4ECE2);
  static const Color kValuesBg = Color(0xFFFAF9F5);
  static const Color kFooterBg = Color(0xFFF3F5F0);
  static const Color kCopyrightBg = Color(0xFF142918);
  static const Color kTextPrimary = Color(0xFF1C271D);
  static const Color kTextMuted = Color(0xFF6B746C);
  static const Color kCardBg = Color(0xFFFAF9F6);

  // Global Keys for smooth scrolling
  final GlobalKey _categoriesKey = GlobalKey();
  final GlobalKey _promoKey = GlobalKey();
  final GlobalKey _newArrivalsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  // Wishlist state
  final Set<String> _wishlist = {};

  // Categories list
  final List<Map<String, String>> _categories = [
    {
      'id': 'cleansers',
      'title': 'CLEANSERS',
      'image': 'assets/purelis_cat_cleansers.jpg',
    },
    {
      'id': 'serums',
      'title': 'SERUMS',
      'image': 'assets/purelis_cat_serums.jpg',
    },
    {
      'id': 'moisturizers',
      'title': 'MOISTURIZERS',
      'image': 'assets/purelis_cat_moisturizers.jpg',
    },
    {
      'id': 'suncare',
      'title': 'SUN CARE',
      'image': 'assets/purelis_cat_suncare.jpg',
    },
    {
      'id': 'kits',
      'title': 'SKIN CARE KITS',
      'image': 'assets/purelis_cat_kits.jpg',
    },
    {
      'id': 'bestsellers',
      'title': 'BEST SELLERS',
      'image': 'assets/purelis_cat_bestsellers.jpg',
    },
  ];

  // New Arrivals products
  final List<Map<String, dynamic>> _products = [
    {
      'id': 'prod_facewash',
      'name': 'Calming Green Tea Face Wash',
      'price': 499,
      'formattedPrice': '₹499',
      'image': 'assets/purelis_prod_facewash.jpg',
      'description':
          'Enriched with soothing green tea extract & chamomile to cleanse without stripping natural moisture.',
      'size': '150 ml e 5.07 fl oz',
    },
    {
      'id': 'prod_serum',
      'name': 'Vitamin C Brightening Serum',
      'price': 799,
      'formattedPrice': '₹799',
      'image': 'assets/purelis_prod_serum.jpg',
      'description':
          'Potent antioxidant formula with 15% Vitamin C, Kakadu Plum & Hyaluronic Acid for radiant glowing skin.',
      'size': '30 ml e 1.0 fl oz',
    },
    {
      'id': 'prod_moisturizer',
      'name': 'Hydra Barrier Moisturizer',
      'price': 649,
      'formattedPrice': '₹649',
      'image': 'assets/purelis_prod_moisturizer.jpg',
      'description':
          'Restorative ceramide gel cream that locks in 48-hour hydration while strengthening the skin barrier.',
      'size': '50 g e 1.7 oz',
    },
    {
      'id': 'prod_lipbalm',
      'name': 'Tinted Lip Balm SPF 50',
      'price': 299,
      'formattedPrice': '₹299',
      'image': 'assets/purelis_prod_lipbalm.png',
      'description':
          'Nourishing sheer rose tint with mineral SPF 20 defense and organic botanical oils.',
      'size': '4.5 g e 0.16 oz',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _newsletterController.dispose();
    super.dispose();
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _addToCart(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kTopBarGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Added ${product['name']} to cart',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.5,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleWishlist(String id) {
    setState(() {
      if (_wishlist.contains(id)) {
        _wishlist.remove(id);
      } else {
        _wishlist.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1024;
    final isTablet = size.width >= 650 && size.width < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Main Scrollable Page ──────────────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Top Announcement Bar
                _buildTopAnnouncementBar(isDesktop),

                // 2. Main Navigation Header
                _buildHeader(isDesktop, isTablet),

                // 3. Hero Section
                _buildHeroSection(isDesktop, isTablet, size),

                // 4. Value Propositions Bar
                _buildValuePropsBar(isDesktop, isTablet),

                const SizedBox(height: 50),

                // 5. Shop By Category
                _buildShopByCategorySection(isDesktop, isTablet),

                const SizedBox(height: 50),

                // 6. Good for your skin, Good for the planet (Promo Banner)
                _buildPromoBannerSection(isDesktop, isTablet),

                const SizedBox(height: 60),

                // 7. New Arrivals Section
                _buildNewArrivalsSection(isDesktop, isTablet),

                const SizedBox(height: 70),

                // 8. Footer & Trust Badges + Newsletter + About
                _buildFooterSection(isDesktop, isTablet),

                // 9. Bottom Copyright & Legal Bar
                _buildCopyrightBar(isDesktop),
              ],
            ),
          ),

          // ── Floating Go Back to Portfolio Button (Top-Right) ──────────────
          Positioned(top: 48, right: 20, child: _buildFloatingBackButton()),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 1. TOP ANNOUNCEMENT BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildTopAnnouncementBar(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: kTopBarGreen,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Offer text
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Free shipping on orders over ₹499 | Use code: PURE20 for 20% OFF 🌿',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: isDesktop ? 12.0 : 10.5,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Right Social Icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSocialIcon('f', 'Facebook'),
              const SizedBox(width: 14),
              _buildSocialIcon('ig', 'Instagram'),
              const SizedBox(width: 14),
              _buildSocialIcon('yt', 'YouTube'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String type, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 2. MAIN NAVIGATION HEADER
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader(bool isDesktop, bool isTablet) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEBE8E1), width: 1.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Brand Logo
          _buildBrandLogo(),

          // Center: Navigation links (Desktop)
          if (isDesktop)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNavLink('HOME', isSelected: true, onTap: () {}),
                const SizedBox(width: 32),
                _buildNavLinkWithDropdown(
                  'SHOP',
                  onTap: () {
                    _scrollToKey(_categoriesKey);
                  },
                ),
                const SizedBox(width: 32),
                _buildNavLinkWithDropdown(
                  'COLLECTIONS',
                  onTap: () {
                    _scrollToKey(_newArrivalsKey);
                  },
                ),
                const SizedBox(width: 32),
                _buildNavLink(
                  'ABOUT US',
                  onTap: () {
                    _scrollToKey(_aboutKey);
                  },
                ),
                const SizedBox(width: 32),
                _buildNavLink('BLOG', onTap: () {}),
                const SizedBox(width: 32),
                _buildNavLink(
                  'CONTACT',
                  onTap: () {
                    _scrollToKey(_aboutKey);
                  },
                ),
              ],
            ),

          // Right: Action Icons (Search, Profile, Cart)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _showSearchDialog,
                icon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF222222),
                  size: 21,
                ),
                splashRadius: 20,
                tooltip: 'Search',
              ),
              const SizedBox(width: 6),
              IconButton(
                onPressed: _showAccountDialog,
                icon: const Icon(
                  Icons.person_outline_rounded,
                  color: Color(0xFF222222),
                  size: 21,
                ),
                splashRadius: 20,
                tooltip: 'Account',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco_rounded, size: 16, color: kTopBarGreen),
                const SizedBox(width: 6),
                Text(
                  'PURELIS',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4.5,
                    color: kTextPrimary,
                    height: 1.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'SKINCARE',
                style: GoogleFonts.outfit(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3.5,
                  color: const Color(0xFF6E786E),
                  height: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(
    String label, {
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return _HoverableNavLink(
      label: label,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  Widget _buildNavLinkWithDropdown(
    String label, {
    required VoidCallback onTap,
  }) {
    return _HoverableNavLink(label: label, hasDropdown: true, onTap: onTap);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 3. HERO SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeroSection(bool isDesktop, bool isTablet, Size size) {
    return Container(
      width: double.infinity,
      color: kHeroBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 0,
        vertical: isDesktop ? 0 : 36,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Column: Typography & Shop Now CTA
                Expanded(flex: 5, child: _buildHeroLeftText(isDesktop)),

                const SizedBox(width: 40),

                // Right Column: Skincare Products on Stone Podium
                Expanded(flex: 7, child: _buildHeroRightImage(isDesktop)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroLeftText(isDesktop),
                const SizedBox(height: 36),
                _buildHeroRightImage(isDesktop),
              ],
            ),
    );
  }

  Widget _buildHeroLeftText(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'NATURALLY PURE.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: isDesktop ? 46 : 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              color: kTextPrimary,
              height: 1.1,
            ),
          ),
          Text(
            'BEAUTIFULLY YOU.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: isDesktop ? 46 : 32,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              color: kTopBarGreen,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Clean, effective & cruelty-free skincare\nenriched with nature’s finest ingredients.',
            style: GoogleFonts.outfit(
              fontSize: isDesktop ? 15.5 : 14.0,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF3E4A3E),
              height: 1.55,
            ),
          ),
          const SizedBox(height: 28),
          _SkincareButton(
            label: 'SHOP NOW',
            onTap: () => _scrollToKey(_newArrivalsKey),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroRightImage(bool isDesktop) {
    return SizedBox(
      width: double.infinity,
      height: isDesktop ? 540 : 380,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: const AppImage(
          assetPath: 'assets/purelis_hero.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 4. VALUE PROPOSITIONS BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildValuePropsBar(bool isDesktop, bool isTablet) {
    final items = [
      {
        'icon': Icons.eco_outlined,
        'title': 'Natural Ingredients',
        'subtitle': 'Safe & toxin-free',
      },
      {
        'icon': Icons.science_outlined,
        'title': 'Clinically Tested',
        'subtitle': 'Dermatologically proven',
      },
      {
        'icon': Icons.pets_outlined,
        'title': 'Cruelty Free',
        'subtitle': 'We never test on animals',
      },
      {
        'icon': Icons.water_drop_outlined,
        'title': 'For All Skin Types',
        'subtitle': 'Gentle & effective care',
      },
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 24,
      ),
      decoration: const BoxDecoration(
        color: kValuesBg,
        border: Border(
          top: BorderSide(color: Color(0xFFECE9E0), width: 1.0),
          bottom: BorderSide(color: Color(0xFFECE9E0), width: 1.0),
        ),
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items
                  .map(
                    (item) => _buildValueItem(
                      icon: item['icon'] as IconData,
                      title: item['title'] as String,
                      subtitle: item['subtitle'] as String,
                    ),
                  )
                  .toList(),
            )
          : Wrap(
              spacing: 24,
              runSpacing: 20,
              alignment: WrapAlignment.spaceAround,
              children: items
                  .map(
                    (item) => SizedBox(
                      width: isTablet ? 240 : 160,
                      child: _buildValueItem(
                        icon: item['icon'] as IconData,
                        title: item['title'] as String,
                        subtitle: item['subtitle'] as String,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Widget _buildValueItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 28, color: const Color(0xFF2C3E2F)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.outfit(
                fontSize: 11.5,
                fontWeight: FontWeight.w400,
                color: kTextMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 5. SHOP BY CATEGORY SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildShopByCategorySection(bool isDesktop, bool isTablet) {
    return Container(
      key: _categoriesKey,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 60 : 20),
      child: Column(
        children: [
          // Section Title
          Text(
            'SHOP BY CATEGORY',
            style: GoogleFonts.cormorantGaramond(
              fontSize: isDesktop ? 28 : 24,
              fontWeight: FontWeight.w700,
              letterSpacing: 3.5,
              color: kTextPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // 6 Category Cards Row/Grid
          LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _categories.map((cat) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: _buildCategoryCard(cat),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(_categories[index]);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Map<String, String> cat) {
    return _HoverableCategoryCard(
      title: cat['title']!,
      imagePath: cat['image']!,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kTopBarGreen,
            content: Text(
              'Showing ${cat['title']} collection',
              style: GoogleFonts.outfit(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        _scrollToKey(_newArrivalsKey);
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 6. PROMOTIONAL BANNER SECTION: UP TO 25% OFF SITEWIDE
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildPromoBannerSection(bool isDesktop, bool isTablet) {
    return Container(
      key: _promoKey,
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 60 : 20),
      decoration: BoxDecoration(
        color: kPromoBg,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: isDesktop
          ? const EdgeInsets.symmetric(horizontal: 44)
          : const EdgeInsets.all(24),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left promo copy (keeps vertical padding)
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 44),
                    child: _buildPromoLeftContent(),
                  ),
                ),

                const SizedBox(width: 40),

                // Right promo product arrangement (no vertical padding, bigger image)
                Expanded(
                  flex: 7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const AppImage(
                      assetPath: 'assets/purelis_promo.png',
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPromoLeftContent(),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const AppImage(
                    assetPath: 'assets/purelis_promo.png',
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPromoLeftContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'GOOD FOR YOUR SKIN.\nGOOD FOR THE PLANET.',
          style: GoogleFonts.outfit(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
            color: const Color(0xFF2C452E),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Up to 25% Off\nSitewide',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 42,
            fontWeight: FontWeight.w700,
            color: kTextPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 22),
        _SkincareButton(
          label: 'EXPLORE OFFERS',
          onTap: () => _scrollToKey(_newArrivalsKey),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: [
            _buildEcoBadge(Icons.spa_outlined, 'Clean Beauty'),
            _buildEcoBadge(Icons.autorenew_rounded, 'Sustainable'),
            _buildEcoBadge(
              Icons.inventory_2_outlined,
              'Eco-Friendly Packaging',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEcoBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: const Color(0xFF2E4631)),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334635),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 7. NEW ARRIVALS SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildNewArrivalsSection(bool isDesktop, bool isTablet) {
    return Container(
      key: _newArrivalsKey,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 60 : 20),
      child: Column(
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'NEW ARRIVALS',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isDesktop ? 28 : 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.5,
                  color: kTextPrimary,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: kTopBarGreen,
                        content: Text(
                          'Displaying all 18 seasonal skincare arrivals',
                          style: GoogleFonts.outfit(color: Colors.white),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text(
                    'VIEW ALL',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: kTextPrimary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // 4 Product Cards Grid / Row
          LayoutBuilder(
            builder: (context, constraints) {
              if (isDesktop) {
                return Row(
                  children: _products.map((product) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: _buildProductCard(product),
                      ),
                    );
                  }).toList(),
                );
              } else if (isTablet) {
                final double cardWidth = (constraints.maxWidth - 20) / 2;
                return Wrap(
                  spacing: 20,
                  runSpacing: 24,
                  children: _products.map((product) {
                    return SizedBox(
                      width: cardWidth,
                      child: _buildProductCard(product),
                    );
                  }).toList(),
                );
              } else {
                return Column(
                  children: _products.map((product) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildProductCard(product),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final String id = product['id'] as String;
    final bool isFavorited = _wishlist.contains(id);

    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        border: Border.all(color: const Color(0xFFEBE8E1), width: 1.0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image with Wishlist Heart in top right
          AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                    child: AppImage(
                      assetPath: product['image'] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Heart Wishlist Icon Button
                Positioned(
                  top: 10,
                  right: 10,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _toggleWishlist(id),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorited
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          size: 17,
                          color: isFavorited
                              ? const Color(0xFFD32F2F)
                              : const Color(0xFF444444),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product Details & Add to Cart
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  product['name'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  product['formattedPrice'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: kTopBarGreen,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: _SkincareButton(
                    label: 'ADD TO CART',
                    isFullWidth: true,
                    onTap: () => _addToCart(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 8. FOOTER SECTION: TRUST BADGES | NEWSLETTER | ABOUT PURELIS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFooterSection(bool isDesktop, bool isTablet) {
    return Container(
      key: _aboutKey,
      color: kFooterBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 50,
      ),
      child: isDesktop
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
                const Divider(height: 50, color: Color(0xFFDCD8CF)),
                _buildNewsletterColumn(),
                const Divider(height: 50, color: Color(0xFFDCD8CF)),
                _buildAboutColumn(),
              ],
            ),
    );
  }

  Widget _buildTrustBadgesColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTrustBadgeItem(
          icon: Icons.local_shipping_outlined,
          title: 'FREE SHIPPING',
          subtitle: 'On orders over ₹499',
        ),
        const SizedBox(height: 22),
        _buildTrustBadgeItem(
          icon: Icons.cached_rounded,
          title: 'EASY RETURNS',
          subtitle: '14 days return policy',
        ),
        const SizedBox(height: 22),
        _buildTrustBadgeItem(
          icon: Icons.verified_user_outlined,
          title: 'SECURE PAYMENT',
          subtitle: '100% secure checkout',
        ),
      ],
    );
  }

  Widget _buildTrustBadgeItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: const Color(0xFF2C3E2F)),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: kTextPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.outfit(fontSize: 12.0, color: kTextMuted),
            ),
          ],
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
            color: kTextPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Get exclusive offers, beauty tips & new product updates.',
          style: GoogleFonts.outfit(fontSize: 12.5, color: kTextMuted),
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
                  border: Border.all(color: const Color(0xFFD4D0C5)),
                  borderRadius: BorderRadius.circular(2),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: _newsletterController,
                  style: GoogleFonts.outfit(fontSize: 13, color: kTextPrimary),
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
            _SkincareButton(
              label: 'SUBSCRIBE',
              onTap: () {
                final email = _newsletterController.text.trim();
                if (email.isNotEmpty && email.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kTopBarGreen,
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
                      backgroundColor: const Color(0xFF8D2B2B),
                      content: Text(
                        'Please enter a valid email address.',
                        style: GoogleFonts.outfit(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Social Icons Row
        Row(
          children: [
            _buildFooterSocialIcon('f', 'Facebook'),
            const SizedBox(width: 14),
            _buildFooterSocialIcon('ig', 'Instagram'),
            const SizedBox(width: 14),
            _buildFooterSocialIcon('yt', 'YouTube'),
            const SizedBox(width: 14),
            _buildFooterSocialIcon('p', 'Pinterest'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterSocialIcon(String type, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
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
            color: kTextPrimary,
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
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kTopBarGreen,
                  content: Text(
                    'Purelis Skincare: Certified cruelty-free, vegan & eco-formulated.',
                    style: GoogleFonts.outfit(color: Colors.white),
                  ),
                ),
              );
            },
            child: Text(
              'LEARN MORE',
              style: GoogleFonts.outfit(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
                color: kTopBarGreen,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 9. BOTTOM COPYRIGHT & LEGAL BAR
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildCopyrightBar(bool isDesktop) {
    return Container(
      width: double.infinity,
      color: kCopyrightBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: 14,
      ),
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2025 Purelis Skincare. All Rights Reserved.',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFADC4B0),
                    fontSize: 11.5,
                  ),
                ),
                Text(
                  'Privacy Policy   |   Terms & Conditions   |   Shipping Policy   |   Contact Us',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFADC4B0),
                    fontSize: 11.5,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  '© 2025 Purelis Skincare. All Rights Reserved.',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFADC4B0),
                    fontSize: 11.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Privacy Policy | Terms & Conditions | Shipping Policy | Contact Us',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFADC4B0),
                    fontSize: 10.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FLOATING BACK TO PORTFOLIO BUTTON
  // ═══════════════════════════════════════════════════════════════════════════
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
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 10,
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
                      letterSpacing: 2,
                      color: Colors.white,
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

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            const Icon(Icons.search_rounded, color: kTopBarGreen),
            const SizedBox(width: 8),
            Text(
              'Search Purelis Skincare',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search cleansers, serums, sun care...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: const Icon(Icons.search_rounded),
          ),
          onSubmitted: (query) {
            Navigator.pop(context);
            _scrollToKey(_newArrivalsKey);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _scrollToKey(_newArrivalsKey);
            },
            style: ElevatedButton.styleFrom(backgroundColor: kTopBarGreen),
            child: const Text('SEARCH', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Purelis Skincare Club',
          style: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kTextPrimary,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sign in to access your wishlist, redeem glow points, and track shipments.',
              style: GoogleFonts.outfit(fontSize: 13, color: kTextMuted),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kTopBarGreen,
                  content: Text(
                    'Welcome back to Purelis Club!',
                    style: GoogleFonts.outfit(color: Colors.white),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: kTopBarGreen),
            child: const Text('SIGN IN', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// REUSABLE HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Signature Dark Forest Green Button matching the original design
class _SkincareButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isFullWidth;

  const _SkincareButton({
    required this.label,
    required this.onTap,
    this.isFullWidth = false,
  });

  @override
  State<_SkincareButton> createState() => _SkincareButtonState();
}

class _SkincareButtonState extends State<_SkincareButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.isFullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFF132817)
                : const Color(0xFF1E3822),
            borderRadius: BorderRadius.circular(2),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF1E3822).withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// Category Card with hover effects and exact bottom pill button
class _HoverableCategoryCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const _HoverableCategoryCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<_HoverableCategoryCard> createState() => _HoverableCategoryCardState();
}

class _HoverableCategoryCardState extends State<_HoverableCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            // Image Box
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              transform: _isHovered
                  ? Matrix4.translationValues(0, -4, 0)
                  : Matrix4.identity(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : [],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: AppImage(
                    assetPath: widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Bottom pill button matching the reference
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: _isHovered
                      ? const Color(0xFF1E3822)
                      : const Color(0xFFE2DFD6),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                widget.title,
                style: GoogleFonts.outfit(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: _isHovered
                      ? const Color(0xFF1E3822)
                      : const Color(0xFF222222),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigation link with smooth hover animations
class _HoverableNavLink extends StatefulWidget {
  final String label;
  final bool isSelected;
  final bool hasDropdown;
  final VoidCallback onTap;

  const _HoverableNavLink({
    required this.label,
    this.isSelected = false,
    this.hasDropdown = false,
    required this.onTap,
  });

  @override
  State<_HoverableNavLink> createState() => _HoverableNavLinkState();
}

class _HoverableNavLinkState extends State<_HoverableNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: GoogleFonts.outfit(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: (widget.isSelected || _isHovered)
                    ? const Color(0xFF1E3822)
                    : const Color(0xFF2A2A2A),
              ),
            ),
            if (widget.hasDropdown) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 15,
                color: (widget.isSelected || _isHovered)
                    ? const Color(0xFF1E3822)
                    : const Color(0xFF555555),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
