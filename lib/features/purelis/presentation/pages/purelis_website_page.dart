import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../controllers/purelis_scroll_controller.dart';
import '../dialogs/purelis_account_dialog.dart';
import '../dialogs/purelis_search_dialog.dart';
import '../sections/copyright_section.dart';
import '../sections/footer_section.dart';
import '../sections/header_section.dart';
import '../sections/hero_section.dart';
import '../sections/new_arrivals_section.dart';
import '../sections/promo_banner_section.dart';
import '../sections/shop_by_category_section.dart';
import '../sections/top_announcement_section.dart';
import '../sections/value_propositions_section.dart';
import '../theme/purelis_colors.dart';
import '../utils/purelis_responsive.dart';
import '../widgets/floating_portfolio_button.dart';

class PurelisWebsitePage extends ConsumerStatefulWidget {
  const PurelisWebsitePage({super.key});

  @override
  ConsumerState<PurelisWebsitePage> createState() => _PurelisWebsitePageState();
}

class _PurelisWebsitePageState extends ConsumerState<PurelisWebsitePage> {
  late final PurelisScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = PurelisScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addToCart(Product product) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: PurelisColors.topBarGreen,
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
                'Added ${product.name} to cart',
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

  void _onCategoryTap(ProductCategory category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: PurelisColors.topBarGreen,
        content: Text(
          'Showing ${category.title} collection',
          style: GoogleFonts.outfit(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    _scrollController.scrollToNewArrivals();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = PurelisResponsive.isDesktop(context);
    final isTablet = PurelisResponsive.isTablet(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Main Scrollable Page ──────────────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Top Announcement Bar
                TopAnnouncementSection(isDesktop: isDesktop),

                // 2. Main Navigation Header
                HeaderSection(
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  onLogoTap: _scrollController.scrollToTop,
                  onShopTap: _scrollController.scrollToCategories,
                  onCollectionsTap: _scrollController.scrollToNewArrivals,
                  onAboutTap: _scrollController.scrollToAbout,
                  onContactTap: _scrollController.scrollToAbout,
                  onSearchTap: () => PurelisSearchDialog.show(
                    context,
                    onSearch: _scrollController.scrollToNewArrivals,
                  ),
                  onAccountTap: () => PurelisAccountDialog.show(context),
                ),

                // 3. Hero Section
                HeroSection(
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  onShopNowTap: _scrollController.scrollToNewArrivals,
                ),

                // 4. Value Propositions Bar
                ValuePropositionsSection(
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),

                const SizedBox(height: 50),

                // 5. Shop By Category
                ShopByCategorySection(
                  sectionKey: _scrollController.categoriesKey,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  onCategoryTap: _onCategoryTap,
                ),

                const SizedBox(height: 50),

                // 6. Good for your skin, Good for the planet (Promo Banner)
                PromoBannerSection(
                  sectionKey: _scrollController.promoKey,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  onExploreOffersTap: _scrollController.scrollToNewArrivals,
                ),

                const SizedBox(height: 60),

                // 7. New Arrivals Section
                NewArrivalsSection(
                  sectionKey: _scrollController.newArrivalsKey,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  onAddToCart: _addToCart,
                ),

                const SizedBox(height: 70),

                // 8. Footer & Trust Badges + Newsletter + About
                FooterSection(
                  sectionKey: _scrollController.aboutKey,
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                ),

                // 9. Bottom Copyright & Legal Bar
                CopyrightSection(isDesktop: isDesktop),
              ],
            ),
          ),

          // ── Floating Go Back to Portfolio Button (Top-Right) ──────────────
          const Positioned(
            top: 48,
            right: 20,
            child: FloatingPortfolioButton(),
          ),
        ],
      ),
    );
  }
}
