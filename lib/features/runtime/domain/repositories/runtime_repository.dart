import '../entities/runtime_node.dart';

abstract interface class RuntimeRepository {
  Future<RuntimeNode> fetchDocument(String pageId);
}
