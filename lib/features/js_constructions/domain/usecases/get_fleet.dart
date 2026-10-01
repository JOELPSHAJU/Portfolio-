import '../entities/fleet_machine.dart';
import '../repositories/js_constructions_repository.dart';

class GetFleet {
  final JsConstructionsRepository repository;

  GetFleet(this.repository);

  Future<List<FleetMachine>> call() {
    return repository.getFleet();
  }
}
