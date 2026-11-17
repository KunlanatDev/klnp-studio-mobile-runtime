import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/session/session_providers.dart';
import '../../domain/repositories/project_repository.dart';
import '../repositories/project_repository_impl.dart';
import '../services/project_api_service.dart';

final projectApiServiceProvider = Provider<ProjectApiService>(
  (ref) => ProjectApiService(ref.watch(dioProvider)),
);

final projectRepositoryProvider = Provider<ProjectRepository>(
  (ref) => ProjectRepositoryImpl(
    ref.watch(projectApiServiceProvider),
    () => ref.read(currentWorkspaceIdProvider),
  ),
);
