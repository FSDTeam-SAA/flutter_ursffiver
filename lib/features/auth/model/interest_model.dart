// import 'package:flutter/material.dart';

// class InterestModel {
//   final String id;
//   final String name;
//   final String interestCategory;
//   final InterestColor color;
//   final String createdAt;
//   final String updatedAt;

//   InterestModel({
//     required this.id,
//     required this.name,
//     required this.interestCategory,
//     required this.color,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory InterestModel.fromJson(Map<String, dynamic> json) {
//     return InterestModel(
//       id: json['_id'],
//       name: json['name'],
//       interestCategory: json['interestCategory'],
//       color: InterestColor.fromString(json['color']),
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//     );
//   }
// }

import 'package:flutter/material.dart';

class InterestModel {
  final String id;
  final String name;
  final InterestColor color;

  InterestModel({required this.id, required this.name, required this.color});

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['_id'],
      name: json['name'],
      color: InterestColor.fromString(json['color']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterestModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color;

  @override
  int get hashCode => Object.hashAll([id, name, color]);
}

enum InterestColor {
  red,
  green,
  blue,
  yellow;

  static InterestColor fromString(String color) {
    color = color.toLowerCase();
    switch (color) {
      case 'red':
        return InterestColor.red;
      case 'green':
        return InterestColor.green;
      case 'blue':
        return InterestColor.blue;
      case 'yellow':
        return InterestColor.yellow;
      default:
        return InterestColor.red;
        throw Exception('Invalid color: $color');
    }
  }

  Color get deepColor {
    switch (this) {
      case InterestColor.red:
        return Colors.red;
      case InterestColor.green:
        return Colors.green;
      case InterestColor.blue:
        return Colors.blue;
      case InterestColor.yellow:
        return Colors.yellow;
    }
  }

  Color get softColor {
    switch (this) {
      case InterestColor.red:
        return const Color.fromARGB(56, 244, 67, 54);
      case InterestColor.green:
        return const Color.fromARGB(52, 76, 175, 79);
      case InterestColor.blue:
        return const Color.fromARGB(138, 187, 222, 251);
      case InterestColor.yellow:
        return const Color.fromARGB(79, 255, 249, 196);
    }
  }
}

class InterestCategoryModel {
  final String id;
  final String name;
  final List<InterestModel> interests;

  InterestCategoryModel({
    required this.id,
    required this.name,
    required this.interests,
  });

  factory InterestCategoryModel.fromJson(Map<String, dynamic> json) {
    return InterestCategoryModel(
      id: json['_id'],
      name: json['name'],
      interests: json['interests'] == null ? [] : List<InterestModel>.from(
        (json['interests'] as List<dynamic>).map((x) => InterestModel.fromJson(x)),
      ),
    );
  }
}
