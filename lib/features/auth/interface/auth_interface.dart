import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/auth/model/create_new_password_model.dart';
import 'package:flutter_ursffiver/features/auth/model/forget_password_model.dart';
import 'package:flutter_ursffiver/features/auth/model/signin_model.dart';
import 'package:flutter_ursffiver/features/auth/model/signup_model.dart';
import 'package:flutter_ursffiver/features/auth/model/verify_otp_param.dart';

abstract base class AuthInterface extends BaseRepository {
  FutureRequest<Success> signup(SignupRequestParam signupModel);

  FutureRequest<Success> logout();

  FutureRequest<Success> login(LoginRequestParams params);

  FutureRequest<Success> verifyAccount(VerifyOtpParam param);

  FutureRequest<Success> verifyCode(VerifyOtpParam param);

  FutureRequest<Success> forgetpassword(ForgetPasswordModel param);

  FutureRequest<Success> createNewPassword(CreatePasswordModel param);
}
