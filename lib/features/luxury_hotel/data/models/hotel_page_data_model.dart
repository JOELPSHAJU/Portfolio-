import '../../domain/entities/hotel_page_data.dart';
import 'suite_model.dart';
import 'dining_venue_model.dart';
import 'spa_treatment_model.dart';
import 'concierge_privilege_model.dart';
import 'accolade_model.dart';
import 'booking_model.dart';
import 'navigation_item_model.dart';

class HotelPageDataModel extends HotelPageData {
  const HotelPageDataModel({
    required List<SuiteModel> suites,
    required List<DiningVenueModel> diningVenues,
    required List<SpaTreatmentModel> spaTreatments,
    required List<ConciergePrivilegeModel> conciergePrivileges,
    required List<AccoladeModel> accolades,
    required BookingModel booking,
    required List<NavigationItemModel> navigationItems,
  }) : super(
          suites: suites,
          diningVenues: diningVenues,
          spaTreatments: spaTreatments,
          conciergePrivileges: conciergePrivileges,
          accolades: accolades,
          booking: booking,
          navigationItems: navigationItems,
        );

  factory HotelPageDataModel.fromJson(Map<String, dynamic> json) {
    return HotelPageDataModel(
      suites: (json['suites'] as List<dynamic>)
          .map((e) => SuiteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      diningVenues: (json['diningVenues'] as List<dynamic>)
          .map((e) => DiningVenueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      spaTreatments: (json['spaTreatments'] as List<dynamic>)
          .map((e) => SpaTreatmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      conciergePrivileges: (json['conciergePrivileges'] as List<dynamic>)
          .map((e) => ConciergePrivilegeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      accolades: (json['accolades'] as List<dynamic>)
          .map((e) => AccoladeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      booking: BookingModel.fromJson(json['booking'] as Map<String, dynamic>),
      navigationItems: (json['navigationItems'] as List<dynamic>)
          .map((e) => NavigationItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suites': (suites as List<SuiteModel>).map((e) => e.toJson()).toList(),
      'diningVenues':
          (diningVenues as List<DiningVenueModel>).map((e) => e.toJson()).toList(),
      'spaTreatments':
          (spaTreatments as List<SpaTreatmentModel>).map((e) => e.toJson()).toList(),
      'conciergePrivileges': (conciergePrivileges as List<ConciergePrivilegeModel>)
          .map((e) => e.toJson())
          .toList(),
      'accolades':
          (accolades as List<AccoladeModel>).map((e) => e.toJson()).toList(),
      'booking': (booking as BookingModel).toJson(),
      'navigationItems':
          (navigationItems as List<NavigationItemModel>).map((e) => e.toJson()).toList(),
    };
  }

  HotelPageData toEntity() => this;
}
