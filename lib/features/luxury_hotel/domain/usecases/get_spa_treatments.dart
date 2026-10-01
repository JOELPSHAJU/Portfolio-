import '../entities/spa_treatment.dart';
import '../repositories/luxury_hotel_repository.dart';

class GetSpaTreatments {
  final LuxuryHotelRepository repository;

  const GetSpaTreatments(this.repository);

  Future<List<SpaTreatment>> call() {
    return repository.getSpaTreatments();
  }
}
