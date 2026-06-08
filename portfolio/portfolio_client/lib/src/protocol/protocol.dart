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
import 'greetings/greeting.dart' as _i3;
import 'portfolio_data.dart' as _i4;
import 'project.dart' as _i5;
import 'skill.dart' as _i6;
export 'experience.dart';
export 'greetings/greeting.dart';
export 'portfolio_data.dart';
export 'project.dart';
export 'skill.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Experience) {
      return _i2.Experience.fromJson(data) as T;
    }
    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.PortfolioData) {
      return _i4.PortfolioData.fromJson(data) as T;
    }
    if (t == _i5.Project) {
      return _i5.Project.fromJson(data) as T;
    }
    if (t == _i6.Skill) {
      return _i6.Skill.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Experience?>()) {
      return (data != null ? _i2.Experience.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.PortfolioData?>()) {
      return (data != null ? _i4.PortfolioData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Project?>()) {
      return (data != null ? _i5.Project.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Skill?>()) {
      return (data != null ? _i6.Skill.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i2.Experience>) {
      return (data as List).map((e) => deserialize<_i2.Experience>(e)).toList()
          as T;
    }
    if (t == List<_i6.Skill>) {
      return (data as List).map((e) => deserialize<_i6.Skill>(e)).toList() as T;
    }
    if (t == List<_i5.Project>) {
      return (data as List).map((e) => deserialize<_i5.Project>(e)).toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Experience => 'Experience',
      _i3.Greeting => 'Greeting',
      _i4.PortfolioData => 'PortfolioData',
      _i5.Project => 'Project',
      _i6.Skill => 'Skill',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('portfolio.', '');
    }

    switch (data) {
      case _i2.Experience():
        return 'Experience';
      case _i3.Greeting():
        return 'Greeting';
      case _i4.PortfolioData():
        return 'PortfolioData';
      case _i5.Project():
        return 'Project';
      case _i6.Skill():
        return 'Skill';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Experience') {
      return deserialize<_i2.Experience>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'PortfolioData') {
      return deserialize<_i4.PortfolioData>(data['data']);
    }
    if (dataClassName == 'Project') {
      return deserialize<_i5.Project>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i6.Skill>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
