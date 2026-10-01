import '../entities/product.dart';
import '../repositories/purelis_repository.dart';

class GetProducts {
  final PurelisRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() {
    return repository.getProducts();
  }
}
