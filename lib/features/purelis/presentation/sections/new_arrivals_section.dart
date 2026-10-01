import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/product.dart';
import '../providers/purelis_providers.dart';
import '../theme/purelis_colors.dart';
import '../widgets/product_card.dart';

class NewArrivalsSection extends ConsumerWidget {
  final bool isDesktop;
  final bool isTablet;
  final ValueChanged<Product> onAddToCart;
  final VoidCallback? onViewAll;
  final GlobalKey? sectionKey;

  const NewArrivalsSection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onAddToCart,
    this.onViewAll,
    this.sectionKey,
  });

  static const List<Product> defaultProducts = [
    Product(
      id: 'prod_facewash',
      name: 'Calming Green Tea Face Wash',
      price: 499,
      formattedPrice: '₹499',
      image: 'assets/purelis_prod_facewash.jpg',
      description:
          'Enriched with soothing green tea extract & chamomile to cleanse without stripping natural moisture.',
      size: '150 ml e 5.07 fl oz',
    ),
    Product(
      id: 'prod_serum',
      name: 'Vitamin C Brightening Serum',
      price: 799,
      formattedPrice: '₹799',
      image: 'assets/purelis_prod_serum.jpg',
      description:
          'Potent antioxidant formula with 15% Vitamin C, Kakadu Plum & Hyaluronic Acid for radiant glowing skin.',
      size: '30 ml e 1.0 fl oz',
    ),
    Product(
      id: 'prod_moisturizer',
      name: 'Hydra Barrier Moisturizer',
      price: 649,
      formattedPrice: '₹649',
      image: 'assets/purelis_prod_moisturizer.jpg',
      description:
          'Restorative ceramide gel cream that locks in 48-hour hydration while strengthening the skin barrier.',
      size: '50 g e 1.7 oz',
    ),
    Product(
      id: 'prod_lipbalm',
      name: 'Tinted Lip Balm SPF 50',
      price: 299,
      formattedPrice: '₹299',
      image: 'assets/purelis_prod_lipbalm.png',
      description:
          'Nourishing sheer rose tint with mineral SPF 20 defense and organic botanical oils.',
      size: '4.5 g e 0.16 oz',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);

    return Container(
      key: sectionKey,
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
                  color: PurelisColors.textPrimary,
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if (onViewAll != null) {
                      onViewAll!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: PurelisColors.topBarGreen,
                          content: Text(
                            'Displaying all 18 seasonal skincare arrivals',
                            style: GoogleFonts.outfit(color: Colors.white),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'VIEW ALL',
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                      color: PurelisColors.textPrimary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // 4 Product Cards Grid / Row
          productsAsync.when(
            data: (products) => _buildProductList(products),
            loading: () => _buildProductList(defaultProducts),
            error: (_, __) => _buildProductList(defaultProducts),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (isDesktop) {
          return Row(
            children: products.map((product) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ProductCard(
                    product: product,
                    onAddToCart: onAddToCart,
                  ),
                ),
              );
            }).toList(),
          );
        } else if (isTablet) {
          final double cardWidth = (constraints.maxWidth - 20) / 2;
          return Wrap(
            spacing: 20,
            runSpacing: 24,
            children: products.map((product) {
              return SizedBox(
                width: cardWidth,
                child: ProductCard(
                  product: product,
                  onAddToCart: onAddToCart,
                ),
              );
            }).toList(),
          );
        } else {
          return Column(
            children: products.map((product) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ProductCard(
                  product: product,
                  onAddToCart: onAddToCart,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
