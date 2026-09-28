import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/sections/about_section.dart';

void main() {
  final sizes = [
    const Size(320, 568),   // Very small mobile (iPhone SE 1st gen)
    const Size(360, 800),   // Small mobile (Samsung Galaxy)
    const Size(375, 667),   // iPhone 8 / SE 2nd
    const Size(390, 844),   // Standard mobile (iPhone 12/13/14)
    const Size(412, 915),   // Android mobile (Pixel 7)
    const Size(480, 854),   // Large phone
    const Size(600, 900),   // Small tablet / foldable
    const Size(720, 1080),  // Tablet lower bound
    const Size(768, 1024),  // iPad portrait
    const Size(800, 1280),  // Android tablet
    const Size(900, 1200),  // Mid-sized tablet
    const Size(1024, 768),  // iPad landscape
    const Size(1080, 1920), // Desktop lower bound
    const Size(1150, 900),  // Navbar breakpoint
    const Size(1200, 800),  // 1200 breakpoint
    const Size(1280, 800),  // Standard desktop/laptop
    const Size(1366, 768),  // Common 768p laptop
    const Size(1440, 900),  // MacBook Air/Pro
    const Size(1536, 864),  // Windows laptop default scaling
    const Size(1600, 1200), // Large monitor
    const Size(1920, 1080), // Full HD desktop
    const Size(2560, 1440), // 2K QHD monitor
  ];

  for (final size in sizes) {
    testWidgets('AboutSection renders cleanly without overflow at ${size.width}x${size.height}', (tester) async {
      FlutterErrorDetails? caughtDetails;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        caughtDetails = details;
      };

      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: const AboutSection(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      FlutterError.onError = originalOnError;
      final ex = tester.takeException();

      expect(caughtDetails, isNull, reason: 'Flutter caught error at ${size.width}x${size.height}: ${caughtDetails?.summary}');
      expect(ex, isNull, reason: 'Exception at ${size.width}x${size.height}: $ex');

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  }
}
