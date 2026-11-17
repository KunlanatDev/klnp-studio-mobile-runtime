import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';

class RuntimeApiService {
  final Dio _dio;

  const RuntimeApiService(this._dio);

  /// NOTE: backend `document` module is not implemented yet (S3 persistence).
  Future<Map<String, dynamic>> fetchDocument(String pageId) async {
    try {
      final res = await _dio.get('/pages/$pageId/document');
      return Map<String, dynamic>.from(ApiResponse.data(res) as Map);
    } on DioException catch (e) {
      ApiResponse.rethrowAsAppException(e);
    }
  }
}
