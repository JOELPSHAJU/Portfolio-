class AutovistaInsurancePlanEntity {
  final String tier;
  final String cost;
  final String excess;
  final bool isFeatured;
  final List<String> items;

  const AutovistaInsurancePlanEntity({
    required this.tier,
    required this.cost,
    required this.excess,
    required this.isFeatured,
    required this.items,
  });
}
