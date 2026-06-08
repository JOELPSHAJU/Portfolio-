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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:portfolio_server/src/generated/protocol.dart' as _i2;

abstract class Experience
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Experience._({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.points,
    required this.technologies,
  });

  factory Experience({
    required String role,
    required String company,
    required String duration,
    required String location,
    required List<String> points,
    required List<String> technologies,
  }) = _ExperienceImpl;

  factory Experience.fromJson(Map<String, dynamic> jsonSerialization) {
    return Experience(
      role: jsonSerialization['role'] as String,
      company: jsonSerialization['company'] as String,
      duration: jsonSerialization['duration'] as String,
      location: jsonSerialization['location'] as String,
      points: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['points'],
      ),
      technologies: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['technologies'],
      ),
    );
  }

  String role;

  String company;

  String duration;

  String location;

  List<String> points;

  List<String> technologies;

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Experience copyWith({
    String? role,
    String? company,
    String? duration,
    String? location,
    List<String>? points,
    List<String>? technologies,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Experience',
      'role': role,
      'company': company,
      'duration': duration,
      'location': location,
      'points': points.toJson(),
      'technologies': technologies.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Experience',
      'role': role,
      'company': company,
      'duration': duration,
      'location': location,
      'points': points.toJson(),
      'technologies': technologies.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ExperienceImpl extends Experience {
  _ExperienceImpl({
    required String role,
    required String company,
    required String duration,
    required String location,
    required List<String> points,
    required List<String> technologies,
  }) : super._(
         role: role,
         company: company,
         duration: duration,
         location: location,
         points: points,
         technologies: technologies,
       );

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Experience copyWith({
    String? role,
    String? company,
    String? duration,
    String? location,
    List<String>? points,
    List<String>? technologies,
  }) {
    return Experience(
      role: role ?? this.role,
      company: company ?? this.company,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      points: points ?? this.points.map((e0) => e0).toList(),
      technologies: technologies ?? this.technologies.map((e0) => e0).toList(),
    );
  }
}
