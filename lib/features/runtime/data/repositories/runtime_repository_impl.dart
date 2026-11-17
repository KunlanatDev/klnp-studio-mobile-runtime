import '../../domain/entities/runtime_node.dart';
import '../../domain/repositories/runtime_repository.dart';
import '../services/runtime_api_service.dart';

class RuntimeRepositoryImpl implements RuntimeRepository {
  final RuntimeApiService _api;

  const RuntimeRepositoryImpl(this._api);

  @override
  Future<RuntimeNode> fetchDocument(String pageId) async =>
      RuntimeNode.fromJson(await _api.fetchDocument(pageId));
}
