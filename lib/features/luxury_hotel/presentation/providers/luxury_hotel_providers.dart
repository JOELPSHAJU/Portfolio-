import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/luxury_hotel_json_data_source.dart';
import '../../data/datasources/luxury_hotel_local_data_source.dart';
import '../../data/repositories/luxury_hotel_repository_impl.dart';
import '../../domain/entities/hotel_page_data.dart';
import '../../domain/entities/suite.dart';
import '../../domain/repositories/luxury_hotel_repository.dart';
import '../../domain/usecases/get_hotel_page_data.dart';
import '../../domain/usecases/get_suites.dart';

final luxuryHotelDataSourceProvider =
    Provider<LuxuryHotelLocalDataSource>((ref) {
  return const LuxuryHotelJsonDataSource();
});

final luxuryHotelRepositoryProvider = Provider<LuxuryHotelRepository>((ref) {
  final dataSource = ref.watch(luxuryHotelDataSourceProvider);
  return LuxuryHotelRepositoryImpl(dataSource);
});

final getHotelPageDataUseCaseProvider = Provider<GetHotelPageData>((ref) {
  final repository = ref.watch(luxuryHotelRepositoryProvider);
  return GetHotelPageData(repository);
});

final getSuitesUseCaseProvider = Provider<GetSuites>((ref) {
  final repository = ref.watch(luxuryHotelRepositoryProvider);
  return GetSuites(repository);
});

final luxuryHotelDataProvider = FutureProvider<HotelPageData>((ref) async {
  final getHotelPageData = ref.watch(getHotelPageDataUseCaseProvider);
  return getHotelPageData();
});

final selectedSuiteCategoryProvider = StateProvider<String>((ref) => 'all');

final filteredSuitesProvider = Provider<List<Suite>>((ref) {
  final hotelDataAsync = ref.watch(luxuryHotelDataProvider);
  final selectedCategory = ref.watch(selectedSuiteCategoryProvider);

  return hotelDataAsync.maybeWhen(
    data: (data) {
      if (selectedCategory == 'all') return data.suites;
      return data.suites.where((s) => s.category == selectedCategory).toList();
    },
    orElse: () => const [],
  );
});
