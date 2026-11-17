import 'package:dio/dio.dart';

class RuntimeRemoteDataSource {
  final Dio dio;

  RuntimeRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> fetchDocument(String pageId) async {
    final response = await dio.get('/pages/$pageId/document');
    return Map<String, dynamic>.from(response.data as Map);
  }
}

