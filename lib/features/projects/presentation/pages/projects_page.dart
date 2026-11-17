import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/projects_page_controller.dart';

/// UI only: reads state, forwards user actions to the controller.
class ProjectsPage extends ConsumerWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(projectsPageControllerProvider);
    final controller = ref.read(projectsPageControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: RefreshIndicator(
        onRefresh: controller.refresh,
        child: state.datas.when(
          data: (items) => items.isEmpty
              ? const Center(child: Text('No projects'))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(items[i].name),
                    subtitle: Text('${items[i].pageCount} pages'),
                    onTap: () => controller.selectItem(items[i]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => controller.deleteData(items[i].id),
                    ),
                  ),
                ),
          error: (e, _) => Center(child: Text('Error: $e')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
