import '../entities/dashboard_stats.dart';

/// Contract definition for Dashboard operations.
/// Follows the dependency inversion principle in Clean Architecture.
abstract class DashboardRepository {
  /// Fetches the current stats from a local or remote data source.
  Future<DashboardStats> getStats();

  /// Persists stats securely.
  Future<void> saveStats(DashboardStats stats);
}
