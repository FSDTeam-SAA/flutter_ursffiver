class NotificationModel {
  final String title;
  final String subtitle;
  final String time;
  bool isRead;
  final bool hasAvatar;
  final bool hasActions;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false,
    this.hasAvatar = false,
    this.hasActions = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      time: json['time'] ?? '',
      isRead: json['isRead'] ?? false,
      hasAvatar: json['hasAvatar'] ?? false,
      hasActions: json['hasActions'] ?? false,
    );
  }
}
