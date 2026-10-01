import '../../domain/entities/spa_treatment.dart';

class SpaTreatmentModel extends SpaTreatment {
  const SpaTreatmentModel({
    required super.title,
    required super.time,
    required super.price,
    required super.desc,
  });

  factory SpaTreatmentModel.fromJson(Map<String, dynamic> json) {
    return SpaTreatmentModel(
      title: json['title'] as String,
      time: json['time'] as String,
      price: json['price'] as String,
      desc: json['desc'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'price': price,
      'desc': desc,
    };
  }

  SpaTreatment toEntity() => this;
}
