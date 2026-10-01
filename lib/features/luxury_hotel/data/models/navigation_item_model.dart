import '../../domain/entities/navigation_item.dart';

class NavigationItemModel extends NavigationItem {
  const NavigationItemModel({
    required super.label,
    required super.target,
  });

  factory NavigationItemModel.fromJson(Map<String, dynamic> json) {
    return NavigationItemModel(
      label: json['label'] as String,
      target: json['target'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'target': target,
    };
  }

  NavigationItem toEntity() => this;
}
