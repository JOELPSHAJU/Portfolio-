import '../../domain/entities/fleet_machine.dart';

class FleetMachineModel extends FleetMachine {
  const FleetMachineModel({
    required super.name,
    required super.label,
    required super.model,
    required super.role,
    required super.image,
    required super.thumb,
    required super.weight,
    required super.power,
    required super.depth,
    required super.speed,
    required super.tag,
    required super.zone,
    required super.serial,
    required super.desc,
  });

  factory FleetMachineModel.fromJson(Map<String, dynamic> json) {
    return FleetMachineModel(
      name: json['name'] as String? ?? '',
      label: json['label'] as String? ?? '',
      model: json['model'] as String? ?? '',
      role: json['role'] as String? ?? '',
      image: json['image'] as String? ?? '',
      thumb: json['thumb'] as String? ?? '',
      weight: json['weight'] as String? ?? '',
      power: json['power'] as String? ?? '',
      depth: json['depth'] as String? ?? '',
      speed: json['speed'] as String? ?? '',
      tag: json['tag'] as String? ?? '',
      zone: json['zone'] as String? ?? '',
      serial: json['serial'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'label': label,
      'model': model,
      'role': role,
      'image': image,
      'thumb': thumb,
      'weight': weight,
      'power': power,
      'depth': depth,
      'speed': speed,
      'tag': tag,
      'zone': zone,
      'serial': serial,
      'desc': desc,
    };
  }
}
