/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'experience.dart' as _i2;
import 'skill.dart' as _i3;
import 'project.dart' as _i4;
import 'package:portfolio_client/src/protocol/protocol.dart' as _i5;

abstract class PortfolioData implements _i1.SerializableModel {
  PortfolioData._({
    required this.experiences,
    required this.skills,
    required this.projects,
  });

  factory PortfolioData({
    required List<_i2.Experience> experiences,
    required List<_i3.Skill> skills,
    required List<_i4.Project> projects,
  }) = _PortfolioDataImpl;

  factory PortfolioData.fromJson(Map<String, dynamic> jsonSerialization) {
    return PortfolioData(
      experiences: _i5.Protocol().deserialize<List<_i2.Experience>>(
        jsonSerialization['experiences'],
      ),
      skills: _i5.Protocol().deserialize<List<_i3.Skill>>(
        jsonSerialization['skills'],
      ),
      projects: _i5.Protocol().deserialize<List<_i4.Project>>(
        jsonSerialization['projects'],
      ),
    );
  }

  List<_i2.Experience> experiences;

  List<_i3.Skill> skills;

  List<_i4.Project> projects;

  /// Returns a shallow copy of this [PortfolioData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PortfolioData copyWith({
    List<_i2.Experience>? experiences,
    List<_i3.Skill>? skills,
    List<_i4.Project>? projects,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PortfolioData',
      'experiences': experiences.toJson(valueToJson: (v) => v.toJson()),
      'skills': skills.toJson(valueToJson: (v) => v.toJson()),
      'projects': projects.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PortfolioDataImpl extends PortfolioData {
  _PortfolioDataImpl({
    required List<_i2.Experience> experiences,
    required List<_i3.Skill> skills,
    required List<_i4.Project> projects,
  }) : super._(
         experiences: experiences,
         skills: skills,
         projects: projects,
       );

  /// Returns a shallow copy of this [PortfolioData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PortfolioData copyWith({
    List<_i2.Experience>? experiences,
    List<_i3.Skill>? skills,
    List<_i4.Project>? projects,
  }) {
    return PortfolioData(
      experiences:
          experiences ?? this.experiences.map((e0) => e0.copyWith()).toList(),
      skills: skills ?? this.skills.map((e0) => e0.copyWith()).toList(),
      projects: projects ?? this.projects.map((e0) => e0.copyWith()).toList(),
    );
  }
}
