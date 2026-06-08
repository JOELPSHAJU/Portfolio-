/// Pure Dart business entity representing current stats on our premium dashboard.
class DashboardStats {
  final int counter;
  final int streakCount;
  final List<double> weeklyActivity;
  final DateTime lastUpdated;

  const DashboardStats({
    required this.counter,
    required this.streakCount,
    required this.weeklyActivity,
    required this.lastUpdated,
  });

  /// Factory constructor to create a default or starting set of dashboard stats.
  factory DashboardStats.initial() {
    return DashboardStats(
      counter: 0,
      streakCount: 0,
      weeklyActivity: const [10.0, 25.0, 15.0, 45.0, 30.0, 55.0, 20.0],
      lastUpdated: DateTime.now(),
    );
  }

  /// Convenience copyWith helper for updating specific fields in the immutable entity.
  DashboardStats copyWith({
    int? counter,
    int? streakCount,
    List<double>? weeklyActivity,
    DateTime? lastUpdated,
  }) {
    return DashboardStats(
      counter: counter ?? this.counter,
      streakCount: streakCount ?? this.streakCount,
      weeklyActivity: weeklyActivity ?? this.weeklyActivity,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
