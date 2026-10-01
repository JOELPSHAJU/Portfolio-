import '../../domain/entities/autovista_coupon_entity.dart';

class AutovistaCouponModel {
  final String code;
  final String discount;
  final String title;
  final String desc;

  const AutovistaCouponModel({
    required this.code,
    required this.discount,
    required this.title,
    required this.desc,
  });

  factory AutovistaCouponModel.fromJson(Map<String, dynamic> json) {
    return AutovistaCouponModel(
      code: json['code'] as String? ?? '',
      discount: json['discount'] as String? ?? '',
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
    );
  }

  AutovistaCouponEntity toEntity() {
    return AutovistaCouponEntity(
      code: code,
      discount: discount,
      title: title,
      desc: desc,
    );
  }
}
