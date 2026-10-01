import '../entities/construction_project.dart';
import '../repositories/js_constructions_repository.dart';

class GetProjects {
  final JsConstructionsRepository repository;

  GetProjects(this.repository);

  Future<List<ConstructionProject>> call() {
    return repository.getProjects();
  }
}

class GetPrestigeProjects {
  final JsConstructionsRepository repository;

  GetPrestigeProjects(this.repository);

  Future<List<PrestigeProject>> call() {
    return repository.getPrestigeProjects();
  }
}
