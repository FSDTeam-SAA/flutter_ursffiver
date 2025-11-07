class MessageModel {
  MessageModel({
    this.text,
    required this.chatId,
    this.user,
    required this.date,
    this.read,
    this.id,
  });

  final String? text;
  final String chatId;
  final Usermodelformessage? user;
  final DateTime date;
  final bool? read;
  final String? id;

  bool isMe(String currentUserId) {
    return user!.id == currentUserId;
  }
  

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      chatId: json['chatId'],
      user: json['user'] != null
          ? Usermodelformessage.fromJson(json['user'])
          : null,
      date: DateTime.parse(json['date']),
      read: json['read'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "chatId": chatId,
      //"user": user?.toJson(),
      "date": date.toIso8601String(),
      "read": read,
      "_id": id,
    };
  }
}

class Usermodelformessage {
  final String  id;
  final String? role;
  Usermodelformessage({ required this.id, this.role});

  factory Usermodelformessage.fromJson(Map<String, dynamic> json) {
    return Usermodelformessage(id: json['_id'], role: json['role']);
  }
}
