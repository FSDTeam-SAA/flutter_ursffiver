import 'package:flutter/material.dart';

import '../../auth/model/interest_model.dart';

class InterestModel {
  final String? id;
  final String name;
  final InterestColor color;

  InterestModel({required this.id, required this.name, required this.color});

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    debugPrint("user interest model: $json");
    return InterestModel(
      id: json['_id'],
      name: json['name'],
      color: InterestColor.fromString(json['color'] ?? "yellow"),
    );
  }

  //tojson
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'color': color.name,
    };
  }
}
