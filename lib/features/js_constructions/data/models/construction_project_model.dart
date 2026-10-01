import 'package:flutter/material.dart';
import '../../domain/entities/construction_project.dart';

class ConstructionProjectModel extends ConstructionProject {
  const ConstructionProjectModel({
    required super.id,
    required super.title,
    required super.category,
    required super.location,
    required super.height,
    required super.spec,
    required super.image,
    required super.status,
    required super.year,
    required super.budget,
    required super.architect,
    required super.badge,
    required super.drawingCode,
    required super.elevation,
    required super.desc,
  });

  factory ConstructionProjectModel.fromJson(Map<String, dynamic> json) {
    return ConstructionProjectModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      location: json['location'] as String? ?? '',
      height: json['height'] as String? ?? '',
      spec: json['spec'] as String? ?? '',
      image: json['image'] as String? ?? '',
      status: json['status'] as String? ?? '',
      year: json['year'] as String? ?? '',
      budget: json['budget'] as String? ?? '',
      architect: json['architect'] as String? ?? '',
      badge: json['badge'] as String? ?? '',
      drawingCode: json['drawingCode'] as String? ?? '',
      elevation: json['elevation'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'height': height,
      'spec': spec,
      'image': image,
      'status': status,
      'year': year,
      'budget': budget,
      'architect': architect,
      'badge': badge,
      'drawingCode': drawingCode,
      'elevation': elevation,
      'desc': desc,
    };
  }
}

class PrestigeProjectModel extends PrestigeProject {
  const PrestigeProjectModel({
    required super.title,
    required super.location,
    required super.desc,
    required super.image,
    required super.status,
    required super.statusColor,
  });

  factory PrestigeProjectModel.fromJson(Map<String, dynamic> json) {
    Color parsedColor = const Color(0xFF3B82F6);
    final rawColor = json['statusColor'];
    if (rawColor is String) {
      final hex = rawColor.replaceAll('0x', '').replaceAll('#', '');
      parsedColor = Color(int.tryParse(hex, radix: 16) ?? 0xFF3B82F6);
    } else if (rawColor is int) {
      parsedColor = Color(rawColor);
    }

    return PrestigeProjectModel(
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      image: json['image'] as String? ?? '',
      status: json['status'] as String? ?? '',
      statusColor: parsedColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location': location,
      'desc': desc,
      'image': image,
      'status': status,
      'statusColor': '0x${statusColor.toARGB32().toRadixString(16).toUpperCase()}',
    };
  }
}
