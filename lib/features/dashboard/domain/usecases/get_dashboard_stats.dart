import '../entities/dashboard_stats.dart';
import '../repositories/dashboard_repository.dart';

/// Business UseCase to retrieve current dashboard stats.
class GetDashboardStatsUseCase {
  final DashboardRepository repository;

  const GetDashboardStatsUseCase(this.repository);

  /// Executes the use case.
  Future<DashboardStats> call() async {
    return await repository.getStats();
  }
}
