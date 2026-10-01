import '../../domain/entities/construction_project.dart';
import '../../domain/entities/fleet_machine.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/capability.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/entities/site_telemetry.dart';
import '../../domain/repositories/js_constructions_repository.dart';
import '../datasources/js_constructions_fake_api.dart';

class JsConstructionsRepositoryImpl implements JsConstructionsRepository {
  final JsConstructionsFakeApi api;

  JsConstructionsRepositoryImpl({required this.api});

  @override
  Future<List<ConstructionProject>> getProjects() {
    return api.getProjects();
  }

  @override
  Future<List<PrestigeProject>> getPrestigeProjects() {
    return api.getPrestigeProjects();
  }

  @override
  Future<List<FleetMachine>> getFleet() {
    return api.getFleet();
  }

  @override
  Future<List<Service>> getServices() {
    return api.getServices();
  }

  @override
  Future<List<Capability>> getCapabilities() {
    return api.getCapabilities();
  }

  @override
  Future<List<TeamMember>> getTeamMembers() {
    return api.getTeamMembers();
  }

  @override
  Future<SiteTelemetry> getTelemetry() {
    return api.getTelemetry();
  }
}
