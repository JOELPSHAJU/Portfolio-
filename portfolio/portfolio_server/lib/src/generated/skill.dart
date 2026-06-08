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

abstract class Skill
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Skill._({
    required this.name,
    required this.level,
    required this.category,
  });

  factory Skill({
    required String name,
    required double level,
    required String category,
  }) = _SkillImpl;

  factory Skill.fromJson(Map<String, dynamic> jsonSerialization) {
    return Skill(
      name: jsonSerialization['name'] as String,
      level: (jsonSerialization['level'] as num).toDouble(),
      category: jsonSerialization['category'] as String,
    );
  }

  String name;

  double level;

  String category;

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Skill copyWith({
    String? name,
    double? level,
    String? category,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Skill',
      'name': name,
      'level': level,
      'category': category,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Skill',
      'name': name,
      'level': level,
      'category': category,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SkillImpl extends Skill {
  _SkillImpl({
    required String name,
    required double level,
    required String category,
  }) : super._(
         name: name,
         level: level,
         category: category,
       );

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Skill copyWith({
    String? name,
    double? level,
    String? category,
  }) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
      category: category ?? this.category,
    );
  }
}
