import 'package:flutter/material.dart';

import '../../domain/entities/runtime_node.dart';

typedef RuntimeWidgetBuilder = Widget Function(
  RuntimeNode node,
  Widget Function(RuntimeNode node) renderChild,
);

class RuntimeWidgetRegistry {
  final Map<String, RuntimeWidgetBuilder> _builders = {};

  void register(
    String type,
    RuntimeWidgetBuilder builder,
  ) {
    _builders[type] = builder;
  }

  Widget build(
    RuntimeNode node,
    Widget Function(RuntimeNode node) renderChild,
  ) {
    final builder = _builders[node.type];

    if (builder == null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0x26FFC107),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.amber.shade700, width: 0.8),
        ),
        child: Text(
          'Unsupported component: <${node.type}>',
          style: TextStyle(
            fontSize: 12,
            color: Colors.amber.shade900,
            fontFamily: 'monospace',
          ),
        ),
      );
    }

    return builder(node, renderChild);
  }
}
