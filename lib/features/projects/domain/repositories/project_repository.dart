import '../entities/project.dart';

abstract interface class ProjectRepository {
  Future<List<Project>> getProjects({String? keyword});
  Future<Project> getProject(String projectId);
  Future<Project> createProject(CreateProjectRequest request);
  Future<Project> updateProject(UpdateProjectRequest request);
  Future<void> deleteProject(String projectId);
}
