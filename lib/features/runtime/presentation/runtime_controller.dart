import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'runtime_state.dart';

final runtimeControllerProvider = NotifierProvider.autoDispose<RuntimeController, RuntimeState>(
  RuntimeController.new,
);

class RuntimeController extends AutoDisposeNotifier<RuntimeState> {
  @override
  RuntimeState build() => const RuntimeState();

  void markReady() {
    state = state.copyWith(isReady: true);
  }
}
