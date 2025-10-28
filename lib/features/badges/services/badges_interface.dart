import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';

abstract base class BadgesInterface extends BaseRepository {
  FutureRequest<Success<UserBadgesModel>> getuserbyid(String id);
}
