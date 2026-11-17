class PageModel {
  final String id;
  final String projectId;
  final String workspaceId;
  final String name;
  final String slug;
  final int position;
  final bool isHome;
  final String status;
  final int documentVersion;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? archivedAt;

  const PageModel({
    required this.id,
    required this.projectId,
    required this.workspaceId,
    required this.name,
    required this.slug,
    required this.position,
    required this.isHome,
    required this.status,
    required this.documentVersion,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.archivedAt,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      workspaceId: json['workspace_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String? ?? '',
      position: (json['position'] as num?)?.toInt() ?? 0,
      isHome: json['is_home'] as bool? ?? false,
      status: json['status'] as String? ?? 'active',
      documentVersion: (json['document_version'] as num?)?.toInt() ?? 1,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      archivedAt: json['archived_at'] != null
          ? DateTime.parse(json['archived_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'project_id': projectId,
    'workspace_id': workspaceId,
    'name': name,
    'slug': slug,
    'position': position,
    'is_home': isHome,
    'status': status,
    'document_version': documentVersion,
    'created_by': createdBy,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'archived_at': archivedAt?.toIso8601String(),
  };
}
