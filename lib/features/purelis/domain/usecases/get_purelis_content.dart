import '../entities/purelis_content.dart';
import '../repositories/purelis_repository.dart';

class GetPurelisContent {
  final PurelisRepository repository;

  GetPurelisContent(this.repository);

  Future<PurelisContent> call() {
    return repository.getContent();
  }
}
