import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klnp_studio_runtime/features/runtime/domain/entities/runtime_node.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/widgets/default_widgets.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/widgets/runtime_renderer.dart';

void main() {
  testWidgets('RuntimeRenderer renders registered native widgets correctly', (tester) async {
    final registry = createDefaultRegistry();

    const node = RuntimeNode(
      id: 'container-1',
      type: 'container',
      properties: {'padding': 12},
      children: [
        RuntimeNode(
          id: 'text-1',
          type: 'text',
          properties: {'text': 'Hello Native Flutter'},
        ),
        RuntimeNode(
          id: 'btn-1',
          type: 'button',
          properties: {'text': 'Click Me'},
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RuntimeRenderer(
            node: node,
            registry: registry,
          ),
        ),
      ),
    );

    expect(find.text('Hello Native Flutter'), findsOneWidget);
    expect(find.text('Click Me'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('RuntimeRenderer shows fallback for unknown widget without crashing', (tester) async {
    final registry = createDefaultRegistry();

    const node = RuntimeNode(
      id: 'custom-999',
      type: 'some_future_ai_widget',
      properties: {},
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RuntimeRenderer(
            node: node,
            registry: registry,
          ),
        ),
      ),
    );

    expect(find.textContaining('Unsupported component: <some_future_ai_widget>'), findsOneWidget);
  });
}

