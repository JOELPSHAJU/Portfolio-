import '../../domain/entities/autovista_insurance_plan_entity.dart';

class AutovistaInsurancePlanModel {
  final String tier;
  final String cost;
  final String excess;
  final bool isFeatured;
  final List<String> items;

  const AutovistaInsurancePlanModel({
    required this.tier,
    required this.cost,
    required this.excess,
    required this.isFeatured,
    required this.items,
  });

  factory AutovistaInsurancePlanModel.fromJson(Map<String, dynamic> json) {
    return AutovistaInsurancePlanModel(
      tier: json['tier'] as String? ?? '',
      cost: json['cost'] as String? ?? '',
      excess: json['excess'] as String? ?? '',
      isFeatured: json['isFeatured'] as bool? ?? false,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  AutovistaInsurancePlanEntity toEntity() {
    return AutovistaInsurancePlanEntity(
      tier: tier,
      cost: cost,
      excess: excess,
      isFeatured: isFeatured,
      items: items,
    );
  }
}
