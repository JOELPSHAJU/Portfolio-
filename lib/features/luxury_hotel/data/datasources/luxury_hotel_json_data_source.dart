import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/hotel_page_data_model.dart';
import '../models/suite_model.dart';
import '../models/dining_venue_model.dart';
import '../models/spa_treatment_model.dart';
import '../models/concierge_privilege_model.dart';
import 'luxury_hotel_local_data_source.dart';

class LuxuryHotelJsonDataSource implements LuxuryHotelLocalDataSource {
  const LuxuryHotelJsonDataSource();

  @override
  Future<HotelPageDataModel> getHotelPageData() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/luxury_hotel/hotel_page.json',
    );
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return HotelPageDataModel.fromJson(json);
  }

  @override
  Future<List<SuiteModel>> getSuites() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/luxury_hotel/suites.json',
    );
    final list = jsonDecode(jsonString) as List<dynamic>;
    return list
        .map((e) => SuiteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<DiningVenueModel>> getDiningVenues() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/luxury_hotel/dining.json',
    );
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final list = json['venues'] as List<dynamic>;
    return list
        .map((e) => DiningVenueModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SpaTreatmentModel>> getSpaTreatments() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/luxury_hotel/spa.json',
    );
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final list = json['treatments'] as List<dynamic>;
    return list
        .map((e) => SpaTreatmentModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ConciergePrivilegeModel>> getConciergePrivileges() async {
    final jsonString = await rootBundle.loadString(
      'assets/mock/luxury_hotel/concierge.json',
    );
    final list = jsonDecode(jsonString) as List<dynamic>;
    return list
        .map((e) => ConciergePrivilegeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
