import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/autovista/data/datasources/autovista_local_data_source.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_car_model.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_coupon_model.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_deal_model.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_hub_model.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_insurance_plan_model.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_service_model.dart';
import 'package:joel_portfolio/features/autovista/data/models/autovista_value_prop_model.dart';
import 'package:joel_portfolio/features/autovista/data/repositories/autovista_repository_impl.dart';
import 'package:joel_portfolio/features/autovista/domain/usecases/get_autovista_page_data.dart';

void main() {
  group('Autovista Models & Data Layer', () {
    test('AutovistaCarModel parses correctly and converts to Entity', () {
      final json = {
        'id': 'porsche_911',
        'tag': 'Flagship Supercar',
        'tagColor': '0xFFE50914',
        'name': 'Porsche 911 Carrera GTS',
        'category': 'Sports & Exotics',
        'specs': '2024 | PDK Automatic | 473 HP',
        'price': '₹42,000',
        'period': '/ day',
        'image': 'assets/autovista_hero_porsche.jpg',
        'rating': '5.00',
        'trips': '64 trips',
        'speed': '312 km/h',
      };

      final model = AutovistaCarModel.fromJson(json);
      expect(model.id, 'porsche_911');
      expect(model.name, 'Porsche 911 Carrera GTS');
      expect(model.tagColorValue, 0xFFE50914);
      expect(model.category, 'Sports & Exotics');

      final entity = model.toEntity();
      expect(entity.id, model.id);
      expect(entity.name, model.name);
      expect(entity.speed, '312 km/h');
    });

    test('AutovistaDealModel parses correctly and converts to Entity', () {
      final json = {
        'id': 'macan_gts_deal',
        'tag': 'Power Pass',
        'tagColor': '0xFFE50914',
        'name': 'Porsche Macan GTS',
        'discount': '20% OFF',
        'originalPrice': '₹35,500',
        'dealPrice': '₹28,500',
        'period': '/ day',
        'savings': 'Save ₹7,000/day',
        'image': 'assets/autovista_test_drive.jpg',
        'badge': 'Instant Confirmation',
      };

      final model = AutovistaDealModel.fromJson(json);
      expect(model.id, 'macan_gts_deal');
      expect(model.discount, '20% OFF');
      expect(model.dealPrice, '₹28,500');

      final entity = model.toEntity();
      expect(entity.name, 'Porsche Macan GTS');
      expect(entity.savings, 'Save ₹7,000/day');
    });

    test('AutovistaHubModel parses correctly and converts to Entity', () {
      final json = {
        'city': 'Kochi',
        'name': 'Cochin International Airport (COK)',
        'terminal': 'Terminal 3 VIP Arrivals Lounge',
        'address': 'Airport Road, Nedumbassery, Kochi',
        'type': 'Airport Hubs',
        'hours': 'Open 24 Hours / 7 Days',
        'fleet': '42 Vehicles Available',
        'phone': '+91 98470 11001',
        'is24x7': true,
      };

      final model = AutovistaHubModel.fromJson(json);
      expect(model.city, 'Kochi');
      expect(model.is24x7, isTrue);

      final entity = model.toEntity();
      expect(entity.phone, '+91 98470 11001');
    });

    test('AutovistaServiceModel & Coupon & Insurance models parse correctly', () {
      final serviceModel = AutovistaServiceModel.fromJson({
        'title': 'Chauffeur Drive',
        'sub': 'Executive transport',
        'icon': 'airline_seat_recline_extra_rounded',
        'features': ['English speaking', 'Wi-Fi included'],
      });
      expect(serviceModel.features.length, 2);
      expect(serviceModel.toEntity().title, 'Chauffeur Drive');

      final couponModel = AutovistaCouponModel.fromJson({
        'code': 'AUTOVISTA20',
        'discount': '20% OFF',
        'title': 'Luxury Discount',
        'desc': 'Valid on bookings',
      });
      expect(couponModel.toEntity().code, 'AUTOVISTA20');

      final insuranceModel = AutovistaInsurancePlanModel.fromJson({
        'tier': 'Platinum Zero-Excess',
        'cost': '₹2,999 / day',
        'excess': '₹0 ZERO EXCESS',
        'isFeatured': true,
        'items': ['Zero Deductible', 'Key loss replacement'],
      });
      expect(insuranceModel.isFeatured, isTrue);
      expect(insuranceModel.toEntity().items.length, 2);

      final propModel = AutovistaValuePropModel.fromJson({
        'title': 'Sanitized Fleet',
        'sub': '100% clean',
        'icon': 'verified_outlined',
      });
      expect(propModel.toEntity().title, 'Sanitized Fleet');
    });

    test('AutovistaLocalDataSource fallback loads complete page data', () async {
      final dataSource = AutovistaLocalDataSourceImpl();
      final pageDataModel = await dataSource.getPageData();

      expect(pageDataModel.popularCars.isNotEmpty, isTrue);
      expect(pageDataModel.fleetCars.isNotEmpty, isTrue);
      expect(pageDataModel.dealsCars.isNotEmpty, isTrue);
      expect(pageDataModel.hubs.isNotEmpty, isTrue);
      expect(pageDataModel.services.isNotEmpty, isTrue);
      expect(pageDataModel.coupons.isNotEmpty, isTrue);
      expect(pageDataModel.detailedServices.isNotEmpty, isTrue);
      expect(pageDataModel.insurancePlans.isNotEmpty, isTrue);
      expect(pageDataModel.valueProps.isNotEmpty, isTrue);

      final repository = AutovistaRepositoryImpl(localDataSource: dataSource);
      final useCase = GetAutovistaPageData(repository);
      final entity = await useCase();

      expect(entity.popularCars.length, pageDataModel.popularCars.length);
      expect(entity.fleetCars.length, pageDataModel.fleetCars.length);
    });
  });
}
