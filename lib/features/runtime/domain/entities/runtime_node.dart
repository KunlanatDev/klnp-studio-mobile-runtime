class RuntimeNode {
  final String id;
  final String type;
  final Map<String, dynamic> properties;
  final List<RuntimeNode> children;

  const RuntimeNode({
    required this.id,
    required this.type,
    this.properties = const {},
    this.children = const [],
  });

  factory RuntimeNode.fromJson(Map<String, dynamic> json) {
    final rawChildren = json['children'] as List? ?? [];

    return RuntimeNode(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? 'unknown',
      properties: Map<String, dynamic>.from(
        json['properties'] as Map? ?? {},
      ),
      children: rawChildren
          .map(
            (child) => RuntimeNode.fromJson(
              Map<String, dynamic>.from(child as Map),
            ),
          )
          .toList(),
    );
  }
}

