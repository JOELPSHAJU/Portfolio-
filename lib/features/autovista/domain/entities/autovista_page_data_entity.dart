import 'autovista_car_entity.dart';
import 'autovista_coupon_entity.dart';
import 'autovista_deal_entity.dart';
import 'autovista_hub_entity.dart';
import 'autovista_insurance_plan_entity.dart';
import 'autovista_service_entity.dart';
import 'autovista_value_prop_entity.dart';

class AutovistaPageDataEntity {
  final List<AutovistaCarEntity> popularCars;
  final List<AutovistaCarEntity> fleetCars;
  final List<AutovistaDealEntity> dealsCars;
  final List<AutovistaHubEntity> hubs;
  final List<AutovistaServiceEntity> services;
  final List<AutovistaCouponEntity> coupons;
  final List<AutovistaServiceEntity> detailedServices;
  final List<AutovistaInsurancePlanEntity> insurancePlans;
  final List<AutovistaValuePropEntity> valueProps;

  const AutovistaPageDataEntity({
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
}
