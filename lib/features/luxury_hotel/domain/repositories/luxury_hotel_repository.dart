import '../entities/hotel_page_data.dart';
import '../entities/suite.dart';
import '../entities/dining_venue.dart';
import '../entities/spa_treatment.dart';
import '../entities/concierge_privilege.dart';

abstract class LuxuryHotelRepository {
  Future<HotelPageData> getHotelPageData();
  Future<List<Suite>> getSuites();
  Future<List<DiningVenue>> getDiningVenues();
  Future<List<SpaTreatment>> getSpaTreatments();
  Future<List<ConciergePrivilege>> getConciergePrivileges();
}
