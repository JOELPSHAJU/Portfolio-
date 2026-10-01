import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/product_category.dart';
import '../providers/purelis_providers.dart';
import '../theme/purelis_colors.dart';
import '../widgets/category_card.dart';

class ShopByCategorySection extends ConsumerWidget {
  final bool isDesktop;
  final bool isTablet;
  final ValueChanged<ProductCategory> onCategoryTap;
  final GlobalKey? sectionKey;

  const ShopByCategorySection({
    super.key,
    required this.isDesktop,
    required this.isTablet,
    required this.onCategoryTap,
    this.sectionKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Container(
      key: sectionKey,
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
              color: PurelisColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Category Cards Row/Grid
          categoriesAsync.when(
            data: (categories) => _buildCategoryList(context, categories),
            loading: () => _buildCategoryList(
              context,
              const [
                ProductCategory(
                  id: 'cleansers',
                  title: 'CLEANSERS',
                  image: 'assets/purelis_cat_cleansers.jpg',
                ),
                ProductCategory(
                  id: 'serums',
                  title: 'SERUMS',
                  image: 'assets/purelis_cat_serums.jpg',
                ),
                ProductCategory(
                  id: 'moisturizers',
                  title: 'MOISTURIZERS',
                  image: 'assets/purelis_cat_moisturizers.jpg',
                ),
                ProductCategory(
                  id: 'suncare',
                  title: 'SUN CARE',
                  image: 'assets/purelis_cat_suncare.jpg',
                ),
                ProductCategory(
                  id: 'kits',
                  title: 'SKIN CARE KITS',
                  image: 'assets/purelis_cat_kits.jpg',
                ),
                ProductCategory(
                  id: 'bestsellers',
                  title: 'BEST SELLERS',
                  image: 'assets/purelis_cat_bestsellers.jpg',
                ),
              ],
            ),
            error: (_, __) => _buildCategoryList(
              context,
              const [
                ProductCategory(
                  id: 'cleansers',
                  title: 'CLEANSERS',
                  image: 'assets/purelis_cat_cleansers.jpg',
                ),
                ProductCategory(
                  id: 'serums',
                  title: 'SERUMS',
                  image: 'assets/purelis_cat_serums.jpg',
                ),
                ProductCategory(
                  id: 'moisturizers',
                  title: 'MOISTURIZERS',
                  image: 'assets/purelis_cat_moisturizers.jpg',
                ),
                ProductCategory(
                  id: 'suncare',
                  title: 'SUN CARE',
                  image: 'assets/purelis_cat_suncare.jpg',
                ),
                ProductCategory(
                  id: 'kits',
                  title: 'SKIN CARE KITS',
                  image: 'assets/purelis_cat_kits.jpg',
                ),
                ProductCategory(
                  id: 'bestsellers',
                  title: 'BEST SELLERS',
                  image: 'assets/purelis_cat_bestsellers.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(
    BuildContext context,
    List<ProductCategory> categories,
  ) {
    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: categories.map((cat) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CategoryCard(
                category: cat,
                onTap: () => onCategoryTap(cat),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 3 : 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 14,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return CategoryCard(
            category: cat,
            onTap: () => onCategoryTap(cat),
          );
        },
      );
    }
  }
}
