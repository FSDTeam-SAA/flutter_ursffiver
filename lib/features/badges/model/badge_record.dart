import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';

class BadgeRecord {
  final String id;
  final UserModel userFrom;
  final UserModel userTo;
  final BadgeModel badge;
  final DateTime createdAt;
  final DateTime updatedAt;

  BadgeRecord({
    required this.id,
    required this.userFrom,
    required this.userTo,
    required this.badge,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BadgeRecord.fromJson(Map<String, dynamic> json) {
    return BadgeRecord(
      id: json['_id'],
      userFrom: UserModel.fromJson(json['userFrom']),
      userTo: UserModel.fromJson(json['userTo']),
      badge: BadgeModel.fromJson(json['badge']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
