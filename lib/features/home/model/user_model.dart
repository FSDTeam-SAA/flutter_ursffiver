import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
import 'package:flutter_ursffiver/features/home/model/user-address_model.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
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
      ageRange: json['ageRange'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: DateTime.tryParse(json['dateOfBirth'] ?? ''),
      isEmailVerified: json['isEmailVerified'] ?? false,
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      adminVerify: json['adminVerify'] ?? false,
      interests: (json['interest'] as List<dynamic>)
          .map((e) => InterestModel.fromJson(e))
          .toList(),
      active: json['active'] ?? false,
      address: [],
      imagePath: json['imagePath'] as String?,
    );
  }
  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['id'],
  //     firstName: json['firstName'],
  //     lastName: json['lastName'],
  //     ageRange: json['ageRange'],
  //     bio: json['bio'],
  //     email: json['email'],
  //     username: json['username'],
  //     gender: json['gender'],
  //     dateOfBirth: DateTime.parse(json['dateOfBirth']),
  //     isEmailVerified: json['isEmailVerified'],
  //     role: json['role'],
  //     status: json['status'],
  //     adminVerify: json['adminVerify'],
  //     interest: InterestModel.fromJson(json['interest']),
  //     active: json['active'],
  //     address: UseraddressModel.fromJson(json['address']),
  //     createdAt: json['createdAt'],
  //     updatedAt: json['updatedAt'],
  //   );
  // }
}
