import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/construction_project_model.dart';
import '../models/fleet_machine_model.dart';
import '../models/service_model.dart';
import '../models/capability_model.dart';
import '../models/team_member_model.dart';
import '../models/site_telemetry_model.dart';

class JsConstructionsFakeApi {
  Future<List<FleetMachineModel>> getFleet() async {
    final jsonString =
        await rootBundle.loadString('assets/mock/js_constructions/fleet.json');
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => FleetMachineModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ConstructionProjectModel>> getProjects() async {
    final jsonString = await rootBundle
        .loadString('assets/mock/js_constructions/projects.json');
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => ConstructionProjectModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PrestigeProjectModel>> getPrestigeProjects() async {
    final jsonString = await rootBundle
        .loadString('assets/mock/js_constructions/prestige_projects.json');
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => PrestigeProjectModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ServiceModel>> getServices() async {
    final jsonString = await rootBundle
        .loadString('assets/mock/js_constructions/services.json');
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<CapabilityModel>> getCapabilities() async {
    final jsonString = await rootBundle
        .loadString('assets/mock/js_constructions/capabilities.json');
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => CapabilityModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<TeamMemberModel>> getTeamMembers() async {
    final jsonString =
        await rootBundle.loadString('assets/mock/js_constructions/team.json');
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => TeamMemberModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<SiteTelemetryModel> getTelemetry() async {
    final jsonString = await rootBundle
        .loadString('assets/mock/js_constructions/telemetry.json');
    final dynamic data = json.decode(jsonString);
    return SiteTelemetryModel.fromJson(data as Map<String, dynamic>);
  }
}
