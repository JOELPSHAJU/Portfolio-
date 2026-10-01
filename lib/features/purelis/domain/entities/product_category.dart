class ProductCategory {
  final String id;
  final String title;
  final String image;

  const ProductCategory({
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
