import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

enum ChatStatus {
  accept,
  pending,
  reject;

  // fromString method
  static ChatStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'accept':
        return ChatStatus.accept;
      case 'pending':
        return ChatStatus.pending;
      case 'reject':
        return ChatStatus.reject;
      default:
        throw ArgumentError('Invalid ChatStatus string: $status');
    }
  }
}

class ChatModel {
  final String id;
  final UserProfile requestedBy;
  final UserProfile user;
  final String name;
  final ChatStatus status;
  final String? avatarUrl;
  final MessageModel? lastMessage;
  //final List<String> participants;
  final DateTime time;
  final DateTime createdAt;
  ChatModel({
    required this.id,
    required this.requestedBy,
    required this.user,
    required this.name,
    required this.status,
    this.avatarUrl,
    this.lastMessage,
    //required this.participants,
    required this.createdAt,
    required this.time,
  });

  ChatModel copyWith({
    String? id,
    UserProfile? requestedBy,
    UserProfile? user,
    String? title,
    ChatStatus? status,
    String? avatarUrl,
    MessageModel? lastMessage,
    //List<String>? participants,
    DateTime? createdAt,
    DateTime? time,
  }) {
    return ChatModel(
      id: id ?? this.id,
      requestedBy: requestedBy ?? this.requestedBy,
      user: user ?? this.user,
      name: title ?? this.name,
      status: status ?? this.status,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      //participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'requestedBy': requestedBy.active,
      'user': user.toJson(),
      'title': name,
      'status': status.name,
      'avatarUrl': avatarUrl,
      'lastMessage': lastMessage?.toJson(),
      //'participants': participants,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'time': time?.toUtc().toIso8601String(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] as String,
      requestedBy: UserProfile.fromJson(
        map['requestBy'] as Map<String, dynamic>,
      ),
      user: UserProfile.fromJson(map['user'] as Map<String, dynamic>),
      name: map['name'] as String,
      status: ChatStatus.fromString(map['status'] as String),
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      lastMessage: map['lastMessage'] != null
          ? MessageModel.fromJson(map['lastMessage'] as Map<String, dynamic>)
          : null,
      //participants: List<String>.from((map['participants'] as List<String>)),
      createdAt: DateTime.parse(map['createdAt'] as String),
      time: DateTime.parse(map['time'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, requestedBy: $requestedBy, time: $time, user: $user, title: $name, status: $status, avatarUrl: $avatarUrl, lastMessage: $lastMessage, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.requestedBy == requestedBy &&
        other.user == user &&
        other.name == name &&
        other.status == status &&
        other.avatarUrl == avatarUrl &&
        other.lastMessage == lastMessage &&
        other.createdAt == createdAt &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        requestedBy.hashCode ^
        user.hashCode ^
        name.hashCode ^
        status.hashCode ^
        avatarUrl.hashCode ^
        lastMessage.hashCode ^
        createdAt.hashCode ^
        time.hashCode;
  }
}
