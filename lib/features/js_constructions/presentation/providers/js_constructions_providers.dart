import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/js_constructions_fake_api.dart';
import '../../data/repositories/js_constructions_repository_impl.dart';
import '../../domain/entities/construction_project.dart';
import '../../domain/entities/fleet_machine.dart';
import '../../domain/entities/service.dart';
import '../../domain/entities/capability.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/entities/site_telemetry.dart';
import '../../domain/repositories/js_constructions_repository.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/get_fleet.dart';
import '../../domain/usecases/get_services.dart';
import '../../domain/usecases/get_capabilities.dart';
import '../../domain/usecases/get_team_members.dart';

final jsConstructionsFakeApiProvider = Provider<JsConstructionsFakeApi>((ref) {
  return JsConstructionsFakeApi();
});

final jsConstructionsRepositoryProvider =
    Provider<JsConstructionsRepository>((ref) {
  final api = ref.watch(jsConstructionsFakeApiProvider);
  return JsConstructionsRepositoryImpl(api: api);
});

final getProjectsUseCaseProvider = Provider<GetProjects>((ref) {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return GetProjects(repo);
});

final getPrestigeProjectsUseCaseProvider = Provider<GetPrestigeProjects>((ref) {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return GetPrestigeProjects(repo);
});

final getFleetUseCaseProvider = Provider<GetFleet>((ref) {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return GetFleet(repo);
});

final getServicesUseCaseProvider = Provider<GetServices>((ref) {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return GetServices(repo);
});

final getCapabilitiesUseCaseProvider = Provider<GetCapabilities>((ref) {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return GetCapabilities(repo);
});

final getTeamMembersUseCaseProvider = Provider<GetTeamMembers>((ref) {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return GetTeamMembers(repo);
});

final projectsProvider = FutureProvider<List<ConstructionProject>>((ref) async {
  final useCase = ref.watch(getProjectsUseCaseProvider);
  return useCase();
});

final prestigeProjectsProvider =
    FutureProvider<List<PrestigeProject>>((ref) async {
  final useCase = ref.watch(getPrestigeProjectsUseCaseProvider);
  return useCase();
});

final fleetProvider = FutureProvider<List<FleetMachine>>((ref) async {
  final useCase = ref.watch(getFleetUseCaseProvider);
  return useCase();
});

final servicesProvider = FutureProvider<List<Service>>((ref) async {
  final useCase = ref.watch(getServicesUseCaseProvider);
  return useCase();
});

final capabilitiesProvider = FutureProvider<List<Capability>>((ref) async {
  final useCase = ref.watch(getCapabilitiesUseCaseProvider);
  return useCase();
});

final teamMembersProvider = FutureProvider<List<TeamMember>>((ref) async {
  final useCase = ref.watch(getTeamMembersUseCaseProvider);
  return useCase();
});

final teamProvider = teamMembersProvider;

final telemetryProvider = FutureProvider<SiteTelemetry>((ref) async {
  final repo = ref.watch(jsConstructionsRepositoryProvider);
  return repo.getTelemetry();
});
