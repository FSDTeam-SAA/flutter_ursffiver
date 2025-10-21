import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/profile/model/change_password_model.dart';

abstract base class ProfileInterface extends BaseRepository {
  FutureRequest<Success> changePassword(ChangePasswordModel params);
}