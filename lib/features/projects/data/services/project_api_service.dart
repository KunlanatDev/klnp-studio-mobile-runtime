import 'package:dio/dio.dart';

import '../../../../core/network/api_response.dart';
import '../models/project_model.dart';

/// Talks HTTP only. No mapping to domain entities, no business rules.
class ProjectApiService {
  final Dio _dio;

  const ProjectApiService(this._dio);

  String _base(String workspaceId) => '/workspaces/$workspaceId/projects';

  Future<List<ProjectModel>> list(String workspaceId, {String? keyword}) async {
    try {
      final res = await _dio.get(
        _base(workspaceId),
        queryParameters: {if (keyword != null) 'q': keyword},
      );
      final data = ApiResponse.data(res) as List;
      return data
          .map((e) => ProjectModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } on DioException catch (e) {
      ApiResponse.rethrowAsAppException(e);
    }
  }

  Future<ProjectModel> get(String workspaceId, String projectId) async {
    try {
      final res = await _dio.get('${_base(workspaceId)}/$projectId');
      return ProjectModel.fromJson(
        Map<String, dynamic>.from(ApiResponse.data(res) as Map),
      );
    } on DioException catch (e) {
      ApiResponse.rethrowAsAppException(e);
    }
  }

  Future<ProjectModel> create(
    String workspaceId,
    Map<String, dynamic> body,
  ) async {
    try {
      final res = await _dio.post(_base(workspaceId), data: body);
      return ProjectModel.fromJson(
        Map<String, dynamic>.from(ApiResponse.data(res) as Map),
      );
    } on DioException catch (e) {
      ApiResponse.rethrowAsAppException(e);
    }
  }

  Future<ProjectModel> update(
    String workspaceId,
    String projectId,
    Map<String, dynamic> body,
  ) async {
    try {
      final res = await _dio.patch('${_base(workspaceId)}/$projectId', data: body);
      return ProjectModel.fromJson(
        Map<String, dynamic>.from(ApiResponse.data(res) as Map),
      );
    } on DioException catch (e) {
      ApiResponse.rethrowAsAppException(e);
    }
  }

  Future<void> delete(String workspaceId, String projectId) async {
    try {
      await _dio.delete('${_base(workspaceId)}/$projectId');
    } on DioException catch (e) {
      ApiResponse.rethrowAsAppException(e);
    }
  }
}
