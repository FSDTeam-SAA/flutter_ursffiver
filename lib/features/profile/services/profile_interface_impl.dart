import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/change_password_model.dart';

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
}
