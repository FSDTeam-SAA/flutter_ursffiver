// import 'package:flutter/cupertino.dart';
// import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
// import 'package:flutter_ursffiver/features/home/model/user-address_model.dart';
// import 'package:flutter_ursffiver/features/home/model/user_interest_model.dart';

// class UserBadgeModel {
//   final String id;
//   final String name;
//   final String tag;
//   final String info;
//   final String color;

//   UserBadgeModel({
//     required this.id,
//     required this.name,
//     required this.tag,
//     required this.info,
//     required this.color,
//   });

//   factory UserBadgeModel.fromJson(Map<String, dynamic> json) {
//     return UserBadgeModel(
//       id: json['_id'],
//       name: json['name'],
//       tag: json['tag'],
//       info: json['info'],
//       color: json['color'],
//     );
//   }
// }

// class UserBadgesModel {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String fullname;
//   final String ageRange;
//   final String bio;
//   final String email;
//   final String username;
//   final String gender;
//   final DateTime? dateOfBirth;
//   final bool isEmailVerified;
//   final String role;
//   final String status;
//   final bool adminVerify;
//   final List<UserInterestModel> interests;
//   final bool active;
//   final List<UserAddressModel> address;
//   final String? imagePath;
//   final List<UserBadgeModel> badges;

//   UserBadgesModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.fullname,
//     required this.ageRange,
//     required this.bio,
//     required this.email,
//     required this.username,
//     required this.gender,
//     required this.dateOfBirth,
//     required this.isEmailVerified,
//     required this.role,
//     required this.status,
//     required this.adminVerify,
//     required this.interests,
//     required this.active,
//     required this.address,
//     this.imagePath,
//     required this.badges,
//   });

//   factory UserBadgesModel.fromJson(Map<String, dynamic> json) {
//     debugPrint("user badges model json : $json['firstName']");
//     return UserBadgesModel(
//       id: json['_id'] ?? '',
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       fullname: json['fullname'] ?? '',
//       ageRange: json['ageRange'] ?? '',
//       bio: json['bio'] ?? '',
//       email: json['email'] ?? '',
//       username: json['username'] ?? '',
//       gender: json['gender'] ?? '',
//       dateOfBirth: json['dateOfBirth'] == null
//           ? null
//           : DateTime.tryParse(json['dateOfBirth'] ?? ''),
//       isEmailVerified: json['isEmailVerified'] ?? false,
//       role: json['role'] ?? '',
//       status: json['status'] ?? '',
//       adminVerify: json['adminVerify'] ?? false,
//       interests: json['interest'] == null
//           ? []
//           : (json['interest'] as List)
//                 .map((e) => UserInterestModel.fromJson(e))
//                 .toList(),
//       active: json['active'] ?? false,
//       address: [],
//       imagePath: json['profileImage'] as String?,
//       badges: json['badge'] == null
//           ? []
//           : (json['badge'] as List<dynamic>)
//                 .map((e) => UserBadgeModel.fromJson(e))
//                 .toList(),
//     );
//   }

//   // factory UserBadgesModel.fromJsonForNotification(Map<String, dynamic> json) {
//   //   return UserBadgesModel(
//   //     id: json['_id'] ?? '',
//   //     firstName: json['firstName'] ?? '',
//   //     lastName: json['lastName'] ?? '',
//   //     fullname: json['fullName'],
//   //     ageRange: json['ageRange'] ?? '',
//   //     bio: json['bio'] ?? '',
//   //     email: json['email'] ?? '',
//   //     username: json['username'] ?? '',
//   //     gender: json['gender'] ?? '',
//   //     dateOfBirth: null,
//   //     isEmailVerified: json['isEmailVerified'] ?? false,
//   //     role: json['role'] ?? '',
//   //     status: json['status'] ?? '',
//   //     adminVerify: json['adminVerify'] ?? false,
//   //     interests: [],
//   //     active: json['active'] ?? false,
//   //     address: [],
//   //     imagePath: json['profileImage'] as String?,
//   //     badges: [],
//   //   );
//   // }
// }


import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/home/model/user-address_model.dart';
import 'package:flutter_ursffiver/features/home/model/user_interest_model.dart';

class UserBadgeModel {
  final String id;
  final String name;
  final String tag;
  final String info;
  final String color; // color as string from API (e.g., "#FF0000" or "red")

  UserBadgeModel({
    required this.id,
    required this.name,
    required this.tag,
    required this.info,
    required this.color,
  });

  /// Convert color string to Flutter [Color]
  Color get badgeColor {
    // If color is a hex value like "#RRGGBB"
    if (color.startsWith('#')) {
      try {
        return Color(int.parse(color.substring(1), radix: 16) + 0xFF000000);
      } catch (_) {
        return Colors.grey; // fallback
      }
    }

    // If color is a named color (e.g., "red", "blue", etc.)
    switch (color.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  factory UserBadgeModel.fromJson(Map<String, dynamic> json) {
    return UserBadgeModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      info: json['info'] ?? '',
      color: json['color'] ?? '#9E9E9E', // fallback gray
    );
  }
}

class UserBadgesModel {
  final String id;
  final String firstName;
  final String lastName;
  final String fullname;
  final String ageRange;
  final String bio;
  final String email;
  final String username;
  final String gender;
  final DateTime? dateOfBirth;
  final bool isEmailVerified;
  final String role;
  final String status;
  final bool adminVerify;
  final List<UserInterestModel> interests;
  final bool active;
  final List<UserAddressModel> address;
  final String? imagePath;
  final List<UserBadgeModel> badges;

  UserBadgesModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullname,
    required this.ageRange,
    required this.bio,
    required this.email,
    required this.username,
    required this.gender,
    required this.dateOfBirth,
    required this.isEmailVerified,
    required this.role,
    required this.status,
    required this.adminVerify,
    required this.interests,
    required this.active,
    required this.address,
    this.imagePath,
    required this.badges,
  });

  factory UserBadgesModel.fromJson(Map<String, dynamic> json) {
    debugPrint("user badges model json : ${json['firstName']}");

    return UserBadgesModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullname: json['fullname'] ?? '',
      ageRange: json['ageRange'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.tryParse(json['dateOfBirth'] ?? ''),
      isEmailVerified: json['isEmailVerified'] ?? false,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      adminVerify: json['adminVerify'] ?? false,
      interests: json['interest'] == null
          ? []
          : (json['interest'] as List)
              .map((e) => UserInterestModel.fromJson(e))
              .toList(),
      active: json['active'] ?? false,
      address: [],
      imagePath: json['profileImage'] as String?,
      badges: json['badge'] == null
          ? []
          : (json['badge'] as List)
              .map((e) => UserBadgeModel.fromJson(e))
              .toList(),
    );
  }
}
