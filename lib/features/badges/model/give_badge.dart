class GiveBadge {
  final String userId;
  final String badgeId;
  GiveBadge({required this.userId, required this.badgeId});

  factory GiveBadge.fromJson(Map<String, dynamic> json) {
    return GiveBadge(
      userId: json['userId'],
      badgeId: json['badgeId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "badgeId": badgeId,
    };
  }
}
