import 'package:flutter/widgets.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/core/utils/helpers/format_response_data.dart';
import 'package:flutter_ursffiver/core/common/interface/interest_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';

import '../../../features/auth/model/interest_model.dart';

final class InterestInterfaceImpl extends InterestInterface {
  final AppPigeon appPigeon;

  InterestInterfaceImpl({required this.appPigeon});

  @override

  FutureRequest<Success<List<InterestCategoryModel>>> getAllInterests() async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(ApiEndpoints.getInterests);

        //patse
        final data = response.data["data"] as List<dynamic>;
        debugPrint(response.data.toString());
        final List<InterestCategoryModel> interests = [];

        for (int i = 0; i < data.length; i++) {
          debugPrint("Interest: ${data[i]}");
          interests.add(InterestCategoryModel.fromJson(data[i]));
        }

        //return
        return Success(
          message: extractSuccessMessage(response),
          data: interests,
        );
      },
    );
  }

  @override
  FutureRequest<Success> createCustomInterest(CreateCustomInterestReqParam param) {
    // TODO: implement createCustomInterest
    throw UnimplementedError();
  }
}
