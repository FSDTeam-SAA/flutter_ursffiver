import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/home/model/user_interest_model.dart';

class UserProfile {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? email;
  final String? gender;
  final String? ageRange;
  final String? bio;
  final String? image;
  final bool? adminVerify;
  final List<BadgeModel>? badge;
  final List<UserInterestModel>? interest;

  UserProfile({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.gender,
    this.ageRange,
    this.bio,
    this.image,
    this.adminVerify,
    this.badge,
    this.interest,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      username: json['username'],
      email: json['email'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      bio: json['bio'],
      image: json['image'],
      adminVerify: json['adminVerify'],
      badge: json['badge'] == null
          ? []
          : List<BadgeModel>.from(
              json['badge']?.map((x) => BadgeModel.fromJson(x)) ?? [],
            ),

      interest: json['interest'] == null
          ? []
          : List<UserInterestModel>.from(
              json['interest']?.map((x) => UserInterestModel.fromJson(x)) ?? [],
            ),
    );
  }
}
