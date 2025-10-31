
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

class Message {
  final String? text;
  final usermodelformessage? user;
  final String? date;
  final bool? read;
  final String? id;

  Message({
    this.text,
    this.user,
    this.date,
    this.read,
    this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      user: json['user'] != null ? usermodelformessage.fromJson(json['user']) : null,
      date: json['date'],
      read: json['read'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      //"user": user?.toJson(),
      "date": date,
      "read": read,
      "_id": id,
    };
  }

}


class usermodelformessage {
  final String? id;
  final String? role;
  usermodelformessage({
    this.id,
    this.role
  });

  factory usermodelformessage.fromJson(Map<String, dynamic> json) {
    return usermodelformessage(
      id: json['_id'],
      role: json['role'],
    );
  }
}