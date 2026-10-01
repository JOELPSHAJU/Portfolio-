import '../entities/team_member.dart';
import '../repositories/js_constructions_repository.dart';

class GetTeamMembers {
  final JsConstructionsRepository repository;

  GetTeamMembers(this.repository);

  Future<List<TeamMember>> call() {
    return repository.getTeamMembers();
  }
}
