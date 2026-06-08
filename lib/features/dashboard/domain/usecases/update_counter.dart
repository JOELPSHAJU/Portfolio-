import '../entities/dashboard_stats.dart';
import '../repositories/dashboard_repository.dart';

/// Business UseCase to handle incrementing/decrementing dashboard stats and saving them.
class UpdateCounterUseCase {
  final DashboardRepository repository;

  const UpdateCounterUseCase(this.repository);

  /// Executes the use case to update the counter value by [delta].
  Future<DashboardStats> call(DashboardStats currentStats, int delta) async {
    final newCounter = currentStats.counter + delta;
    
    // Core business logic: Streak increases if counter reaches multiples of 5
    int newStreak = currentStats.streakCount;
    if (delta > 0 && newCounter > 0 && newCounter % 5 == 0) {
      newStreak += 1;
    } else if (newCounter < 0) {
      newStreak = 0; // Reset streak if the value drops below zero
    }

    // Dynamic weekly activity shift mock-up
    final updatedActivity = List<double>.from(currentStats.weeklyActivity);
    if (updatedActivity.isNotEmpty) {
      // Simulate activity by adjusting the last day's value
      updatedActivity[updatedActivity.length - 1] = 
          (updatedActivity.last + (delta * 5.0)).clamp(0.0, 100.0);
    }

    final updatedStats = currentStats.copyWith(
      counter: newCounter,
      streakCount: newStreak,
      weeklyActivity: updatedActivity,
      lastUpdated: DateTime.now(),
    );

    // Persist changes
    await repository.saveStats(updatedStats);

    return updatedStats;
  }
}
