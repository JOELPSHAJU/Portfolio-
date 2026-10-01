import '../../domain/entities/concierge_privilege.dart';

class ConciergePrivilegeModel extends ConciergePrivilege {
  const ConciergePrivilegeModel({
    required super.icon,
    required super.title,
    required super.desc,
  });

  factory ConciergePrivilegeModel.fromJson(Map<String, dynamic> json) {
    return ConciergePrivilegeModel(
      icon: json['icon'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'desc': desc,
    };
  }

  ConciergePrivilege toEntity() => this;
}
