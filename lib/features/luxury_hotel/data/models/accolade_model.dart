import '../../domain/entities/accolade.dart';

class AccoladeModel extends Accolade {
  const AccoladeModel({
    required super.issuer,
    required super.grade,
    required super.award,
  });

  factory AccoladeModel.fromJson(Map<String, dynamic> json) {
    return AccoladeModel(
      issuer: json['issuer'] as String,
      grade: json['grade'] as String,
      award: json['award'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'issuer': issuer,
      'grade': grade,
      'award': award,
    };
  }

  Accolade toEntity() => this;
}
