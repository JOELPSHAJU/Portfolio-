import '../entities/experience.dart';
import '../entities/project.dart';
import '../entities/skill.dart';
import '../repositories/portfolio_repository.dart';

class PortfolioData {
  final List<Project> projects;
  final List<Experience> experiences;
  final List<Skill> skills;

  PortfolioData({
    required this.projects,
    required this.experiences,
    required this.skills,
  });
}

class GetPortfolioData {
  final PortfolioRepository repository;

  GetPortfolioData(this.repository);

  Future<PortfolioData> call() async {
    final projects = await repository.getProjects();
    final experiences = await repository.getExperiences();
    final skills = await repository.getSkills();
    return PortfolioData(
      projects: projects,
      experiences: experiences,
      skills: skills,
    );
  }
}
