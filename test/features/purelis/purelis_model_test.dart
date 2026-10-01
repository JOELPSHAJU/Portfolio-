import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/purelis/data/models/product_category_model.dart';
import 'package:joel_portfolio/features/purelis/data/models/product_model.dart';
import 'package:joel_portfolio/features/purelis/data/models/purelis_content_model.dart';
import 'package:joel_portfolio/features/purelis/data/models/trust_badge_model.dart';
import 'package:joel_portfolio/features/purelis/data/models/value_proposition_model.dart';
import 'package:joel_portfolio/features/purelis/presentation/providers/wishlist_provider.dart';
import 'package:joel_portfolio/features/purelis/presentation/utils/purelis_icon_utils.dart';

void main() {
  group('Purelis Models & Entities Test', () {
    test('ProductModel fromJson & toEntity maps correctly', () {
      final json = {
        'id': 'prod_test',
        'name': 'Test Cleanser',
        'price': 499,
        'formattedPrice': '₹499',
        'image': 'assets/purelis_prod_facewash.jpg',
        'description': 'Soothing cleanser',
        'size': '150 ml',
      };

      final model = ProductModel.fromJson(json);
      expect(model.id, 'prod_test');
      expect(model.name, 'Test Cleanser');
      expect(model.price, 499);
      expect(model.formattedPrice, '₹499');

      final entity = model.toEntity();
      expect(entity.id, model.id);
      expect(entity.name, model.name);
      expect(entity.price, model.price);
    });

    test('ProductCategoryModel fromJson & toEntity maps correctly', () {
      final json = {
        'id': 'cleansers',
        'title': 'CLEANSERS',
        'image': 'assets/purelis_cat_cleansers.jpg',
      };

      final model = ProductCategoryModel.fromJson(json);
      expect(model.id, 'cleansers');
      expect(model.title, 'CLEANSERS');

      final entity = model.toEntity();
      expect(entity.id, 'cleansers');
      expect(entity.title, 'CLEANSERS');
    });

    test('ValuePropositionModel fromJson & toEntity maps correctly', () {
      final json = {
        'icon': 'eco_outlined',
        'title': 'Natural Ingredients',
        'subtitle': 'Safe & toxin-free',
      };

      final model = ValuePropositionModel.fromJson(json);
      expect(model.title, 'Natural Ingredients');
      final entity = model.toEntity();
      expect(entity.title, 'Natural Ingredients');
      expect(PurelisIconUtils.resolve(entity.icon), Icons.eco_outlined);
    });

    test('TrustBadgeModel & EcoBadgeModel map correctly', () {
      final trustJson = {
        'icon': 'local_shipping_outlined',
        'title': 'FREE SHIPPING',
        'subtitle': 'On orders over ₹499',
      };
      final trustModel = TrustBadgeModel.fromJson(trustJson);
      expect(trustModel.toEntity().title, 'FREE SHIPPING');

      final ecoJson = {
        'icon': 'spa_outlined',
        'text': 'Clean Beauty',
      };
      final ecoModel = EcoBadgeModel.fromJson(ecoJson);
      expect(ecoModel.toEntity().text, 'Clean Beauty');
    });

    test('PurelisContentModel maps website.json structure', () {
      final websiteJson = {
        'valuePropositions': [
          {
            'icon': 'eco_outlined',
            'title': 'Natural Ingredients',
            'subtitle': 'Safe & toxin-free',
          },
        ],
        'trustBadges': [
          {
            'icon': 'local_shipping_outlined',
            'title': 'FREE SHIPPING',
            'subtitle': 'On orders over ₹499',
          },
        ],
        'ecoBadges': [
          {
            'icon': 'spa_outlined',
            'text': 'Clean Beauty',
          },
        ],
      };

      final model = PurelisContentModel.fromJson(
        categoriesJson: [],
        productsJson: [],
        websiteJson: websiteJson,
      );
      final entity = model.toEntity();
      expect(entity.valuePropositions.length, 1);
      expect(entity.trustBadges.length, 1);
      expect(entity.ecoBadges.length, 1);
    });
  });

  group('WishlistNotifier Tests', () {
    test('toggles, adds, removes, contains, and clears wishlist items', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(wishlistProvider), isEmpty);
      expect(container.read(wishlistProvider.notifier).contains('prod_1'), false);

      container.read(wishlistProvider.notifier).add('prod_1');
      expect(container.read(wishlistProvider), contains('prod_1'));
      expect(container.read(wishlistProvider.notifier).contains('prod_1'), true);

      container.read(wishlistProvider.notifier).toggle('prod_1');
      expect(container.read(wishlistProvider), isNot(contains('prod_1')));

      container.read(wishlistProvider.notifier).toggle('prod_2');
      expect(container.read(wishlistProvider), contains('prod_2'));

      container.read(wishlistProvider.notifier).clear();
      expect(container.read(wishlistProvider), isEmpty);
    });
  });
}
