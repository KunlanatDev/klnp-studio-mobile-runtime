import 'package:dio/dio.dart';

import '../error/app_exception.dart';

/// Unwraps the backend envelope `{ success, data, meta, error }`.
class ApiResponse {
  const ApiResponse._();

  static dynamic data(Response<dynamic> response) {
    final body = response.data;
    if (body is Map && body['success'] == false) {
      final error = body['error'];
      final message = error is Map ? '${error['message']}' : 'Request failed';
      throw ServerException(message, null, response.statusCode);
    }
    if (body is Map && body.containsKey('data')) return body['data'];
    return body;
  }

  /// Converts [DioException] into an [AppException] for the domain layer.
  static Never rethrowAsAppException(DioException e) {
    final status = e.response?.statusCode;
    final body = e.response?.data;
    final message = body is Map && body['error'] is Map
        ? '${(body['error'] as Map)['message']}'
        : (e.message ?? 'Network error');
    if (status == null) throw NetworkException(message, e);
    throw ServerException(message, e, status);
  }
}
