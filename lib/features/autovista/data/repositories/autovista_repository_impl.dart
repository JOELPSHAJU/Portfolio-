import '../../domain/entities/autovista_page_data_entity.dart';
import '../../domain/repositories/autovista_repository.dart';
import '../datasources/autovista_local_data_source.dart';

class AutovistaRepositoryImpl implements AutovistaRepository {
  final AutovistaLocalDataSource localDataSource;

  const AutovistaRepositoryImpl({required this.localDataSource});

  @override
  Future<AutovistaPageDataEntity> getPageData() async {
    final model = await localDataSource.getPageData();
    return model.toEntity();
  }
}
