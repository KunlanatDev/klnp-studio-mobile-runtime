class PlanLimitModel {
  final int used;
  final int limit;
  final int? remaining;
  final bool unlimited;

  const PlanLimitModel({
    required this.used,
    required this.limit,
    this.remaining,
    required this.unlimited,
  });

  factory PlanLimitModel.fromJson(Map<String, dynamic> json) {
    return PlanLimitModel(
      used: (json['used'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      remaining: (json['remaining'] as num?)?.toInt(),
      unlimited: json['unlimited'] as bool? ?? false,
    );
  }
}

class EntitlementModel {
  final String workspaceId;
  final String planCode;
  final String planName;
  final Map<String, int> limits;
  final Map<String, dynamic> features;
  final PlanLimitModel pageUsage;

  const EntitlementModel({
    required this.workspaceId,
    required this.planCode,
    required this.planName,
    required this.limits,
    required this.features,
    required this.pageUsage,
  });

  factory EntitlementModel.fromJson(Map<String, dynamic> json) {
    final plan = json['plan'] as Map<String, dynamic>? ?? {};
    final usage = json['usage'] as Map<String, dynamic>? ?? {};
    final pagesUsage = usage['pages'] as Map<String, dynamic>? ?? {};

    return EntitlementModel(
      workspaceId: json['workspace_id'] as String? ?? '',
      planCode: plan['code'] as String? ?? 'free',
      planName: plan['name'] as String? ?? 'Free',
      limits: Map<String, int>.from(json['limits'] as Map? ?? {}),
      features: Map<String, dynamic>.from(json['features'] as Map? ?? {}),
      pageUsage: PlanLimitModel.fromJson(pagesUsage),
    );
  }
}
