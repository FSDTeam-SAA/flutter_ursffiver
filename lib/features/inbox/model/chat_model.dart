import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

enum ChatStatus {
  active,
  pending,
  closed;

  // fromString method
  static ChatStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return ChatStatus.active;
      case 'pending':
        return ChatStatus.pending;
      case 'closed':
        return ChatStatus.closed;
      default:
        throw ArgumentError('Invalid ChatStatus string: $status');
    }
  }
}

class ChatModel {
  final String id;
  final UserProfile requestedBy;
  final UserProfile user;
  final String title;
  final ChatStatus status;
  final String? avatarUrl;
  final MessageModel? lastMessage;
  final List<String> participants;
  final DateTime createdAt;
  ChatModel({
    required this.id,
    required this.requestedBy,
    required this.user,
    required this.title,
    required this.status,
    this.avatarUrl,
    this.lastMessage,
    required this.participants,
    required this.createdAt,
  });

  ChatModel copyWith({
    String? id,
    UserProfile? requestedBy,
    UserProfile? user,
    String? title,
    ChatStatus? status,
    String? avatarUrl,
    MessageModel? lastMessage,
    List<String>? participants,
    DateTime? createdAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      requestedBy: requestedBy ?? this.requestedBy,
      user: user ?? this.user,
      title: title ?? this.title,
      status: status ?? this.status,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastMessage: lastMessage ?? this.lastMessage,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'requestedBy': requestedBy.active,
      'user': user.toJson(),
      'title': title,
      'status': status.name,
      'avatarUrl': avatarUrl,
      'lastMessage': lastMessage?.toJson(),
      'participants': participants,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      requestedBy: UserProfile.fromJson(map['requestedBy'] as Map<String,dynamic>),
      user: UserProfile.fromJson(map['user'] as Map<String,dynamic>),
      title: map['title'] as String,
      status: ChatStatus.fromString(map['status'] as String),
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      lastMessage: map['lastMessage'] != null ? MessageModel.fromJson(map['lastMessage'] as Map<String,dynamic>) : null,
      participants: List<String>.from((map['participants'] as List<String>)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, requestedBy: $requestedBy, user: $user, title: $title, status: $status, avatarUrl: $avatarUrl, lastMessage: $lastMessage, participants: $participants, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.requestedBy == requestedBy &&
      other.user == user &&
      other.title == title &&
      other.status == status &&
      other.avatarUrl == avatarUrl &&
      other.lastMessage == lastMessage &&
      listEquals(other.participants, participants) &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      requestedBy.hashCode ^
      user.hashCode ^
      title.hashCode ^
      status.hashCode ^
      avatarUrl.hashCode ^
      lastMessage.hashCode ^
      participants.hashCode ^
      createdAt.hashCode;
  }
}
