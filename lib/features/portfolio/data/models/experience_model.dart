import '../../domain/entities/experience.dart';

class ExperienceModel extends Experience {
  const ExperienceModel({
    required super.role,
    required super.company,
    required super.duration,
    required super.location,
    required super.points,
    required super.technologies,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      role: json['role'] as String,
      company: json['company'] as String,
      duration: json['duration'] as String,
      location: json['location'] as String,
      points: List<String>.from(json['points'] as List),
      technologies: List<String>.from(json['technologies'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'company': company,
      'duration': duration,
      'location': location,
      'points': points,
      'technologies': technologies,
    };
  }
}
