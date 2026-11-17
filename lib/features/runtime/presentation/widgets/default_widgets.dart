import 'package:flutter/material.dart';

import 'runtime_widget_registry.dart';

RuntimeWidgetRegistry createDefaultRegistry() {
  final registry = RuntimeWidgetRegistry();

  registry.register(
    'text',
    (node, renderChild) {
      final text = node.properties['text']?.toString() ?? '';
      final fontSize = (node.properties['fontSize'] as num?)?.toDouble() ?? 16.0;
      final rawWeight = node.properties['fontWeight'] as int? ?? 400;

      FontWeight fontWeight = FontWeight.normal;
      if (rawWeight >= 700) {
        fontWeight = FontWeight.bold;
      } else if (rawWeight >= 600) {
        fontWeight = FontWeight.w600;
      } else if (rawWeight >= 500) {
        fontWeight = FontWeight.w500;
      }

      Color? color;
      if (node.properties['color'] is String) {
        final colorStr = node.properties['color'] as String;
        if (colorStr.startsWith('#') && colorStr.length == 7) {
          color = Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
        }
      }

      return Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      );
    },
  );

  registry.register(
    'button',
    (node, renderChild) {
      final text = node.properties['text']?.toString() ?? 'Button';
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3978F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(text),
      );
    },
  );

  registry.register(
    'column',
    (node, renderChild) {
      final crossAxis = node.properties['crossAxisAlignment'] == 'center'
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start;
      return Column(
        crossAxisAlignment: crossAxis,
        mainAxisSize: MainAxisSize.min,
        children: node.children.map(renderChild).toList(),
      );
    },
  );

  registry.register(
    'row',
    (node, renderChild) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: node.children.map(renderChild).toList(),
      );
    },
  );

  registry.register(
    'container',
    (node, renderChild) {
      final paddingVal = (node.properties['padding'] as num?)?.toDouble() ?? 16.0;
      return Container(
        padding: EdgeInsets.all(paddingVal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: node.children.map(renderChild).toList(),
        ),
      );
    },
  );

  registry.register(
    'spacer',
    (node, renderChild) {
      final width = (node.properties['width'] as num?)?.toDouble();
      final height = (node.properties['height'] as num?)?.toDouble();
      return SizedBox(
        width: width,
        height: height,
      );
    },
  );

  return registry;
}
