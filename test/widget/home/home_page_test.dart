import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:smart_utility_toolkit/core/constants/app_constants.dart';
import 'package:smart_utility_toolkit/features/home/presentation/pages/home_page.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    tempDir = await Directory.systemTemp.createTemp('smart_utility_toolkit_test');
    Hive.init(tempDir.path);
    await Hive.openBox<dynamic>(AppConstants.settingsBox);
  });

  tearDownAll(() async {
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  testWidgets('Home page shows core tool cards', (WidgetTester tester) async {
    // Set a larger surface size to ensure all items are rendered in tests if possible
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unit Converter'), findsOneWidget);
    expect(find.text('Calculator'), findsOneWidget);
    
    // Scroll down to find the rest
    await tester.drag(find.byType(GridView), const Offset(0, -300));
    await tester.pumpAndSettle();
    
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Bill Splitter'), findsOneWidget);
    
    // Reset view size
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
