import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joel_portfolio/features/purelis/presentation/pages/purelis_website_page.dart';

void main() {
  testWidgets('PurelisWebsitePage renders all key sections and header', (tester) async {
    tester.view.physicalSize = const Size(1280, 1024);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: PurelisWebsitePage(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('PURELIS'), findsOneWidget);
    expect(find.text('NATURALLY PURE.'), findsOneWidget);
    expect(find.text('SHOP BY CATEGORY'), findsOneWidget);
    expect(find.text('NEW ARRIVALS'), findsOneWidget);
    expect(find.text('SUBSCRIBE TO OUR NEWSLETTER'), findsOneWidget);
  });
}
