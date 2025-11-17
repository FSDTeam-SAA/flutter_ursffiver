import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/home/model/interest_model.dart';

import '../../auth/model/interest_model.dart';

class UserProfile {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? gender;
  final String? ageRange;
  final String? bio;
  final DateTime? dateOfBirth;
  final String? image;
  final bool? adminVerify;
  final String? status;
  final bool active;
  final bool isEmailVerified;
  final List<BadgeModel> badges;
  final List<InterestModel> interests;
  final List<InterestModel> customInterests;

  UserProfile({
    required this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.gender,
    this.ageRange,
    this.bio,
    this.image,
    this.adminVerify,
    required this.active,
    required this.isEmailVerified,
    required this.badges,
    required this.interests,
    required this.customInterests,
    this.dateOfBirth,
    this.status,

  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['username'],
      email: json['email'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      bio: json['bio'],
      image: json['profileImage'],
      adminVerify: json['adminVerify'],
      status: json['status'],
      active: json['active'],
      isEmailVerified: json['isEmailVerified'] as bool,
      dateOfBirth: DateTime.tryParse(json['dateOfBirth'] ?? '')?.toLocal(),
      badges: json['badge'] == null
          ? []
          : List<BadgeModel>.from(
              json['badge']?.map((x) => BadgeModel.fromJson(x)) ?? [],
            ),

      interests: json['interest'] == null
          ? []
          : List<InterestModel>.from(
              json['interest']?.map((x) => InterestModel.fromJson(x)) ?? [],
            ),
      customInterests: json['customInterests'] == null
          ? []
          : List<InterestModel>.from(
              json['customInterests']?.map((x) => InterestModel.fromJson(x)) ?? [],
            ),
    );
  }

  factory UserProfile.fromJsonForNotification(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      ageRange: json['ageRange'] ?? '',
      bio: json['bio'] ?? '',
      email: json['email'] ?? '',
      userName: json['username'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: null,
      isEmailVerified: json['isEmailVerified'] ?? false,
      status: json['status'] ?? '',
      adminVerify: json['adminVerify'] ?? false,
      interests: [],
      active: json['active'] ?? false,
      image: json['profileImage'] as String?, 
      badges: [],
      customInterests: []
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'username': userName,
    'email': email,
    'gender': gender,
    'ageRange': ageRange,
    'bio': bio,
    'profileImage': image,
    'adminVerify': adminVerify,
    'status': status,
    'dateOfBirth': dateOfBirth?.toUtc().toIso8601String(),
    'badge': badges.map((x) => x.toJson()).toList(),
    'interest': interests.map((x) => x.toJson()).toList(),
    'active': active,
    'isEmailVerified': isEmailVerified
  };
}
