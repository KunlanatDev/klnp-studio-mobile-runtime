import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klnp_studio_runtime/app/app.dart';

void main() {
  testWidgets('KLNP Studio runtime preview smoke test', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: KLNPStudioApp()));
    await tester.pumpAndSettle();

    expect(find.text('KLNP Studio · Runtime Preview'), findsOneWidget);
    expect(find.text('My First App'), findsOneWidget);
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('Build something amazing with KLNP Studio.'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
