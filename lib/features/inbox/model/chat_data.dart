import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'message_model.dart';

class ChatData {
  final String id;
  final String? name;
  final UserModel requestBy;
  final UserModel? user;
  final String status;
  final String? avatarUrl;
  final DateTime? time;
  final Message? lastMessage;
  final String? createdAt;
  final String? updatedAt;

  ChatData({
    required this.id,
    this.name,
    required this.requestBy,
    required this.status,
    this.avatarUrl,
    this.time,
    this.user,
    this.lastMessage,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    try {
      debugPrint("requestBy parse: ${json['requestBy']},");
      //debugPrint("requestBy parsed: ${UserModel.fromJson(json['requestBy'] as Map<String, dynamic>)}");
    } catch (e) {
      debugPrint("Error parsing requestBy: $e");
    }
    return ChatData(
      id: json['_id'] ?? '',
      name: json['name'],
      requestBy: UserModel.fromJson(json['requestBy'] as Map<String, dynamic>),
      status: json['status'] ?? '',
      avatarUrl: json['avatarUrl'],
      time: DateTime.tryParse(json['time'] ?? ''),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      lastMessage: json['lastMessage'] != null
          ? Message.fromJson(json['lastMessage'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "requestBy": requestBy.toJson(),
      "status": status,
      "avatarUrl": avatarUrl,
      "time": time,
      "user": user?.toJson(),
      "lastMessage": lastMessage?.toJson(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
