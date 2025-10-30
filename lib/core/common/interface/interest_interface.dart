import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/base_repository.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';
import 'package:flutter_ursffiver/core/common/model/interest_model.dart';

abstract base class InterestInterface extends BaseRepository {
  FutureRequest<Success<List<InterestCategoryModel>>> getAllInterests();

  FutureRequest<Success> createCustomInterest(CreateCustomInterestReqParam param);
}