import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:klnp_studio_runtime/features/projects/data/providers/project_providers.dart';
import 'package:klnp_studio_runtime/features/projects/domain/entities/project.dart';
import 'package:klnp_studio_runtime/features/projects/domain/repositories/project_repository.dart';
import 'package:klnp_studio_runtime/features/projects/presentation/controllers/projects_page_controller.dart';

class FakeProjectRepository implements ProjectRepository {
  final List<Project> items = [];
  bool fail = false;

  Project _make(String id, String name) => Project(
        id: id,
        workspaceId: 'w1',
        name: name,
        slug: name,
        platform: 'mobile',
        status: 'active',
        pageCount: 0,
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      );

  @override
  Future<List<Project>> getProjects({String? keyword}) async {
    if (fail) throw Exception('boom');
    return items.where((p) => keyword == null || p.name.contains(keyword)).toList();
  }

  @override
  Future<Project> getProject(String projectId) async =>
      items.firstWhere((p) => p.id == projectId);

  @override
  Future<Project> createProject(CreateProjectRequest request) async {
    final p = _make('p${items.length}', request.name);
    items.add(p);
    return p;
  }

  @override
  Future<Project> updateProject(UpdateProjectRequest request) async =>
      items.firstWhere((p) => p.id == request.id);

  @override
  Future<void> deleteProject(String projectId) async =>
      items.removeWhere((p) => p.id == projectId);
}

void main() {
  late FakeProjectRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = FakeProjectRepository();
    container = ProviderContainer(
      overrides: [projectRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    container.listen(projectsPageControllerProvider, (_, __) {});
  });

  test('fetchData loads items', () async {
    await repo.createProject(const CreateProjectRequest(name: 'a'));
    final c = container.read(projectsPageControllerProvider.notifier);
    await c.fetchData();
    expect(container.read(projectsPageControllerProvider).datas.value, hasLength(1));
  });

  test('createData and deleteData go through repository and reload', () async {
    final c = container.read(projectsPageControllerProvider.notifier);
    await c.createData(const CreateProjectRequest(name: 'x'));
    expect(container.read(projectsPageControllerProvider).datas.value, hasLength(1));
    await c.deleteData('p0');
    expect(container.read(projectsPageControllerProvider).datas.value, isEmpty);
    expect(container.read(projectsPageControllerProvider).isSaving, isFalse);
  });

  test('errors surface as AsyncError', () async {
    repo.fail = true;
    final c = container.read(projectsPageControllerProvider.notifier);
    await c.fetchData();
    expect(container.read(projectsPageControllerProvider).datas.hasError, isTrue);
  });
}
