import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/core/utils/helpers/format_response_data.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/create_new_password_model.dart';
import 'package:flutter_ursffiver/features/auth/model/forget_password_model.dart';
import 'package:flutter_ursffiver/features/auth/model/signin_model.dart';
import 'package:flutter_ursffiver/features/auth/model/signup_model.dart';
import 'package:flutter_ursffiver/features/auth/model/verify_account_param.dart';
import 'package:flutter_ursffiver/features/auth/model/verify_otp_param.dart';

final class AuthInterfaceImpl extends AuthInterface {
  final AppPigeon appPigeon;
  AuthInterfaceImpl(this.appPigeon);

  // @override
  // Stream<AuthStatus> authStream() {
  //   return appPigeon.authStream();
  // }

  @override
  FutureRequest<Success> signup(SignupRequestParam signupModel) async {
    debugPrint('Signup Model: ${signupModel.toJson()}');
    return await asyncTryCatch(
      tryFunc: () async {
        //call api here
        final response = await appPigeon.post(
          ApiEndpoints.signup,
          data: signupModel.toJson(),
        );

        // parse
        debugPrint('Signup Response: ${response.data}');
        // return
        return Success(
          message: response.data['message'] ?? 'SignUp Success full',
        );
      },
    );
  }

  @override
  FutureRequest<Success> login(LoginRequestParams params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //call api
        final response = await appPigeon.post(
          ApiEndpoints.login,
          data: params.toJson(),
        );
        // parse
        final body = extractBodyData(response);
        debugPrint('Login Response Body: $body');
        final loginResponse = LoginResponse.fromMap(body);
        await appPigeon.saveNewAuth(
          saveAuthParams: SaveNewAuthParams(
            uid: loginResponse.userId,
            accessToken: loginResponse.accessToken,
            refreshToken: loginResponse.refreshToken,
            data: {"userId": loginResponse.userId},
          ),
        );
        // return
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> verifyAccount(VerifyOtpParam param) async {
    debugPrint(param.toJson().toString());
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.verifyCode,
          data: param.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> verifyCode(VerifyOtpParam param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.verifyCode,
          data: param.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> logout() async {
    return await asyncTryCatch(
      tryFunc: () async {
        await appPigeon.logOut();
        return Success(message: "Logout Successfull");
      },
    );
  }

  @override
  FutureRequest<Success> createNewPassword(CreatePasswordModel param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        debugPrint(param.toJson().toString());
        final response = await appPigeon.post(
          ApiEndpoints.createNewPassword,
          data: param.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> forgetpassword(ForgetPasswordModel param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          ApiEndpoints.forgetPassword,
          data: param.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }
}
