import '../entities/service.dart';
import '../repositories/js_constructions_repository.dart';

class GetServices {
  final JsConstructionsRepository repository;

  GetServices(this.repository);

  Future<List<Service>> call() {
    return repository.getServices();
  }
}
