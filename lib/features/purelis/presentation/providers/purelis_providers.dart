import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/purelis_local_datasource.dart';
import '../../data/repositories/purelis_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/purelis_content.dart';
import '../../domain/repositories/purelis_repository.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/get_purelis_content.dart';

final purelisLocalDataSourceProvider = Provider<PurelisLocalDataSource>((ref) {
  return PurelisLocalDataSourceImpl();
});

final purelisRepositoryProvider = Provider<PurelisRepository>((ref) {
  final dataSource = ref.watch(purelisLocalDataSourceProvider);
  return PurelisRepositoryImpl(localDataSource: dataSource);
});

final getProductsUseCaseProvider = Provider<GetProducts>((ref) {
  final repository = ref.watch(purelisRepositoryProvider);
  return GetProducts(repository);
});

final getCategoriesUseCaseProvider = Provider<GetCategories>((ref) {
  final repository = ref.watch(purelisRepositoryProvider);
  return GetCategories(repository);
});

final getPurelisContentUseCaseProvider = Provider<GetPurelisContent>((ref) {
  final repository = ref.watch(purelisRepositoryProvider);
  return GetPurelisContent(repository);
});

final purelisCategoriesProvider =
    FutureProvider<List<ProductCategory>>((ref) async {
  final useCase = ref.watch(getCategoriesUseCaseProvider);
  return useCase();
});

final categoriesProvider = purelisCategoriesProvider;

final purelisProductsProvider =
    FutureProvider<List<Product>>((ref) async {
  final useCase = ref.watch(getProductsUseCaseProvider);
  return useCase();
});

final productsProvider = purelisProductsProvider;

final purelisContentProvider =
    FutureProvider<PurelisContent>((ref) async {
  final useCase = ref.watch(getPurelisContentUseCaseProvider);
  return useCase();
});
