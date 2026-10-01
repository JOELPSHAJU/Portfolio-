import '../../domain/entities/concierge_privilege.dart';
import '../../domain/entities/dining_venue.dart';
import '../../domain/entities/hotel_page_data.dart';
import '../../domain/entities/spa_treatment.dart';
import '../../domain/entities/suite.dart';
import '../../domain/repositories/luxury_hotel_repository.dart';
import '../datasources/luxury_hotel_local_data_source.dart';

class LuxuryHotelRepositoryImpl implements LuxuryHotelRepository {
  final LuxuryHotelLocalDataSource dataSource;

  const LuxuryHotelRepositoryImpl(this.dataSource);

  @override
  Future<HotelPageData> getHotelPageData() async {
    final model = await dataSource.getHotelPageData();
    return model.toEntity();
  }

  @override
  Future<List<Suite>> getSuites() async {
    final models = await dataSource.getSuites();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<DiningVenue>> getDiningVenues() async {
    final models = await dataSource.getDiningVenues();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<SpaTreatment>> getSpaTreatments() async {
    final models = await dataSource.getSpaTreatments();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<ConciergePrivilege>> getConciergePrivileges() async {
    final models = await dataSource.getConciergePrivileges();
    return models.map((m) => m.toEntity()).toList();
  }
}
