import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

class BadgeRecord {
  final String id;
  final UserProfile userFrom;
  final UserProfile userTo;
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
      userFrom: UserProfile.fromJson(json['userFrom']),
      userTo: UserProfile.fromJson(json['userTo']),
      badge: BadgeModel.fromJson(json['badge']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
