import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/project.dart';

class ProjectsPageState {
  final AsyncValue<List<Project>> datas;
  final bool isRefreshing;
  final bool isSaving;
  final String keyword;
  final Project? selectedItem;

  const ProjectsPageState({
    this.datas = const AsyncLoading(),
    this.isRefreshing = false,
    this.isSaving = false,
    this.keyword = '',
    this.selectedItem,
  });

  ProjectsPageState copyWith({
    AsyncValue<List<Project>>? datas,
    bool? isRefreshing,
    bool? isSaving,
    String? keyword,
    Project? selectedItem,
    bool clearSelectedItem = false,
  }) {
    return ProjectsPageState(
      datas: datas ?? this.datas,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isSaving: isSaving ?? this.isSaving,
      keyword: keyword ?? this.keyword,
      selectedItem: clearSelectedItem ? null : (selectedItem ?? this.selectedItem),
    );
  }
}
