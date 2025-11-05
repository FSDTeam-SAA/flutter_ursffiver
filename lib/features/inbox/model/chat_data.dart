import 'message_model.dart';

class ChatData {
  final String id;
  final String? name;
  final String requestBy;
  final String? user;
  final String ststus;
  final String? time;
  final List<Message> messages;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  ChatData({
    required this.id,
    this.name,
    required this.requestBy,
    required this.ststus,
    this.time,
    this.user,
    List<Message>? chatMessages,
    this.createdAt,
    this.updatedAt,
    this.v,
  }) : messages = chatMessages ?? [];

  factory ChatData.fromJson(Map<String, dynamic> json) {
    var messageList = <Message>[];
    if (json['messages'] != null) {
      messageList = List<Message>.from(
        json['messages'].map((x) => Message.fromJson(x)),
      );
    }

    return ChatData(
      id: json['_id'] ?? '',
      name: json['name'],
      requestBy: json['requestBy'] ?? '',
      ststus: json['status'] ?? '',
      time: json['time'],
      user: json['user'],
      chatMessages: messageList,
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