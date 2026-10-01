import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_category_model.dart';
import '../models/product_model.dart';
import '../models/purelis_content_model.dart';
import '../models/trust_badge_model.dart';
import '../models/value_proposition_model.dart';

abstract class PurelisLocalDataSource {
  Future<List<ProductCategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts();
  Future<PurelisContentModel> getContent();
}

class PurelisLocalDataSourceImpl implements PurelisLocalDataSource {
  static const String _categoriesAsset = 'assets/mock/purelis/categories.json';
  static const String _productsAsset = 'assets/mock/purelis/products.json';
  static const String _websiteAsset = 'assets/mock/purelis/website.json';

  @override
  Future<List<ProductCategoryModel>> getCategories() async {
    try {
      final jsonStr = await rootBundle.loadString(_categoriesAsset);
      final List<dynamic> list = jsonDecode(jsonStr) as List<dynamic>;
      return list
          .map((e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return _fallbackCategories;
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final jsonStr = await rootBundle.loadString(_productsAsset);
      final List<dynamic> list = jsonDecode(jsonStr) as List<dynamic>;
      return list
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return _fallbackProducts;
    }
  }

  @override
  Future<PurelisContentModel> getContent() async {
    try {
      final categoriesFuture = getCategories();
      final productsFuture = getProducts();
      final websiteStr = await rootBundle.loadString(_websiteAsset);
      final websiteJson = jsonDecode(websiteStr) as Map<String, dynamic>;

      final categories = await categoriesFuture;
      final products = await productsFuture;

      final valueProps = (websiteJson['valuePropositions'] as List<dynamic>? ?? [])
          .map((e) => ValuePropositionModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final trustBadges = (websiteJson['trustBadges'] as List<dynamic>? ?? [])
          .map((e) => TrustBadgeModel.fromJson(e as Map<String, dynamic>))
          .toList();
      final ecoBadges = (websiteJson['ecoBadges'] as List<dynamic>? ?? [])
          .map((e) => EcoBadgeModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return PurelisContentModel(
        categories: categories,
        products: products,
        valuePropositions: valueProps,
        trustBadges: trustBadges,
        ecoBadges: ecoBadges,
      );
    } catch (_) {
      return const PurelisContentModel(
        categories: _fallbackCategories,
        products: _fallbackProducts,
        valuePropositions: _fallbackValueProps,
        trustBadges: _fallbackTrustBadges,
        ecoBadges: _fallbackEcoBadges,
      );
    }
  }

  static const List<ProductCategoryModel> _fallbackCategories = [
    ProductCategoryModel(
      id: 'cleansers',
      title: 'CLEANSERS',
      image: 'assets/purelis_cat_cleansers.jpg',
    ),
    ProductCategoryModel(
      id: 'serums',
      title: 'SERUMS',
      image: 'assets/purelis_cat_serums.jpg',
    ),
    ProductCategoryModel(
      id: 'moisturizers',
      title: 'MOISTURIZERS',
      image: 'assets/purelis_cat_moisturizers.jpg',
    ),
    ProductCategoryModel(
      id: 'suncare',
      title: 'SUN CARE',
      image: 'assets/purelis_cat_suncare.jpg',
    ),
    ProductCategoryModel(
      id: 'kits',
      title: 'SKIN CARE KITS',
      image: 'assets/purelis_cat_kits.jpg',
    ),
    ProductCategoryModel(
      id: 'bestsellers',
      title: 'BEST SELLERS',
      image: 'assets/purelis_cat_bestsellers.jpg',
    ),
  ];

  static const List<ProductModel> _fallbackProducts = [
    ProductModel(
      id: 'prod_facewash',
      name: 'Calming Green Tea Face Wash',
      price: 499,
      formattedPrice: '₹499',
      image: 'assets/purelis_prod_facewash.jpg',
      description:
          'Enriched with soothing green tea extract & chamomile to cleanse without stripping natural moisture.',
      size: '150 ml e 5.07 fl oz',
    ),
    ProductModel(
      id: 'prod_serum',
      name: 'Vitamin C Brightening Serum',
      price: 799,
      formattedPrice: '₹799',
      image: 'assets/purelis_prod_serum.jpg',
      description:
          'Potent antioxidant formula with 15% Vitamin C, Kakadu Plum & Hyaluronic Acid for radiant glowing skin.',
      size: '30 ml e 1.0 fl oz',
    ),
    ProductModel(
      id: 'prod_moisturizer',
      name: 'Hydra Barrier Moisturizer',
      price: 649,
      formattedPrice: '₹649',
      image: 'assets/purelis_prod_moisturizer.jpg',
      description:
          'Restorative ceramide gel cream that locks in 48-hour hydration while strengthening the skin barrier.',
      size: '50 g e 1.7 oz',
    ),
    ProductModel(
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

  static const List<ValuePropositionModel> _fallbackValueProps = [
    ValuePropositionModel(
      icon: 'eco_outlined',
      title: 'Natural Ingredients',
      subtitle: 'Safe & toxin-free',
    ),
    ValuePropositionModel(
      icon: 'science_outlined',
      title: 'Clinically Tested',
      subtitle: 'Dermatologically proven',
    ),
    ValuePropositionModel(
      icon: 'pets_outlined',
      title: 'Cruelty Free',
      subtitle: 'We never test on animals',
    ),
    ValuePropositionModel(
      icon: 'water_drop_outlined',
      title: 'For All Skin Types',
      subtitle: 'Gentle & effective care',
    ),
  ];

  static const List<TrustBadgeModel> _fallbackTrustBadges = [
    TrustBadgeModel(
      icon: 'local_shipping_outlined',
      title: 'FREE SHIPPING',
      subtitle: 'On orders over ₹499',
    ),
    TrustBadgeModel(
      icon: 'cached_rounded',
      title: 'EASY RETURNS',
      subtitle: '14 days return policy',
    ),
    TrustBadgeModel(
      icon: 'verified_user_outlined',
      title: 'SECURE PAYMENT',
      subtitle: '100% secure checkout',
    ),
  ];

  static const List<EcoBadgeModel> _fallbackEcoBadges = [
    EcoBadgeModel(
      icon: 'spa_outlined',
      text: 'Clean Beauty',
    ),
    EcoBadgeModel(
      icon: 'autorenew_rounded',
      text: 'Sustainable',
    ),
    EcoBadgeModel(
      icon: 'inventory_2_outlined',
      text: 'Eco-Friendly Packaging',
    ),
  ];
}
