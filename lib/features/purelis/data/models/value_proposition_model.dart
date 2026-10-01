import '../../domain/entities/value_proposition.dart';

class ValuePropositionModel {
  final String icon;
  final String title;
  final String subtitle;

  const ValuePropositionModel({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  factory ValuePropositionModel.fromJson(Map<String, dynamic> json) {
    return ValuePropositionModel(
      icon: json['icon'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'subtitle': subtitle,
    };
  }

  ValueProposition toEntity() {
    return ValueProposition(
      icon: icon,
      title: title,
      subtitle: subtitle,
    );
  }
}
