import '../entities/autovista_page_data_entity.dart';

abstract class AutovistaRepository {
  Future<AutovistaPageDataEntity> getPageData();
}
