import '../../domain/entities/skill.dart';

class SkillModel extends Skill {
  const SkillModel({
    required super.name,
    required super.category,
    required super.level,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] as String,
      category: json['category'] as String,
      level: (json['level'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'level': level,
    };
  }
}
