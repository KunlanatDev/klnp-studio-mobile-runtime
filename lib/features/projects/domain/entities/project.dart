class Project {
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
  final DateTime createdAt;
  final DateTime updatedAt;

  const Project({
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
    required this.createdAt,
    required this.updatedAt,
  });
}

class CreateProjectRequest {
  final String name;
  final String? description;
  final String? icon;

  const CreateProjectRequest({required this.name, this.description, this.icon});
}

class UpdateProjectRequest {
  final String id;
  final String? name;
  final String? description;
  final String? icon;

  const UpdateProjectRequest({
    required this.id,
    this.name,
    this.description,
    this.icon,
  });
}
