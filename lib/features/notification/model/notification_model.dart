import 'package:flutter_ursffiver/features/home/model/user_model.dart';

enum NotificationType {
  general,
  messageRequest,
  accepted,
  rejected;

  factory NotificationType.fromString(String name) {
    switch (name) {
      case "general":
        return NotificationType.general;
      case "accepted":
        return NotificationType.accepted;
      case "rejected":
        return NotificationType.rejected;
      case "message request":
        return NotificationType.messageRequest;
      default:
        throw Exception("Invalid notification type");
    }
  }
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final UserModel user;
  final String? chatId;
  final String? badgeId;
  final bool isRead;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.user,
    this.chatId,
    this.badgeId,
    required this.isRead,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // --- Factory constructor to parse JSON ---
  factory NotificationModel.fromJson(Map<String, dynamic> json) {

    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: NotificationType.fromString(json['type']),
      user: UserModel.fromJsonForNotification(json['user']),
      chatId: json['chat'],
      badgeId: json['badgeId'],
      isRead: json['isRead'] ?? false,
      imageUrl: json['profileImage'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  static List<NotificationModel> listFromJson(List<dynamic> jsonList) {
    final list = <NotificationModel>[];
    for (final json in jsonList) {
      try {
        final notification = NotificationModel.fromJson(json);
        list.add(notification);
      } catch (e) {
        // You can give a debug message here...
        "";
      }
    }
    return list;
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    NotificationType? type,
    String? userId,
    String? chatId,
    String? badgeId,
    bool? isRead,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      user: user,
      chatId: chatId ?? this.chatId,
      badgeId: badgeId ?? this.badgeId,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
