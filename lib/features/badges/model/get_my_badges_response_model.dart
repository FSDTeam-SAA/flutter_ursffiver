import 'package:flutter/widgets.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_record.dart';

class GetMyBadgesResponseModel {
  final List<BadgeRecord> received;
  final List<BadgeRecord> given;

  GetMyBadgesResponseModel({required this.received, required this.given});

  factory GetMyBadgesResponseModel.fromJson(Map<String, dynamic> json) {
    final List<BadgeRecord> received = [];
    final List<BadgeRecord> given = [];
    // received
    for(final x in json['received']) {
      try {
        received.add(BadgeRecord.fromJson(x));
      } catch(e) {
        debugPrint(e.toString());
      }
    }

    for(final x in json['given']) {
      try {
        given.add(BadgeRecord.fromJson(x));
      } catch(e) {
        debugPrint(e.toString());
      }
    }
    return GetMyBadgesResponseModel(
      received:received,
      given:given
    );
  }
}
