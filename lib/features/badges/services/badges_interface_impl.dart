import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/badges/model/award_badges_to_user.dart';
import 'package:flutter_ursffiver/features/badges/model/get_my_badges_request_param.dart';
import 'package:flutter_ursffiver/features/badges/model/get_my_badges_response_model.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';

final class BadgesInterfaceImpl extends BadgesInterface {
  BadgesInterfaceImpl({required this.appPigeon});
  final AppPigeon appPigeon;

  @override
  FutureRequest<Success> awardBadgestoUser({required AwardBadgesToUser param}) async {
    throw UnimplementedError();
    // return await asyncTryCatch(tryFunc: () {

    // }) 
  }

  @override
  FutureRequest<Success<GetMyBadgesResponseModel>> getMyBadges({
    required GetmyBadgesRequestParam param,
  }) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get(ApiEndpoints.getMyBadges);

        final data = response.data["data"];
        var message = response.data["message"] as String;
        GetMyBadgesResponseModel parsedata = GetMyBadgesResponseModel.fromJson(
          data,
        );
        return Success(message: message, data: parsedata);
      },
    );
  }
}
