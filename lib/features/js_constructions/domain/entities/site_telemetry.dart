class SiteTelemetry {
  final int activeMachineryCount;
  final String safetyStandard;
  final String activeSquareFootage;
  final String concretePoured;
  final String currentStatus;
  final String elevationGrade;

  const SiteTelemetry({
    required this.activeMachineryCount,
    required this.safetyStandard,
    required this.activeSquareFootage,
    required this.concretePoured,
    required this.currentStatus,
    required this.elevationGrade,
  });
}
