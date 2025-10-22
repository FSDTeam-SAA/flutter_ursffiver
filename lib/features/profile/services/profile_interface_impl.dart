import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/change_password_model.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_avatar_param.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

final class ProfileInterfaceImpl extends ProfileInterface {
  ProfileInterfaceImpl({required this.appPigeon});
  final AppPigeon appPigeon;

  @override
  FutureRequest<Success> changePassword(ChangePasswordModel params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        debugPrint("ChangePassword Request: ${params.toJson()}");
        final response = await appPigeon.post(
          ApiEndpoints.changePassword,
          data: params.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success<UserProfile>> getUserProfilebyId(String id) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //response
        final response = await appPigeon.get(ApiEndpoints.getuserbyId(id));
        debugPrint(response.data.toString());
        //parse
        final data = response.data["data"] as Map<String, dynamic>;
        final UserProfile userProfile = UserProfile.fromJson(data);

        var message = response.data["message"] as String;

        //return

        return Success(message: message, data: userProfile);
      },
    );
  }

  @override
  FutureRequest<Success> updateProfile(UpdateProfileModel params) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  FutureRequest<Success> uploadProfileAvatar(UploadProfileAvatarParam params) {
    // TODO: implement uploadProfileAvatar
    throw UnimplementedError();
  }
}
