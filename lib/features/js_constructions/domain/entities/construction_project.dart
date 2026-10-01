import 'package:flutter/material.dart';

class ConstructionProject {
  final String id;
  final String title;
  final String category;
  final String location;
  final String height;
  final String spec;
  final String image;
  final String status;
  final String year;
  final String budget;
  final String architect;
  final String badge;
  final String drawingCode;
  final String elevation;
  final String desc;

  const ConstructionProject({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.height,
    required this.spec,
    required this.image,
    required this.status,
    required this.year,
    required this.budget,
    required this.architect,
    required this.badge,
    required this.drawingCode,
    required this.elevation,
    required this.desc,
  });
}

class PrestigeProject {
  final String title;
  final String location;
  final String desc;
  final String image;
  final String status;
  final Color statusColor;

  const PrestigeProject({
    required this.title,
    required this.location,
    required this.desc,
    required this.image,
    required this.status,
    required this.statusColor,
  });
}
