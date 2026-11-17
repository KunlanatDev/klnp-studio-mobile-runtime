import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/controllers/runtime_controller.dart';

void main() {
  test('should load document and update state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(runtimeControllerProvider.notifier).loadDocument({
      'id': 'root',
      'type': 'text',
      'properties': {'text': 'KLNP'},
      'children': [],
    });

    final state = container.read(runtimeControllerProvider);

    expect(state.document.value, isNotNull);
    expect(state.document.value?.id, 'root');
    expect(state.document.value?.properties['text'], 'KLNP');
  });

  test('should clear document', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(runtimeControllerProvider.notifier).loadDocument({
      'id': 'root',
      'type': 'text',
      'properties': {'text': 'KLNP'},
      'children': [],
    });

    container.read(runtimeControllerProvider.notifier).clearDocument();

    final state = container.read(runtimeControllerProvider);
    expect(state.document.value, isNull);
  });
}

