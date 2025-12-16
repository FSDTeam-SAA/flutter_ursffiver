import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';

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
  final List<String>? interests;
  final List<CreateCustomInterestReqParam>? customInterests;

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
    this.interests,
    this.customInterests,
  });

  Map<String, dynamic> toJson() {
    debugPrint("custom interests len: ${customInterests?.length}");
    return {
      "userId": id,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (fullName != null) "fullName": fullName,
      if (username != null) "username": username,
      if (email != null) "email": email,
      if (gender != null) "gender": gender,
      if (ageRange != null) "ageRange": ageRange,
      if (bio != null) "bio": bio,

      /// 🔥 VERY IMPORTANT — backend expects: interest: ["id","id",...]
      if(interests != null) "interests": interests,
      if(customInterests != null) "customInterests":
          customInterests?.map((e) => e.toJson()).toList(),
    };
  }

  Future<FormData> toFormData() async {
    final form = FormData.fromMap(toJson());
    debugPrint("UpdateProfileModel toFormData: ${toJson()}");
    if (profileImage != null) {
      form.files.add(
        MapEntry(
          "profileImage",
          await MultipartFile.fromFile(profileImage!.path),
        ),
      );
    }

    return form;
  }
}
