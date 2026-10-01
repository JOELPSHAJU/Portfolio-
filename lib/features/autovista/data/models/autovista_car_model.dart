import '../../domain/entities/autovista_car_entity.dart';

class AutovistaCarModel {
  final String id;
  final String tag;
  final int tagColorValue;
  final String name;
  final String specs;
  final String price;
  final String period;
  final String image;
  final String? category;
  final String? rating;
  final String? trips;
  final String? speed;

  const AutovistaCarModel({
    required this.id,
    required this.tag,
    required this.tagColorValue,
    required this.name,
    required this.specs,
    required this.price,
    required this.period,
    required this.image,
    this.category,
    this.rating,
    this.trips,
    this.speed,
  });

  factory AutovistaCarModel.fromJson(Map<String, dynamic> json) {
    int parseColor(dynamic val) {
      if (val is int) return val;
      if (val is String) {
        return int.tryParse(val) ?? 0xFFE50914;
      }
      return 0xFFE50914;
    }

    return AutovistaCarModel(
      id: json['id'] as String? ?? '',
      tag: json['tag'] as String? ?? '',
      tagColorValue: parseColor(json['tagColor']),
      name: json['name'] as String? ?? '',
      specs: json['specs'] as String? ?? '',
      price: json['price'] as String? ?? '',
      period: json['period'] as String? ?? '/ day',
      image: json['image'] as String? ?? '',
      category: json['category'] as String?,
      rating: json['rating'] as String?,
      trips: json['trips'] as String?,
      speed: json['speed'] as String?,
    );
  }

  AutovistaCarEntity toEntity() {
    return AutovistaCarEntity(
      id: id,
      tag: tag,
      tagColorValue: tagColorValue,
      name: name,
      specs: specs,
      price: price,
      period: period,
      image: image,
      category: category,
      rating: rating,
      trips: trips,
      speed: speed,
    );
  }
}
