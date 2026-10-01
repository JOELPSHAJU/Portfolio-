import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/purelis_content.dart';
import '../../domain/repositories/purelis_repository.dart';
import '../datasources/purelis_local_datasource.dart';

class PurelisRepositoryImpl implements PurelisRepository {
  final PurelisLocalDataSource localDataSource;

  PurelisRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ProductCategory>> getCategories() async {
    final models = await localDataSource.getCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Product>> getProducts() async {
    final models = await localDataSource.getProducts();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<PurelisContent> getContent() async {
    final model = await localDataSource.getContent();
    return model.toEntity();
  }
}
