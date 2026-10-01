import '../../domain/entities/autovista_service_entity.dart';

class AutovistaServiceModel {
  final String title;
  final String sub;
  final String icon;
  final List<String> features;

  const AutovistaServiceModel({
    required this.title,
    required this.sub,
    required this.icon,
    this.features = const [],
  });

  factory AutovistaServiceModel.fromJson(Map<String, dynamic> json) {
    return AutovistaServiceModel(
      title: json['title'] as String? ?? '',
      sub: json['sub'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  AutovistaServiceEntity toEntity() {
    return AutovistaServiceEntity(
      title: title,
      sub: sub,
      icon: icon,
      features: features,
    );
  }
}
