import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/project_model.dart';
import '../../domain/repositories/project_repository.dart';
import '../state/projects_page_state.dart';

final projectsPageControllerProvider =
    NotifierProvider.autoDispose<ProjectsPageController, ProjectsPageState>(
  ProjectsPageController.new,
);

class ProjectsPageController extends AutoDisposeNotifier<ProjectsPageState> {
  late ProjectRepository _repository;

  @override
  ProjectsPageState build() {
    _repository = ref.read(projectRepositoryProvider);
    Future.microtask(fetchProjects);
    return const ProjectsPageState();
  }

  Future<void> fetchProjects() async {
    state = state.copyWith(projects: const AsyncLoading());
    try {
      final projects = await _repository.getProjects(
        keyword: state.keyword.isNotEmpty ? state.keyword : null,
      );
      state = state.copyWith(projects: AsyncData(projects));
    } catch (error, stackTrace) {
      state = state.copyWith(projects: AsyncError(error, stackTrace));
    }
  }

  Future<void> createProject(CreateProjectRequest request) async {
    state = state.copyWith(isCreating: true);
    try {
      await _repository.createProject(request);
      await fetchProjects();
    } finally {
      state = state.copyWith(isCreating: false);
    }
  }
}
