import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/controllers/runtime_controller.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/widgets/default_widgets.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/widgets/runtime_renderer.dart';
import 'package:klnp_studio_runtime/features/runtime/presentation/widgets/runtime_widget_registry.dart';

class PreviewPage extends ConsumerStatefulWidget {
  const PreviewPage({super.key});

  @override
  ConsumerState<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends ConsumerState<PreviewPage> {
  late final RuntimeWidgetRegistry _registry;

  @override
  void initState() {
    super.initState();
    _registry = createDefaultRegistry();

    // Load initial sample document into the controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(runtimeControllerProvider.notifier).loadDocument({
        'id': 'root-container',
        'type': 'container',
        'properties': {'padding': 24},
        'children': [
          {
            'id': 'tag-text',
            'type': 'text',
            'properties': {
              'text': 'My First App',
              'fontSize': 14,
              'fontWeight': 600,
              'color': '#3978F6',
            },
          },
          {
            'id': 'spacer-1',
            'type': 'spacer',
            'properties': {'height': 8},
          },
          {
            'id': 'heading-text',
            'type': 'text',
            'properties': {
              'text': 'Welcome!',
              'fontSize': 32,
              'fontWeight': 700,
            },
          },
          {
            'id': 'spacer-2',
            'type': 'spacer',
            'properties': {'height': 12},
          },
          {
            'id': 'desc-text',
            'type': 'text',
            'properties': {
              'text': 'Build something amazing with KLNP Studio.',
              'fontSize': 16,
              'fontWeight': 400,
            },
          },
          {
            'id': 'spacer-3',
            'type': 'spacer',
            'properties': {'height': 24},
          },
          {
            'id': 'cta-btn',
            'type': 'button',
            'properties': {
              'text': 'Get Started',
            },
          },
        ],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(runtimeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('KLNP Studio · Runtime Preview'),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Reload Sample Document',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(runtimeControllerProvider.notifier).loadDocument({
                'id': 'sample-column',
                'type': 'column',
                'properties': {'crossAxisAlignment': 'start'},
                'children': [
                  {
                    'id': 'sample-text',
                    'type': 'text',
                    'properties': {
                      'text': 'Reloaded Native UI',
                      'fontSize': 24,
                      'fontWeight': 700,
                    },
                  },
                ],
              });
            },
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
                data: (node) {
                  if (node == null) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Text('No document loaded'),
                    );
                  }
                  return RuntimeRenderer(
                    node: node,
                    registry: _registry,
                  );
                },
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
