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
    }
  }

  Color get deepColor {
    switch (this) {
      case InterestColor.red:
        return Color(0xFFF2415A);
      case InterestColor.green:
        return Color(0xFF27BE69);
      case InterestColor.blue:
        return Color(0xFF3F42EE);
      case InterestColor.yellow:
        return Color(0xFFFFBF0F);
    }
  }

  Color get softColor {
    switch (this) {
      case InterestColor.red:
        return const Color(0xFFFEECEE);
      case InterestColor.green:
        return const Color(0xFFE6FAEE);
      case InterestColor.blue:
        return const Color(0xFFECEDFD);
      case InterestColor.yellow:
        return const Color(0xFFFFF8E5);
    }
  }
}
class CreateCustomInterestParam {
  final String name;
  final InterestColor color;

  CreateCustomInterestParam({
    required this.name,
    required this.color,
  });

  factory CreateCustomInterestParam.fromJson(Map<String, dynamic> json) {
    return CreateCustomInterestParam(
      name: json['name'],
      color: InterestColor.fromString(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color.name,
    };
  }

  CreateCustomInterestParam copyWith({
    String? name,
    InterestColor? color,
  }) {
    return CreateCustomInterestParam(
      name: name ?? this.name,
      color: color ?? this.color,
    );
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

  InterestCategoryModel copyWith({
    String? id,
    String? name,
    List<InterestModel>? interests,
  }) {
    return InterestCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      interests: interests ?? this.interests,
    );
  }
}
