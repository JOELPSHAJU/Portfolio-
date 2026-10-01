import 'package:flutter_riverpod/flutter_riverpod.dart';

class FleetState {
  final int selectedIndex;
  final int navDirection;

  const FleetState({
    this.selectedIndex = 2,
    this.navDirection = 1,
  });

  int get direction => navDirection;

  FleetState copyWith({
    int? selectedIndex,
    int? navDirection,
  }) {
    return FleetState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      navDirection: navDirection ?? this.navDirection,
    );
  }
}

class FleetController extends StateNotifier<FleetState> {
  FleetController() : super(const FleetState());

  void selectFleet(int newIndex, {int? direction}) {
    if (newIndex == state.selectedIndex) return;
    final int dir = direction ?? (newIndex > state.selectedIndex ? 1 : -1);
    state = state.copyWith(
      selectedIndex: newIndex,
      navDirection: dir,
    );
  }

  void selectIndex(int newIndex, {int? direction}) {
    selectFleet(newIndex, direction: direction);
  }
}

final fleetControllerProvider =
    StateNotifierProvider<FleetController, FleetState>((ref) {
  return FleetController();
});
