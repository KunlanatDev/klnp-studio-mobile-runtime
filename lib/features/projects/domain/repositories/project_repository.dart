import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/project_model.dart';

abstract class ProjectRepository {
  Future<List<ProjectModel>> getProjects({String? keyword});
  Future<ProjectModel> getProject(String projectId);
  Future<ProjectModel> createProject(CreateProjectRequest request);
  Future<void> deleteProject(String projectId);
}

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  throw UnimplementedError('projectRepositoryProvider not overridden');
});
