import '../../domain/entities/dashboard_stats.dart';

/// Data Model that extends the Domain Entity and handles JSON serialization.
class DashboardStatsModel extends DashboardStats {
  const DashboardStatsModel({
    required super.counter,
    required super.streakCount,
    required super.weeklyActivity,
    required super.lastUpdated,
  });

  /// Map an Entity into a concrete Data Model.
  factory DashboardStatsModel.fromEntity(DashboardStats entity) {
    return DashboardStatsModel(
      counter: entity.counter,
      streakCount: entity.streakCount,
      weeklyActivity: entity.weeklyActivity,
      lastUpdated: entity.lastUpdated,
    );
  }

  /// Deserializes a JSON map into a Model instance.
  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      counter: json['counter'] as int? ?? 0,
      streakCount: json['streakCount'] as int? ?? 0,
      weeklyActivity: (json['weeklyActivity'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [10.0, 25.0, 15.0, 45.0, 30.0, 55.0, 20.0],
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : DateTime.now(),
    );
  }

  /// Serializes the Model instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'counter': counter,
      'streakCount': streakCount,
      'weeklyActivity': weeklyActivity,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
}
