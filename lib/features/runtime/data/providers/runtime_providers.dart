import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../domain/repositories/runtime_repository.dart';
import '../../presentation/widgets/default_widgets.dart';
import '../../presentation/widgets/runtime_widget_registry.dart';
import '../repositories/runtime_repository_impl.dart';
import '../services/runtime_api_service.dart';

final runtimeApiServiceProvider = Provider<RuntimeApiService>(
  (ref) => RuntimeApiService(ref.watch(dioProvider)),
);

final runtimeRepositoryProvider = Provider<RuntimeRepository>(
  (ref) => RuntimeRepositoryImpl(ref.watch(runtimeApiServiceProvider)),
);

final runtimeWidgetRegistryProvider = Provider<RuntimeWidgetRegistry>(
  (ref) => createDefaultRegistry(),
);
