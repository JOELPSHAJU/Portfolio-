import '../../domain/entities/purelis_content.dart';
import 'product_category_model.dart';
import 'product_model.dart';
import 'trust_badge_model.dart';
import 'value_proposition_model.dart';

class PurelisContentModel {
  final List<ProductCategoryModel> categories;
  final List<ProductModel> products;
  final List<ValuePropositionModel> valuePropositions;
  final List<TrustBadgeModel> trustBadges;
  final List<EcoBadgeModel> ecoBadges;

  const PurelisContentModel({
    required this.categories,
    required this.products,
    required this.valuePropositions,
    required this.trustBadges,
    required this.ecoBadges,
  });

  factory PurelisContentModel.fromJson({
    required List<dynamic> categoriesJson,
    required List<dynamic> productsJson,
    required Map<String, dynamic> websiteJson,
  }) {
    return PurelisContentModel(
      categories: categoriesJson
          .map((e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: productsJson
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      valuePropositions: (websiteJson['valuePropositions'] as List<dynamic>? ?? [])
          .map((e) => ValuePropositionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      trustBadges: (websiteJson['trustBadges'] as List<dynamic>? ?? [])
          .map((e) => TrustBadgeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ecoBadges: (websiteJson['ecoBadges'] as List<dynamic>? ?? [])
          .map((e) => EcoBadgeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  PurelisContent toEntity() {
    return PurelisContent(
      categories: categories.map((e) => e.toEntity()).toList(),
      products: products.map((e) => e.toEntity()).toList(),
      valuePropositions: valuePropositions.map((e) => e.toEntity()).toList(),
      trustBadges: trustBadges.map((e) => e.toEntity()).toList(),
      ecoBadges: ecoBadges.map((e) => e.toEntity()).toList(),
    );
  }
}
