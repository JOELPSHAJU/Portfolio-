import '../../domain/entities/capability.dart';

class CapabilityModel extends Capability {
  const CapabilityModel({
    // ignore: avoid_types_as_parameter_names
    required super.num,
    required super.code,
    required super.title,
    required super.desc,
    required super.icon,
    required super.spec,
    required super.corner,
    required super.hasOrangeAccent,
  });

  factory CapabilityModel.fromJson(Map<String, dynamic> json) {
    return CapabilityModel(
      num: json['num'] as String? ?? '',
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      spec: json['spec'] as String? ?? '',
      corner: json['corner'] as String? ?? 'topLeft',
      hasOrangeAccent: json['hasOrangeAccent'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num': num,
      'code': code,
      'title': title,
      'desc': desc,
      'icon': icon,
      'spec': spec,
      'corner': corner,
      'hasOrangeAccent': hasOrangeAccent,
    };
  }
}
