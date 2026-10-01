import '../entities/hotel_page_data.dart';
import '../repositories/luxury_hotel_repository.dart';

class GetHotelPageData {
  final LuxuryHotelRepository repository;

  const GetHotelPageData(this.repository);

  Future<HotelPageData> call() {
    return repository.getHotelPageData();
  }
}
