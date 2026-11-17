import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klnp_studio_runtime/app/app.dart';

void main() {
  testWidgets('KLNP Studio runtime smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: KlnpStudioApp()));

    expect(find.text('KLNP Studio'), findsOneWidget);
    expect(find.text('Native Runtime · MVP 1'), findsOneWidget);
  });
}
