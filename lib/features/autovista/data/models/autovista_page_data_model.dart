import '../../domain/entities/autovista_page_data_entity.dart';
import 'autovista_car_model.dart';
import 'autovista_coupon_model.dart';
import 'autovista_deal_model.dart';
import 'autovista_hub_model.dart';
import 'autovista_insurance_plan_model.dart';
import 'autovista_service_model.dart';
import 'autovista_value_prop_model.dart';

class AutovistaPageDataModel {
  final List<AutovistaCarModel> popularCars;
  final List<AutovistaCarModel> fleetCars;
  final List<AutovistaDealModel> dealsCars;
  final List<AutovistaHubModel> hubs;
  final List<AutovistaServiceModel> services;
  final List<AutovistaCouponModel> coupons;
  final List<AutovistaServiceModel> detailedServices;
  final List<AutovistaInsurancePlanModel> insurancePlans;
  final List<AutovistaValuePropModel> valueProps;

  const AutovistaPageDataModel({
    required this.popularCars,
    required this.fleetCars,
    required this.dealsCars,
    required this.hubs,
    required this.services,
    required this.coupons,
    required this.detailedServices,
    required this.insurancePlans,
    required this.valueProps,
  });

  factory AutovistaPageDataModel.fromJson(Map<String, dynamic> json) {
    return AutovistaPageDataModel(
      popularCars: (json['popularCars'] as List<dynamic>?)
              ?.map((e) => AutovistaCarModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fleetCars: (json['fleetCars'] as List<dynamic>?)
              ?.map((e) => AutovistaCarModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      dealsCars: (json['dealsCars'] as List<dynamic>?)
              ?.map((e) => AutovistaDealModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hubs: (json['hubs'] as List<dynamic>?)
              ?.map((e) => AutovistaHubModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => AutovistaServiceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      coupons: (json['coupons'] as List<dynamic>?)
              ?.map((e) => AutovistaCouponModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      detailedServices: (json['detailedServices'] as List<dynamic>?)
              ?.map((e) => AutovistaServiceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      insurancePlans: (json['insurancePlans'] as List<dynamic>?)
              ?.map((e) => AutovistaInsurancePlanModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      valueProps: (json['valueProps'] as List<dynamic>?)
              ?.map((e) => AutovistaValuePropModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }

  AutovistaPageDataEntity toEntity() {
    return AutovistaPageDataEntity(
      popularCars: popularCars.map((e) => e.toEntity()).toList(),
      fleetCars: fleetCars.map((e) => e.toEntity()).toList(),
      dealsCars: dealsCars.map((e) => e.toEntity()).toList(),
      hubs: hubs.map((e) => e.toEntity()).toList(),
      services: services.map((e) => e.toEntity()).toList(),
      coupons: coupons.map((e) => e.toEntity()).toList(),
      detailedServices: detailedServices.map((e) => e.toEntity()).toList(),
      insurancePlans: insurancePlans.map((e) => e.toEntity()).toList(),
      valueProps: valueProps.map((e) => e.toEntity()).toList(),
    );
  }
}
