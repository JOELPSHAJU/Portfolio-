import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/widgets/app_image.dart';
import '../../domain/entities/product.dart';
import '../providers/wishlist_provider.dart';
import '../theme/purelis_colors.dart';
import 'skincare_button.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final ValueChanged<Product> onAddToCart;
  final ValueChanged<String>? onToggleWishlist;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistProvider);
    final bool isFavorited = wishlist.contains(product.id);

    return Container(
      decoration: BoxDecoration(
        color: PurelisColors.cardBg,
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
                      assetPath: product.image,
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
                      onTap: () {
                        if (onToggleWishlist != null) {
                          onToggleWishlist!(product.id);
                        } else {
                          ref.read(wishlistProvider.notifier).toggle(product.id);
                        }
                      },
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
                              ? PurelisColors.wishlistActive
                              : PurelisColors.wishlistInactive,
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
                  product.name,
                  style: GoogleFonts.outfit(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: PurelisColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  product.formattedPrice,
                  style: GoogleFonts.outfit(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: PurelisColors.topBarGreen,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: SkincareButton(
                    label: 'ADD TO CART',
                    isFullWidth: true,
                    onTap: () => onAddToCart(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
