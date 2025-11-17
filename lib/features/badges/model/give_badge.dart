class GiveBadge {
  final String userId;
  final String badgeId;
  GiveBadge({required this.userId, required this.badgeId});

  factory GiveBadge.fromJson(Map<String, dynamic> json) {
    return GiveBadge(
      userId: json['userId'],
      badgeId: json['badgeIds'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "badgeIds": badgeId,
    };
  }
}
