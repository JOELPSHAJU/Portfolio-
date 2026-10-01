import '../../domain/entities/site_telemetry.dart';

class SiteTelemetryModel extends SiteTelemetry {
  const SiteTelemetryModel({
    required super.activeMachineryCount,
    required super.safetyStandard,
    required super.activeSquareFootage,
    required super.concretePoured,
    required super.currentStatus,
    required super.elevationGrade,
  });

  factory SiteTelemetryModel.fromJson(Map<String, dynamic> json) {
    return SiteTelemetryModel(
      activeMachineryCount: json['activeMachineryCount'] as int? ?? 9,
      safetyStandard: json['safetyStandard'] as String? ?? '',
      activeSquareFootage: json['activeSquareFootage'] as String? ?? '',
      concretePoured: json['concretePoured'] as String? ?? '',
      currentStatus: json['currentStatus'] as String? ?? '',
      elevationGrade: json['elevationGrade'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activeMachineryCount': activeMachineryCount,
      'safetyStandard': safetyStandard,
      'activeSquareFootage': activeSquareFootage,
      'concretePoured': concretePoured,
      'currentStatus': currentStatus,
      'elevationGrade': elevationGrade,
    };
  }
}
