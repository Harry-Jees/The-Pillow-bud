import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pillow_bud/widgets/daily_quote_widget.dart';

void main() {
  testWidgets('DailyQuoteWidget renders correctly and refreshes', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DailyQuoteWidget(),
        ),
      ),
    );

    // Verify initial quote components are present
    expect(find.byType(IconButton), findsOneWidget); // Refresh button
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    
    // Check for presence of quote text (any text since it's mock data)
    expect(find.byType(Text), findsAtLeastNWidgets(2));

    // Tap the refresh button
    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();

    // Verify widget still exists after refresh
    expect(find.byType(DailyQuoteWidget), findsOneWidget);
  });
}