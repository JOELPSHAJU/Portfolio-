import '../entities/concierge_privilege.dart';
import '../repositories/luxury_hotel_repository.dart';

class GetConciergePrivileges {
  final LuxuryHotelRepository repository;

  const GetConciergePrivileges(this.repository);

  Future<List<ConciergePrivilege>> call() {
    return repository.getConciergePrivileges();
  }
}
