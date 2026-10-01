import '../../domain/entities/autovista_deal_entity.dart';

class AutovistaDealModel {
  final String id;
  final String tag;
  final int tagColorValue;
  final String name;
  final String discount;
  final String originalPrice;
  final String dealPrice;
  final String period;
  final String savings;
  final String image;
  final String badge;

  const AutovistaDealModel({
    required this.id,
    required this.tag,
    required this.tagColorValue,
    required this.name,
    required this.discount,
    required this.originalPrice,
    required this.dealPrice,
    required this.period,
    required this.savings,
    required this.image,
    required this.badge,
  });

  factory AutovistaDealModel.fromJson(Map<String, dynamic> json) {
    int parseColor(dynamic val) {
      if (val is int) return val;
      if (val is String) {
        return int.tryParse(val) ?? 0xFFE50914;
      }
      return 0xFFE50914;
    }

    return AutovistaDealModel(
      id: json['id'] as String? ?? '',
      tag: json['tag'] as String? ?? '',
      tagColorValue: parseColor(json['tagColor']),
      name: json['name'] as String? ?? '',
      discount: json['discount'] as String? ?? '',
      originalPrice: json['originalPrice'] as String? ?? '',
      dealPrice: json['dealPrice'] as String? ?? '',
      period: json['period'] as String? ?? '/ day',
      savings: json['savings'] as String? ?? '',
      image: json['image'] as String? ?? '',
      badge: json['badge'] as String? ?? '',
    );
  }

  AutovistaDealEntity toEntity() {
    return AutovistaDealEntity(
      id: id,
      tag: tag,
      tagColorValue: tagColorValue,
      name: name,
      discount: discount,
      originalPrice: originalPrice,
      dealPrice: dealPrice,
      period: period,
      savings: savings,
      image: image,
      badge: badge,
    );
  }
}
