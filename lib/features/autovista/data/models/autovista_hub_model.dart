import '../../domain/entities/autovista_hub_entity.dart';

class AutovistaHubModel {
  final String city;
  final String name;
  final String terminal;
  final String address;
  final String type;
  final String hours;
  final String fleet;
  final String phone;
  final bool is24x7;

  const AutovistaHubModel({
    required this.city,
    required this.name,
    required this.terminal,
    required this.address,
    required this.type,
    required this.hours,
    required this.fleet,
    required this.phone,
    required this.is24x7,
  });

  factory AutovistaHubModel.fromJson(Map<String, dynamic> json) {
    return AutovistaHubModel(
      city: json['city'] as String? ?? '',
      name: json['name'] as String? ?? '',
      terminal: json['terminal'] as String? ?? '',
      address: json['address'] as String? ?? '',
      type: json['type'] as String? ?? '',
      hours: json['hours'] as String? ?? '',
      fleet: json['fleet'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      is24x7: json['is24x7'] as bool? ?? false,
    );
  }

  AutovistaHubEntity toEntity() {
    return AutovistaHubEntity(
      city: city,
      name: name,
      terminal: terminal,
      address: address,
      type: type,
      hours: hours,
      fleet: fleet,
      phone: phone,
      is24x7: is24x7,
    );
  }
}
