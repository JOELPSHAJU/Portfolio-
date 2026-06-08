import '../entities/project.dart';
import '../entities/experience.dart';
import '../entities/skill.dart';
import '../entities/contact_message.dart';

abstract class PortfolioRepository {
  Future<List<Project>> getProjects();
  Future<List<Experience>> getExperiences();
  Future<List<Skill>> getSkills();
  Future<bool> sendContactMessage(ContactMessage message);
}
