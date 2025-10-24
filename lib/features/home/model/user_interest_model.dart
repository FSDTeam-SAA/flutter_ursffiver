import 'package:flutter/material.dart';

import '../../auth/model/interest_model.dart';

class UserInterestModel {
  final String id;
  final String name;
  final InterestColor color;

  UserInterestModel({
    required this.id,
    required this.name,
    required this.color,
  });

  factory UserInterestModel.fromJson(Map<String, dynamic> json) {
    debugPrint("user interest model: $json");
    return UserInterestModel(
      id: json['_id'],
      name: json['name'],
      color: InterestColor.fromString(json['color']),
    );
  }
}
