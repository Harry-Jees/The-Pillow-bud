import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pillow_bud/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: PillowBudApp()),
    );
    // Wait for animations and async setup.
    await tester.pumpAndSettle(const Duration(seconds: 3));
    // Verify the app renders the splash screen or beyond.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
