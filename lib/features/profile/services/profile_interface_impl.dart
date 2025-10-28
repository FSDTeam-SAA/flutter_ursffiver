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

    debugPrint("GetUserProfilebyId Request: $id");
    debugPrint("GetUserProfilebyId Request: $Uri");
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get(ApiEndpoints.getuserbyId(id));
        debugPrint(response.data.toString());
        final data = response.data["data"] as Map<String, dynamic>;
        final UserProfile userProfile = UserProfile.fromJson(data);
        var message = response.data["message"] as String;
        return Success(message: message, data: userProfile);
      },
    );
  }

  @override
  FutureRequest<Success> updateProfile(UpdateProfileModel params) async {
  return await asyncTryCatch(
    tryFunc: () async {
      final body = params.toJson();
      body['userId'] = params.id;

      debugPrint("UpdateProfile Request: $body");

      final response = await appPigeon.patch(
        ApiEndpoints.editProfile,
        data: body,
      );

      final message = extractSuccessMessage(response);
      return Success(message: message);
    },
  );
}

  
  @override
  FutureRequest<Success> deleteProfileAvatar(String userId) {
    // TODO: implement deleteProfileAvatar
    throw UnimplementedError();
  }
  
  @override
  FutureRequest<Success> uploadProfileAvatar(UploadProfileAvatarParam params) {
    // TODO: implement uploadProfileAvatar
    throw UnimplementedError();
  }

  // @override
  // FutureRequest<Success> uploadProfileAvatar(UploadProfileAvatarParam params) async {
  //   return await asyncTryCatch(
  //     tryFunc: () async {
  //       final formData = await params.toFormData(); // returns FormData
  //       // Some backends require user id in path or query — here assume endpoint includes user id
  //       final response = await appPigeon.post(
  //         ApiEndpoints.uploadProfileAvatar(params.userId),
  //         data: formData,
  //         // Ensure the appPigeon/Dio is configured to send multipart/form-data
  //       );

  //       final message = extractSuccessMessage(response);
  //       return Success(message: message);
  //     },
  //   );
  // }

  // @override
  // FutureRequest<Success> deleteProfileAvatar(String userId) async {
  //   return await asyncTryCatch(
  //     tryFunc: () async {
  //       // If backend expects DELETE with path param
  //       final response = await appPigeon.delete(
  //         ApiEndpoints.deleteProfileAvatar(userId),
  //       );

  //       final message = extractSuccessMessage(response);
  //       return Success(message: message);
  //     },
  //   );
  // }
}
