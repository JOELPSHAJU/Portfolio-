import '../entities/dining_venue.dart';
import '../repositories/luxury_hotel_repository.dart';

class GetDiningVenues {
  final LuxuryHotelRepository repository;

  const GetDiningVenues(this.repository);

  Future<List<DiningVenue>> call() {
    return repository.getDiningVenues();
  }
}
