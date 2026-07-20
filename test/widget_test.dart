import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:joel_portfolio/main.dart';
import 'package:joel_portfolio/features/dashboard/presentation/controllers/dashboard_controller.dart';

void main() {
  testWidgets('Portfolio UI test with Riverpod provider overrides', (WidgetTester tester) async {
    // Setup Mock Initial Values for SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();

    // Set screen size to desktop width so that all sections render without wrapping constraints
    tester.view.physicalSize = const Size(1600, 1200);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          // Override the SharedPreferences provider with our mocked instance
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ],
        child: const MyApp(),
      ),
    );

    // Let the initial futures complete and rebuild
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify portfolio displays Joel's name (cinematic hero uses name as watermark)
    expect(find.textContaining(RegExp('Joel P Shaju', caseSensitive: false)), findsAtLeastNWidgets(1));

    // Verify section headers exist
    expect(find.text('Professional Experience'), findsOneWidget);
    expect(find.text('Technical Capabilities'), findsOneWidget);
    expect(find.text('Featured Projects'), findsOneWidget);

    // Clean up physical size overrides
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
