import '../../domain/entities/dining_venue.dart';

class DiningVenueModel extends DiningVenue {
  const DiningVenueModel({
    required super.name,
    required super.stars,
    required super.chef,
    required super.cuisine,
    required super.hours,
    required super.highlight,
  });

  factory DiningVenueModel.fromJson(Map<String, dynamic> json) {
    return DiningVenueModel(
      name: json['name'] as String,
      stars: json['stars'] as String,
      chef: json['chef'] as String,
      cuisine: json['cuisine'] as String,
      hours: json['hours'] as String,
      highlight: json['highlight'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stars': stars,
      'chef': chef,
      'cuisine': cuisine,
      'hours': hours,
      'highlight': highlight,
    };
  }

  DiningVenue toEntity() => this;
}
