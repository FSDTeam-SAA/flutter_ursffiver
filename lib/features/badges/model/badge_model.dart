import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
import 'package:flutter_ursffiver/features/home/model/user-address_model.dart';

class UserBadgeModel {
  final String id;
  final String name;
  final String tag;
  final String info;
  final String color;

  UserBadgeModel({
    required this.id,
    required this.name,
    required this.tag,
    required this.info,
    required this.color,
  });

  factory UserBadgeModel.fromJson(Map<String, dynamic> json) {
    return UserBadgeModel(
      id: json['_id'],
      name: json['name'],
      tag: json['tag'],
      info: json['info'],
      color: json['color'],
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
  final List<InterestModel> interests;
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
          : (json['interest'] as List<dynamic>)
                .map((e) => InterestModel.fromJson(e))
                .toList(),
      active: json['active'] ?? false,
      address: [],
      imagePath: json['profileImage'] as String?,
      badges: json['badge'] == null
          ? []
          : (json['badge'] as List<dynamic>)
                .map((e) => UserBadgeModel.fromJson(e))
                .toList(),
    );
  }

  factory UserBadgesModel.fromJsonForNotification(Map<String, dynamic> json) {
    return UserBadgesModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullname: json['fullName'],
      ageRange: json['ageRange'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: null,
      isEmailVerified: json['isEmailVerified'] ?? false,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      adminVerify: json['adminVerify'] ?? false,
      interests: [],
      active: json['active'] ?? false,
      address: [],
      imagePath: json['profileImage'] as String?,
      badges: [],
    );
  }
}
