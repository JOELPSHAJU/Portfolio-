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
import 'package:portfolio_client/src/protocol/protocol.dart' as _i2;

abstract class Project implements _i1.SerializableModel {
  Project._({
    required this.id,
    required this.title,
    required this.type,
    required this.clientOrOrg,
    required this.description,
    required this.points,
    required this.technologies,
  });

  factory Project({
    required String id,
    required String title,
    required String type,
    required String clientOrOrg,
    required String description,
    required List<String> points,
    required List<String> technologies,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as String,
      title: jsonSerialization['title'] as String,
      type: jsonSerialization['type'] as String,
      clientOrOrg: jsonSerialization['clientOrOrg'] as String,
      description: jsonSerialization['description'] as String,
      points: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['points'],
      ),
      technologies: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['technologies'],
      ),
    );
  }

  String id;

  String title;

  String type;

  String clientOrOrg;

  String description;

  List<String> points;

  List<String> technologies;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Project copyWith({
    String? id,
    String? title,
    String? type,
    String? clientOrOrg,
    String? description,
    List<String>? points,
    List<String>? technologies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      'id': id,
      'title': title,
      'type': type,
      'clientOrOrg': clientOrOrg,
      'description': description,
      'points': points.toJson(),
      'technologies': technologies.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ProjectImpl extends Project {
  _ProjectImpl({
    required String id,
    required String title,
    required String type,
    required String clientOrOrg,
    required String description,
    required List<String> points,
    required List<String> technologies,
  }) : super._(
         id: id,
         title: title,
         type: type,
         clientOrOrg: clientOrOrg,
         description: description,
         points: points,
         technologies: technologies,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Project copyWith({
    String? id,
    String? title,
    String? type,
    String? clientOrOrg,
    String? description,
    List<String>? points,
    List<String>? technologies,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      clientOrOrg: clientOrOrg ?? this.clientOrOrg,
      description: description ?? this.description,
      points: points ?? this.points.map((e0) => e0).toList(),
      technologies: technologies ?? this.technologies.map((e0) => e0).toList(),
    );
  }
}
