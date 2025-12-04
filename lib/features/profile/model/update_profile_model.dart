import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
import 'package:flutter_ursffiver/features/profile/model/interests_model.dart';

class UpdateProfileModel {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? username;
  final String? email;
  final String? gender;
  final String? ageRange;
  final String? bio;
  final File? profileImage;
  final List<InterestModel> interests;

  UpdateProfileModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.username,
    this.email,
    this.gender,
    this.ageRange,
    this.bio,
    this.profileImage,
    required this.interests ,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      username: json['username'],
      email: json['email'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      interests: json['interest'] == null
          ? []
          : List<InterestModel>.from(
              json['interest']?.map((x) => InterestModel.fromJson(x)) ?? [],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (fullName != null) 'fullName': fullName,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (gender != null) 'gender': gender,
      if (ageRange != null) 'ageRange': ageRange,
      if (bio != null) 'bio': bio,
      if (profileImage != null) 'profileImage': profileImage,
      'userId': id,
    };
  }

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap(toJson());
    formData.files.add(
      MapEntry(
        'profileImage',
        await MultipartFile.fromFile(profileImage!.path),
      ),
    );
    return formData;
  }
}
