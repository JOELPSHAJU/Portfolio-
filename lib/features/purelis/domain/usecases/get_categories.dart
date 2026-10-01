import '../entities/product_category.dart';
import '../repositories/purelis_repository.dart';

class GetCategories {
  final PurelisRepository repository;

  GetCategories(this.repository);

  Future<List<ProductCategory>> call() {
    return repository.getCategories();
  }
}
