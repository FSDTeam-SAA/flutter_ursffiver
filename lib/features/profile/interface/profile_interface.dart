import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/profile/model/change_password_model.dart';
import 'package:flutter_ursffiver/features/profile/model/report_model.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_avatar_param.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';

abstract base class ProfileInterface extends BaseRepository {
  FutureRequest<Success> changePassword(ChangePasswordModel params);

  FutureRequest<Success<UserProfile>> getUserProfilebyId(String id);

  FutureRequest<Success> updateProfile(UpdateProfileModel params);

  FutureRequest<Success> uploadProfileAvatar(UploadProfileAvatarParam params);

  FutureRequest<Success> deleteProfileAvatar(String userId);

  FutureRequest<Success> reportandProblem(ReportModel params);

}