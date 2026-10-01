import '../../domain/entities/team_member.dart';

class TeamMemberModel extends TeamMember {
  const TeamMemberModel({
    required super.name,
    required super.role,
    required super.cred,
    required super.badgeId,
    required super.icon,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      cred: json['cred'] as String? ?? '',
      badgeId: json['badgeId'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'cred': cred,
      'badgeId': badgeId,
      'icon': icon,
    };
  }
}
