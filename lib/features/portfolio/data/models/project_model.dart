import '../../domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.points,
    required super.technologies,
    required super.type,
    required super.clientOrOrg,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      points: List<String>.from(json['points'] as List),
      technologies: List<String>.from(json['technologies'] as List),
      type: json['type'] as String,
      clientOrOrg: json['clientOrOrg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'points': points,
      'technologies': technologies,
      'type': type,
      'clientOrOrg': clientOrOrg,
    };
  }
}
