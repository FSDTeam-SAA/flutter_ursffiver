import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileModel {
  final String id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? username;
  String? email;
  String? gender;
  String? ageRange;
  String? bio;
  File? profileImage;

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
      'userId': id
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
