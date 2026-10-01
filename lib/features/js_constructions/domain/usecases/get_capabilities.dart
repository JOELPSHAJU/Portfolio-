import '../entities/capability.dart';
import '../repositories/js_constructions_repository.dart';

class GetCapabilities {
  final JsConstructionsRepository repository;

  GetCapabilities(this.repository);

  Future<List<Capability>> call() {
    return repository.getCapabilities();
  }
}
