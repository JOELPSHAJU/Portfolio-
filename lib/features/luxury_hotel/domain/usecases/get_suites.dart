import '../entities/suite.dart';
import '../repositories/luxury_hotel_repository.dart';

class GetSuites {
  final LuxuryHotelRepository repository;

  const GetSuites(this.repository);

  Future<List<Suite>> call() {
    return repository.getSuites();
  }
}
