import '../../domain/entities/product_category.dart';

class ProductCategoryModel {
  final String id;
  final String title;
  final String image;

  const ProductCategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  ProductCategory toEntity() {
    return ProductCategory(
      id: id,
      title: title,
      image: image,
    );
  }
}
