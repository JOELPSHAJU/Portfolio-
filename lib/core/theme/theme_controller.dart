import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/dashboard/presentation/controllers/dashboard_controller.dart';

/// Persisted ThemeMode provider backed by SharedPreferences.
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeNotifier(prefs);
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  ThemeModeNotifier(this._prefs)
      : super(
          _prefs.getString(_key) == 'light' ? ThemeMode.light : ThemeMode.dark,
        );

  void toggleTheme() {
    final next =
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = next;
    _prefs.setString(_key, next == ThemeMode.light ? 'light' : 'dark');
  }
}
