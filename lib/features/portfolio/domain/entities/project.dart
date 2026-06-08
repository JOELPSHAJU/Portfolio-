class Project {
  final String id;
  final String title;
  final String description;
  final List<String> points;
  final List<String> technologies;
  final String type;
  final String clientOrOrg;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.technologies,
    required this.type,
    required this.clientOrOrg,
  });
}
