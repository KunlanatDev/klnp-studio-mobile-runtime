import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/project_model.dart';

class ProjectsPageState {
  final AsyncValue<List<ProjectModel>> projects;
  final bool isCreating;
  final String keyword;

  const ProjectsPageState({
    this.projects = const AsyncLoading(),
    this.isCreating = false,
    this.keyword = '',
  });

  ProjectsPageState copyWith({
    AsyncValue<List<ProjectModel>>? projects,
    bool? isCreating,
    String? keyword,
  }) {
    return ProjectsPageState(
      projects: projects ?? this.projects,
      isCreating: isCreating ?? this.isCreating,
      keyword: keyword ?? this.keyword,
    );
  }
}
