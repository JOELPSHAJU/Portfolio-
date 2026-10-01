import '../../domain/entities/trust_badge.dart';

class TrustBadgeModel {
  final String icon;
  final String title;
  final String subtitle;

  const TrustBadgeModel({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  factory TrustBadgeModel.fromJson(Map<String, dynamic> json) {
    return TrustBadgeModel(
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

  TrustBadge toEntity() {
    return TrustBadge(
      icon: icon,
      title: title,
      subtitle: subtitle,
    );
  }
}

class EcoBadgeModel {
  final String icon;
  final String text;

  const EcoBadgeModel({
    required this.icon,
    required this.text,
  });

  factory EcoBadgeModel.fromJson(Map<String, dynamic> json) {
    return EcoBadgeModel(
      icon: json['icon'] as String? ?? '',
      text: json['text'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'text': text,
    };
  }

  EcoBadge toEntity() {
    return EcoBadge(
      icon: icon,
      text: text,
    );
  }
}
