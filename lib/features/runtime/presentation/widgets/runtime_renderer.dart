import 'package:flutter/material.dart';

import '../../domain/entities/runtime_node.dart';
import 'runtime_widget_registry.dart';

class RuntimeRenderer extends StatelessWidget {
  final RuntimeNode node;
  final RuntimeWidgetRegistry registry;

  const RuntimeRenderer({
    super.key,
    required this.node,
    required this.registry,
  });

  Widget _renderChild(RuntimeNode node) {
    return RuntimeRenderer(
      node: node,
      registry: registry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return registry.build(node, _renderChild);
  }
}

