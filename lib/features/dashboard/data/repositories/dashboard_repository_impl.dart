import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_local_datasource.dart';
import '../models/dashboard_stats_model.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardLocalDataSource localDataSource;

  const DashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<DashboardStats> getStats() async {
    try {
      final localStats = await localDataSource.getCachedStats();
      return localStats;
    } on CacheException {
      // Fallback: If no cache exists or fails, return an initial set of stats
      final initialStats = DashboardStats.initial();
      // Cache this initial stats so we have a persistent state going forward
      await saveStats(initialStats);
      return initialStats;
    }
  }

  @override
  Future<void> saveStats(DashboardStats stats) async {
    final model = DashboardStatsModel.fromEntity(stats);
    await localDataSource.cacheStats(model);
  }
}
