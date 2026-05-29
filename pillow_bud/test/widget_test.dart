import 'package:flutter_test/flutter_test.dart';
import 'package:pillow_bud/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PillowBudApp());
    expect(find.byType(PillowBudApp), findsOneWidget);
  });
}
