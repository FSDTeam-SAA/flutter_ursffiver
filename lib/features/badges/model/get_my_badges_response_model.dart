import 'package:flutter_ursffiver/features/badges/model/badge_record.dart';

class GetMyBadgesResponseModel {
  final List<BadgeRecord> received;
  final List<BadgeRecord> given;

  GetMyBadgesResponseModel({required this.received, required this.given});

  factory GetMyBadgesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetMyBadgesResponseModel(
      received: List<BadgeRecord>.from(
        json['received'].map((x) => BadgeRecord.fromJson(x)),
      ),
      given: List<BadgeRecord>.from(
        json['given'].map((x) => BadgeRecord.fromJson(x)),
      ),
    );
  }
}
