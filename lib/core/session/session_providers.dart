import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active workspace used to scope workspace-based API routes.
/// Set after sign-in / workspace selection.
final currentWorkspaceIdProvider = StateProvider<String?>((ref) => null);
