import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/features/home/model/verification_model.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import 'package:flutter_ursffiver/core/api_handler/base_repository.dart';

import '../../../core/helpers/typedefs.dart';
import '../model/get_user_suggestion_req_param.dart';

abstract base class HomeInterface extends BaseRepository {
  FutureRequest<Success<List<UserProfile>>> getSuggestions(
    GetUserSuggestionReqParam param,
  );

  FutureRequest<Success> verification(Attachment param);
}
