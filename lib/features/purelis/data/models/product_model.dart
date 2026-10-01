import '../../domain/entities/product.dart';

class ProductModel {
  final String id;
  final String name;
  final int price;
  final String formattedPrice;
  final String image;
  final String description;
  final String size;

  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.formattedPrice,
    required this.image,
    required this.description,
    required this.size,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      formattedPrice: json['formattedPrice'] as String? ?? '',
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? '',
      size: json['size'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'formattedPrice': formattedPrice,
      'image': image,
      'description': description,
      'size': size,
    };
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      formattedPrice: formattedPrice,
      image: image,
      description: description,
      size: size,
    );
  }
}
