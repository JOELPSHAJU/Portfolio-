import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistNotifier extends StateNotifier<Set<String>> {
  WishlistNotifier() : super({});

  void add(String id) {
    if (!state.contains(id)) {
      state = {...state, id};
    }
  }

  void remove(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    }
  }

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }

  bool contains(String id) => state.contains(id);

  void clear() {
    state = {};
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, Set<String>>((ref) {
  return WishlistNotifier();
});

final purelisWishlistProvider = wishlistProvider;
