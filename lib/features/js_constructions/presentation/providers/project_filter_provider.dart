import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/construction_project.dart';
import 'js_constructions_providers.dart';

final projectCategoryProvider = StateProvider<String>((ref) => 'all');

final filteredProjectsProvider =
    Provider<AsyncValue<List<ConstructionProject>>>((ref) {
  final projectsAsync = ref.watch(projectsProvider);
  final category = ref.watch(projectCategoryProvider);

  return projectsAsync.whenData((projects) {
    if (category == 'all') {
      return projects;
    }
    return projects.where((p) => p.category == category).toList();
  });
});
