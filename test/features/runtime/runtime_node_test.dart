import 'package:flutter_test/flutter_test.dart';
import 'package:klnp_studio_runtime/features/runtime/domain/entities/runtime_node.dart';

void main() {
  test('should parse runtime node with properties and children', () {
    final json = {
      'id': 'node-001',
      'type': 'text',
      'properties': {
        'text': 'Hello KLNP',
        'fontSize': 20,
      },
      'children': [
        {
          'id': 'node-002',
          'type': 'button',
          'properties': {'text': 'Click'},
          'children': [],
        }
      ],
    };

    final node = RuntimeNode.fromJson(json);

    expect(node.id, 'node-001');
    expect(node.type, 'text');
    expect(node.properties['text'], 'Hello KLNP');
    expect(node.properties['fontSize'], 20);
    expect(node.children.length, 1);
    expect(node.children.first.id, 'node-002');
    expect(node.children.first.type, 'button');
  });

  test('should handle empty or null fields gracefully', () {
    final node = RuntimeNode.fromJson({});
    expect(node.id, '');
    expect(node.type, 'unknown');
    expect(node.properties, isEmpty);
    expect(node.children, isEmpty);
  });
}

