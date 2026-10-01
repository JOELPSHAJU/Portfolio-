import '../entities/product.dart';
import '../entities/product_category.dart';
import '../entities/purelis_content.dart';

abstract class PurelisRepository {
  Future<List<ProductCategory>> getCategories();
  Future<List<Product>> getProducts();
  Future<PurelisContent> getContent();
}
