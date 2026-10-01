import '../../domain/entities/suite.dart';

class SuiteModel extends Suite {
  const SuiteModel({
    required super.id,
    required super.category,
    required super.title,
    required super.tagline,
    required super.price,
    required super.period,
    required super.badge,
    required super.image,
    required super.sqm,
    required super.guests,
    required super.view,
    required super.features,
    required super.description,
  });

  factory SuiteModel.fromJson(Map<String, dynamic> json) {
    return SuiteModel(
      id: json['id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String,
      price: json['price'] as String,
      period: json['period'] as String,
      badge: json['badge'] as String,
      image: json['image'] as String,
      sqm: json['sqm'] as String,
      guests: json['guests'] as String,
      view: json['view'] as String,
      features: (json['features'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'tagline': tagline,
      'price': price,
      'period': period,
      'badge': badge,
      'image': image,
      'sqm': sqm,
      'guests': guests,
      'view': view,
      'features': features,
      'description': description,
    };
  }

  Suite toEntity() => this;
}
