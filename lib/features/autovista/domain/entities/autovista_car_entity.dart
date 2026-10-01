class AutovistaCarEntity {
  final String id;
  final String tag;
  final int tagColorValue;
  final String name;
  final String specs;
  final String price;
  final String period;
  final String image;
  final String? category;
  final String? rating;
  final String? trips;
  final String? speed;

  const AutovistaCarEntity({
    required this.id,
    required this.tag,
    required this.tagColorValue,
    required this.name,
    required this.specs,
    required this.price,
    required this.period,
    required this.image,
    this.category,
    this.rating,
    this.trips,
    this.speed,
  });
}
