import '../../domain/entities/contact_message.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/project.dart';
import '../../domain/entities/skill.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_datasource.dart';
import '../datasources/portfolio_remote_datasource.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource localDataSource;
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Project>> getProjects() async {
    try {
      final data = await remoteDataSource.getPortfolioData();
      return data.projects.map((p) => Project(
        id: p.id,
        title: p.title,
        type: p.type,
        clientOrOrg: p.clientOrOrg,
        description: p.description,
        points: p.points,
        technologies: p.technologies,
      )).toList();
    } catch (e) {
      // Fallback to local source if server is unreachable
      return await localDataSource.getProjects();
    }
  }

  @override
  Future<List<Experience>> getExperiences() async {
    try {
      final data = await remoteDataSource.getPortfolioData();
      return data.experiences.map((e) => Experience(
        role: e.role,
        company: e.company,
        duration: e.duration,
        location: e.location,
        points: e.points,
        technologies: e.technologies,
      )).toList();
    } catch (e) {
      return await localDataSource.getExperiences();
    }
  }

  @override
  Future<List<Skill>> getSkills() async {
    try {
      final data = await remoteDataSource.getPortfolioData();
      return data.skills.map((s) => Skill(
        name: s.name,
        level: s.level,
        category: s.category,
      )).toList();
    } catch (e) {
      return await localDataSource.getSkills();
    }
  }

  @override
  Future<bool> sendContactMessage(ContactMessage message) async {
    try {
      return await remoteDataSource.sendContactMessage(
        message.name,
        message.email,
        message.message,
      );
    } catch (e) {
      return await localDataSource.saveContactMessage(
        message.name,
        message.email,
        message.message,
      );
    }
  }
}
