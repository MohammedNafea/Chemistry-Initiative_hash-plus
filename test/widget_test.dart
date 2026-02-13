// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chemistry_initiative/main.dart';
import 'package:chemistry_initiative/splash_screen1.dart';

void main() {
  testWidgets('App starts with SplashScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Wrap MyApp in ProviderScope as done in main.dart
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that SplashScreen is displayed.
    expect(find.byType(SplashScreen), findsOneWidget);
    
    // Verify that we are not showing the counter (default test)
    expect(find.text('0'), findsNothing);
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
