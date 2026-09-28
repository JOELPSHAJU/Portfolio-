import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/sections/skills_section.dart';

void main() {
  final sizes = [
    const Size(320, 568),   // iPhone SE
    const Size(360, 800),   // Small Android
    const Size(390, 844),   // iPhone 14
    const Size(412, 915),   // Pixel 7
    const Size(600, 900),   // Foldable / Mini tablet
    const Size(720, 1080),  // Tablet lower
    const Size(768, 1024),  // iPad
    const Size(800, 1280),  // Android Tablet
    const Size(1024, 768),  // iPad Landscape
    const Size(1080, 1920), // 1080 portrait
    const Size(1150, 900),  // Desktop breakpoint
    const Size(1280, 800),  // Laptop
    const Size(1366, 768),  // HD Laptop
    const Size(1440, 900),  // MacBook
    const Size(1600, 1200), // Large monitor
    const Size(1920, 1080), // Full HD Desktop
    const Size(2560, 1440), // 2K QHD
  ];

  for (final size in sizes) {
    testWidgets('SkillsSection renders cleanly without overflow at ${size.width}x${size.height}', (tester) async {
      FlutterErrorDetails? caughtDetails;
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        caughtDetails = details;
      };

      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: SkillsSection(skills: []),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      FlutterError.onError = originalOnError;
      final ex = tester.takeException();

      expect(caughtDetails, isNull, reason: 'Caught Flutter error at ${size.width}x${size.height}: ${caughtDetails?.summary}');
      expect(ex, isNull, reason: 'Exception at ${size.width}x${size.height}: $ex');

      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    });
  }
}
