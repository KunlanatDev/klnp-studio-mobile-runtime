import '../../../../core/error/app_exception.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../services/project_api_service.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectApiService _api;
  final String? Function() _workspaceId;

  const ProjectRepositoryImpl(this._api, this._workspaceId);

  String get _ws {
    final id = _workspaceId();
    if (id == null || id.isEmpty) {
      throw const ValidationException('No workspace selected');
    }
    return id;
  }

  @override
  Future<List<Project>> getProjects({String? keyword}) async {
    final models = await _api.list(_ws, keyword: keyword);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Project> getProject(String projectId) async =>
      (await _api.get(_ws, projectId)).toEntity();

  @override
  Future<Project> createProject(CreateProjectRequest request) async {
    final model = await _api.create(_ws, {
      'name': request.name,
      if (request.description != null) 'description': request.description,
      if (request.icon != null) 'icon': request.icon,
    });
    return model.toEntity();
  }

  @override
  Future<Project> updateProject(UpdateProjectRequest request) async {
    final model = await _api.update(_ws, request.id, {
      if (request.name != null) 'name': request.name,
      if (request.description != null) 'description': request.description,
      if (request.icon != null) 'icon': request.icon,
    });
    return model.toEntity();
  }

  @override
  Future<void> deleteProject(String projectId) =>
      _api.delete(_ws, projectId);
}
