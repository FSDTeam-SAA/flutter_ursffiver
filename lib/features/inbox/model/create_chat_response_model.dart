import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';

class CreateChatResponseModel {
  final String id;
  final String name;
  final String requestBy;
  final String user;
  final String ststus;
  final String time;
  final List<Message> messages;
  final String createdAt;
  final String updatedAt;
  final int v;

  CreateChatResponseModel({
    required this.id,
    required this.name,
    required this.requestBy,
    required this.user,
    required this.ststus,
    required this.time,
    required this.messages,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CreateChatResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateChatResponseModel(
      id: json['_id'],
      name: json['name'],
      requestBy: json['requestBy'],
      user: json['user'],
      ststus: json['ststus'],
      time: json['time'],
      messages: List<Message>.from(
        json['messages'].map((x) => Message.fromJson(x)),
      ),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "requestBy": requestBy,
      "status": ststus,
      "time": time,
      "user": user,
      "messages": messages.map((x) => x.toJson()).toList(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": v,
    };
  }
}
