import '../models/hotel_page_data_model.dart';
import '../models/suite_model.dart';
import '../models/dining_venue_model.dart';
import '../models/spa_treatment_model.dart';
import '../models/concierge_privilege_model.dart';

abstract class LuxuryHotelLocalDataSource {
  Future<HotelPageDataModel> getHotelPageData();
  Future<List<SuiteModel>> getSuites();
  Future<List<DiningVenueModel>> getDiningVenues();
  Future<List<SpaTreatmentModel>> getSpaTreatments();
  Future<List<ConciergePrivilegeModel>> getConciergePrivileges();
}
