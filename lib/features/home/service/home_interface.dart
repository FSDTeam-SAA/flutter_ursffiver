import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';

import '../../../core/helpers/typedefs.dart';
import '../model/user_model.dart';

abstract base class HomeInterface extends BaseRepository {
  FutureRequest<Success<List<UserModel>>> getSuggestions();
}