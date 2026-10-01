import 'product.dart';
import 'product_category.dart';
import 'trust_badge.dart';
import 'value_proposition.dart';

class PurelisContent {
  final List<ProductCategory> categories;
  final List<Product> products;
  final List<ValueProposition> valuePropositions;
  final List<TrustBadge> trustBadges;
  final List<EcoBadge> ecoBadges;

  const PurelisContent({
    required this.categories,
    required this.products,
    required this.valuePropositions,
    required this.trustBadges,
    required this.ecoBadges,
  });
}
