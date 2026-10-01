import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/autovista_local_data_source.dart';
import '../../data/repositories/autovista_repository_impl.dart';
import '../../domain/entities/autovista_page_data_entity.dart';
import '../../domain/repositories/autovista_repository.dart';
import '../../domain/usecases/get_autovista_page_data.dart';

final autovistaLocalDataSourceProvider =
    Provider<AutovistaLocalDataSource>((ref) {
  return AutovistaLocalDataSourceImpl();
});

final autovistaRepositoryProvider = Provider<AutovistaRepository>((ref) {
  final dataSource = ref.watch(autovistaLocalDataSourceProvider);
  return AutovistaRepositoryImpl(localDataSource: dataSource);
});

final getAutovistaPageDataProvider = Provider<GetAutovistaPageData>((ref) {
  final repository = ref.watch(autovistaRepositoryProvider);
  return GetAutovistaPageData(repository);
});

final autovistaPageDataProvider =
    FutureProvider<AutovistaPageDataEntity>((ref) async {
  final useCase = ref.watch(getAutovistaPageDataProvider);
  return useCase();
});

// UI State Providers
final autovistaSelectedSidebarIdxProvider = StateProvider<int>((ref) => 0);
final autovistaSelectedTopNavIdxProvider = StateProvider<int>((ref) => 0);

final autovistaSelectedTypeProvider =
    StateProvider<String>((ref) => 'Any Type');
final autovistaSelectedLocationProvider =
    StateProvider<String>((ref) => 'Any Location');
final autovistaSelectedDurationProvider =
    StateProvider<String>((ref) => 'Any Duration');
final autovistaSelectedPriceProvider =
    StateProvider<String>((ref) => 'Any Budget');

final autovistaSelectedFleetFilterProvider =
    StateProvider<String>((ref) => 'All Vehicles');
final autovistaSelectedLocationFilterProvider =
    StateProvider<String>((ref) => 'All Hubs');

class WishlistNotifier extends StateNotifier<Set<String>> {
  WishlistNotifier() : super({});

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  bool contains(String id) => state.contains(id);
}

final autovistaWishlistProvider =
    StateNotifierProvider<WishlistNotifier, Set<String>>((ref) {
  return WishlistNotifier();
});
