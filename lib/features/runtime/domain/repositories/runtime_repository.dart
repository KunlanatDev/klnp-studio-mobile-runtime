abstract interface class RuntimeRepository {
  Future<Map<String, dynamic>> fetchDocument(String pageId);
}

