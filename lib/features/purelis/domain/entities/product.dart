class Product {
  final String id;
  final String name;
  final int price;
  final String formattedPrice;
  final String image;
  final String description;
  final String size;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.formattedPrice,
    required this.image,
    required this.description,
    required this.size,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
