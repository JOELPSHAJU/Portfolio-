import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/dashboard_stats_model.dart';

/// Contract for the Dashboard Local Datasource.
abstract class DashboardLocalDataSource {
  /// Retrieves cached stats from local storage.
  /// Throws a [CacheException] if no data is found.
  Future<DashboardStatsModel> getCachedStats();

  /// Persists stats locally.
  Future<void> cacheStats(DashboardStatsModel statsToCache);
}

const String cachedStatsKey = 'CACHED_DASHBOARD_STATS';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final SharedPreferences sharedPreferences;

  const DashboardLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<DashboardStatsModel> getCachedStats() async {
    final jsonString = sharedPreferences.getString(cachedStatsKey);
    if (jsonString != null) {
      try {
        final decoded = json.decode(jsonString) as Map<String, dynamic>;
        return DashboardStatsModel.fromJson(decoded);
      } catch (e) {
        throw CacheException(message: 'Failed to decode cached stats: $e');
      }
    } else {
      // If no data exists, we throw CacheException indicating that cache is empty,
      // so the repository can fallback to initial stats gracefully.
      throw const CacheException(message: 'No cached stats found');
    }
  }

  @override
  Future<void> cacheStats(DashboardStatsModel statsToCache) async {
    try {
      final jsonString = json.encode(statsToCache.toJson());
      await sharedPreferences.setString(cachedStatsKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to write stats to cache: $e');
    }
  }
}
