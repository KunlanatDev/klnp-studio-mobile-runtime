import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/runtime_node.dart';

class RuntimeState {
  final AsyncValue<RuntimeNode?> document;

  const RuntimeState({
    this.document = const AsyncLoading(),
  });

  RuntimeState copyWith({
    AsyncValue<RuntimeNode?>? document,
  }) {
    return RuntimeState(
      document: document ?? this.document,
    );
  }
}

