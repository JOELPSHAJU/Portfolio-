import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/dashboard_local_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/usecases/get_dashboard_stats.dart';
import '../../domain/usecases/update_counter.dart';

part 'dashboard_controller.g.dart';

/// Provider for SharedPreferences. Must be overridden in main.dart once initialized.
@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError('SharedPreferences has not been overridden');
}

/// Provider for the local data source.
@riverpod
DashboardLocalDataSource dashboardLocalDataSource(DashboardLocalDataSourceRef ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return DashboardLocalDataSourceImpl(sharedPreferences: prefs);
}

/// Provider for the repository.
@riverpod
DashboardRepository dashboardRepository(DashboardRepositoryRef ref) {
  final localDS = ref.watch(dashboardLocalDataSourceProvider);
  return DashboardRepositoryImpl(localDataSource: localDS);
}

/// Riverpod controller managing the dashboard state using modern code generation.
@riverpod
class DashboardController extends _$DashboardController {
  late final GetDashboardStatsUseCase _getStatsUseCase;
  late final UpdateCounterUseCase _updateCounterUseCase;

  @override
  FutureOr<DashboardStats> build() async {
    final repo = ref.watch(dashboardRepositoryProvider);
    _getStatsUseCase = GetDashboardStatsUseCase(repo);
    _updateCounterUseCase = UpdateCounterUseCase(repo);

    // Fetch initial stats
    return await _getStatsUseCase();
  }

  /// Increments the counter state.
  Future<void> increment() async {
    final currentStats = state.value;
    if (currentStats == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _updateCounterUseCase(currentStats, 1);
    });
  }

  /// Decrements the counter state.
  Future<void> decrement() async {
    final currentStats = state.value;
    if (currentStats == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _updateCounterUseCase(currentStats, -1);
    });
  }
  
  /// Resets the counter state.
  Future<void> reset() async {
    final currentStats = state.value;
    if (currentStats == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _updateCounterUseCase(currentStats, -currentStats.counter);
    });
  }
}
