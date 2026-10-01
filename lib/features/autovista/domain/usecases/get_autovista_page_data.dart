import '../entities/autovista_page_data_entity.dart';
import '../repositories/autovista_repository.dart';

class GetAutovistaPageData {
  final AutovistaRepository repository;

  const GetAutovistaPageData(this.repository);

  Future<AutovistaPageDataEntity> call() {
    return repository.getPageData();
  }
}
