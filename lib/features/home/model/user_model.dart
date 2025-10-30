import 'package:flutter_ursffiver/core/common/model/interest_model.dart';
import 'package:flutter_ursffiver/features/home/model/user-address_model.dart';

class UserModel {
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

  UserModel({
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
    );
  }

  factory UserModel.fromJsonForNotification(Map<String, dynamic> json) {
    return UserModel(
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
    );
  }

  // tojson
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fullname': fullname,
      'ageRange': ageRange,
      'bio': bio,
      'email': email,
      'username': username,
      'gender': gender,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'role': role,
      'status': status,
      'adminVerify': adminVerify,
      'interest': interests.map((e) => e.toJson()).toList(),
      'active': active,
      'address': address.map((e) => e.toJson()).toList(),
      'profileImage': imagePath,
    };
  }
}
