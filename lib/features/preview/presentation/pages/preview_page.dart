import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../runtime/data/providers/runtime_providers.dart';
import '../../../runtime/presentation/controllers/runtime_controller.dart';
import '../../../runtime/presentation/widgets/runtime_renderer.dart';
import '../../domain/sample_documents.dart';

/// UI only: reads runtime state and forwards actions to the controller.
class PreviewPage extends ConsumerStatefulWidget {
  const PreviewPage({super.key});

  @override
  ConsumerState<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends ConsumerState<PreviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(runtimeControllerProvider.notifier)
          .loadDocument(SampleDocuments.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runtimeControllerProvider);
    final registry = ref.watch(runtimeWidgetRegistryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KLNP Studio · Runtime Preview'),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Reload Sample Document',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(runtimeControllerProvider.notifier)
                .loadDocument(SampleDocuments.reloaded),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: state.document.when(
                data: (node) => node == null
                    ? const Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('No document loaded'),
                      )
                    : RuntimeRenderer(node: node, registry: registry),
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (err, _) => Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('Render Error: $err'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
