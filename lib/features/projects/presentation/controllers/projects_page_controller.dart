import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/project_providers.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../state/projects_page_state.dart';

final projectsPageControllerProvider =
    NotifierProvider.autoDispose<ProjectsPageController, ProjectsPageState>(
  ProjectsPageController.new,
);

class ProjectsPageController extends AutoDisposeNotifier<ProjectsPageState> {
  ProjectRepository get _repository => ref.read(projectRepositoryProvider);

  @override
  ProjectsPageState build() {
    Future.microtask(fetchData);
    return const ProjectsPageState();
  }

  Future<void> fetchData() async {
    state = state.copyWith(datas: const AsyncLoading());
    await _load();
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    await _load();
    state = state.copyWith(isRefreshing: false);
  }

  Future<void> search(String keyword) async {
    state = state.copyWith(keyword: keyword);
    await fetchData();
  }

  void selectItem(Project? item) {
    state = item == null
        ? state.copyWith(clearSelectedItem: true)
        : state.copyWith(selectedItem: item);
  }

  Future<void> createData(CreateProjectRequest request) =>
      _mutate(() => _repository.createProject(request));

  Future<void> updateData(UpdateProjectRequest request) =>
      _mutate(() => _repository.updateProject(request));

  Future<void> deleteData(String id) =>
      _mutate(() => _repository.deleteProject(id));

  Future<void> _mutate(Future<void> Function() action) async {
    state = state.copyWith(isSaving: true);
    try {
      await action();
      await _load();
    } catch (error, stackTrace) {
      state = state.copyWith(datas: AsyncError(error, stackTrace));
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  Future<void> _load() async {
    try {
      final items = await _repository.getProjects(
        keyword: state.keyword.isEmpty ? null : state.keyword,
      );
      state = state.copyWith(datas: AsyncData(items));
    } catch (error, stackTrace) {
      state = state.copyWith(datas: AsyncError(error, stackTrace));
    }
  }
}
