import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

class ChatData {
  final String id;
  final String? name;
  final String? fullName;
  final UserProfile? user;
  List<Message> messages = [];
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  ChatData({
    required this.id,
    this.name,
    this.fullName,
    this.user,
    List<Message>? chatMessages,
    this.createdAt,
    this.updatedAt,
    this.v,
  }): messages = chatMessages ?? [];

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      id: json['_id'],
      name: json['name'],
      fullName: json['fullName'],
      user: UserProfile.fromJson(json['user']),
      chatMessages: json['messages'] != null
          ? List<Message>.from(
          json['messages'].map((x) => Message.fromJson(x)))
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "fullName": fullName,
      "user": user,
      "messages": messages.map((x) => x.toJson()).toList(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}
