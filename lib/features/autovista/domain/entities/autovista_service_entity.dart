class AutovistaServiceEntity {
  final String title;
  final String sub;
  final String icon;
  final List<String> features;

  const AutovistaServiceEntity({
    required this.title,
    required this.sub,
    required this.icon,
    this.features = const [],
  });
}
