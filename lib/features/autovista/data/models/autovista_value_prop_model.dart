import '../../domain/entities/autovista_value_prop_entity.dart';

class AutovistaValuePropModel {
  final String title;
  final String sub;
  final String icon;

  const AutovistaValuePropModel({
    required this.title,
    required this.sub,
    required this.icon,
  });

  factory AutovistaValuePropModel.fromJson(Map<String, dynamic> json) {
    return AutovistaValuePropModel(
      title: json['title'] as String? ?? '',
      sub: json['sub'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }

  AutovistaValuePropEntity toEntity() {
    return AutovistaValuePropEntity(
      title: title,
      sub: sub,
      icon: icon,
    );
  }
}
