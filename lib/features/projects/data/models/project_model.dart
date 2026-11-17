class ProjectModel {
  final String id;
  final String workspaceId;
  final String name;
  final String slug;
  final String? description;
  final String? icon;
  final String platform;
  final String status;
  final int pageCount;
  final String? homePageId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProjectModel({
    required this.id,
    required this.workspaceId,
    required this.name,
    required this.slug,
    this.description,
    this.icon,
    required this.platform,
    required this.status,
    required this.pageCount,
    this.homePageId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      workspaceId: json['workspace_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      platform: json['platform'] as String? ?? 'mobile',
      status: json['status'] as String? ?? 'active',
      pageCount: (json['page_count'] as num?)?.toInt() ?? 0,
      homePageId: json['home_page_id'] as String?,
      createdBy: json['created_by'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'workspace_id': workspaceId,
    'name': name,
    'slug': slug,
    'description': description,
    'icon': icon,
    'platform': platform,
    'status': status,
    'page_count': pageCount,
    'home_page_id': homePageId,
    'created_by': createdBy,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

class CreateProjectRequest {
  final String name;
  final String? description;
  final String? icon;

  const CreateProjectRequest({
    required this.name,
    this.description,
    this.icon,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    if (description != null) 'description': description,
    if (icon != null) 'icon': icon,
  };
}
