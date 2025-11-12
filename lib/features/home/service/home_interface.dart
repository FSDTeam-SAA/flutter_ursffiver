import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/features/home/model/verification_model.dart';

import '../../../core/helpers/typedefs.dart';
import '../model/get_user_suggestion_req_param.dart';
import '../model/user_model.dart';

abstract base class HomeInterface extends BaseRepository {
  FutureRequest<Success<List<UserModel>>> getSuggestions(
    GetUserSuggestionReqParam param,
  );

  FutureRequest<Success> verification(Attachment param);
}
