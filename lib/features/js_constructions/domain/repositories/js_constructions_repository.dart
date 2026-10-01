import '../entities/construction_project.dart';
import '../entities/fleet_machine.dart';
import '../entities/service.dart';
import '../entities/capability.dart';
import '../entities/team_member.dart';
import '../entities/site_telemetry.dart';

abstract class JsConstructionsRepository {
  Future<List<ConstructionProject>> getProjects();
  Future<List<PrestigeProject>> getPrestigeProjects();
  Future<List<FleetMachine>> getFleet();
  Future<List<Service>> getServices();
  Future<List<Capability>> getCapabilities();
  Future<List<TeamMember>> getTeamMembers();
  Future<SiteTelemetry> getTelemetry();
}
