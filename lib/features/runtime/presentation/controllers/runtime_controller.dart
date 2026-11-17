import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/runtime_providers.dart';
import '../../domain/entities/runtime_node.dart';
import '../state/runtime_state.dart';

class RuntimeController extends Notifier<RuntimeState> {
  @override
  RuntimeState build() {
    return const RuntimeState(
      document: AsyncData(null),
    );
  }

  /// Loads a document from the backend through the repository.
  Future<void> fetchDocument(String pageId) async {
    state = state.copyWith(document: const AsyncLoading());
    try {
      final document =
          await ref.read(runtimeRepositoryProvider).fetchDocument(pageId);
      state = state.copyWith(document: AsyncData(document));
    } catch (error, stackTrace) {
      state = state.copyWith(document: AsyncError(error, stackTrace));
    }
  }

  /// Loads an already available JSON document (preview / local).
  void loadDocument(Map<String, dynamic> json) {
    try {
      final document = RuntimeNode.fromJson(json);

      state = state.copyWith(
        document: AsyncData(document),
      );
    } catch (error, stackTrace) {
      state = state.copyWith(
        document: AsyncError(error, stackTrace),
      );
    }
  }

  void clearDocument() {
    state = const RuntimeState(
      document: AsyncData(null),
    );
  }
}

final runtimeControllerProvider =
    NotifierProvider<RuntimeController, RuntimeState>(
  RuntimeController.new,
);
