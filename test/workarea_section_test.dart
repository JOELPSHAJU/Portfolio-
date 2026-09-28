import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/portfolio/presentation/views/sections/workarea_section.dart';

void main() {
  final testSizes = [
    const Size(320, 568),
    const Size(375, 667),
    const Size(390, 844),
    const Size(412, 915),
    const Size(600, 960),
    const Size(768, 1024),
    const Size(800, 1280),
    const Size(900, 1300),
    const Size(1024, 768),
    const Size(1280, 800),
    const Size(1366, 768),
    const Size(1440, 900),
    const Size(1600, 1200),
    const Size(1920, 1080),
    const Size(2560, 1440),
  ];

  for (final size in testSizes) {
    testWidgets(
      'WorkareaSection renders cleanly without overflow at ${size.width}x${size.height}',
      (WidgetTester tester) async {
        FlutterErrorDetails? caughtDetails;
        final originalOnError = FlutterError.onError;
        FlutterError.onError = (details) {
          caughtDetails = details;
        };

        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: const Scaffold(
              body: SingleChildScrollView(
                child: WorkareaSection(),
              ),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));

        FlutterError.onError = originalOnError;
        final ex = tester.takeException();

        expect(find.text('MY WORKAREA'), findsOneWidget);
        expect(find.text('JS CONSTRUCTIONS'), findsOneWidget);
        expect(find.text('THE LUMINA PALACE'), findsOneWidget);
        expect(find.text('PURELIS SKINCARE'), findsOneWidget);
        expect(find.text('GO DRIVE'), findsOneWidget);

        expect(caughtDetails, isNull, reason: 'Caught Flutter error at ${size.width}x${size.height}: ${caughtDetails?.summary}');
        expect(ex, isNull, reason: 'Exception at ${size.width}x${size.height}: $ex');

        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
      },
    );
  }
}
