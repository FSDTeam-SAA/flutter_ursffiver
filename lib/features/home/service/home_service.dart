import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/home/model/set_visibility_req.dart';
import 'package:flutter_ursffiver/features/home/model/status_model.dart';
import 'package:flutter_ursffiver/features/home/model/verification_model.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import '../model/get_user_suggestion_req_param.dart';

base class HomeService extends HomeInterface {
  HomeService({required this.appPigeon});

  final AppPigeon appPigeon;

  @override
  FutureRequest<Success<List<UserProfile>>> getSuggestions(
    GetUserSuggestionReqParam param,
  ) async {
    debugPrint("param: ${param.toMap()}");
    return await asyncTryCatch(
      tryFunc: () async {
        final res = await appPigeon.get(
          ApiEndpoints.allUser,
          //query: param.toMap().isEmpty ? null : param.toMap(),
        );

        debugPrint(res.toString());
        return Success(
          message: extractSuccessMessage(res),
          data: (extractBodyData(res)["users"] as List<dynamic>)
              .map<UserProfile>((e) => UserProfile.fromJson(e))
              .toList(),
        );
      },
    );
  }

  // @override
  // FutureRequest<Success<InterestModel>> getuserbyid(String id) async {
  //   return await asyncTryCatch(
  //     tryFunc: () async {
  //       //api call
  //       final response = await appPigeon.get(ApiEndpoints.getuserbyId(id));

  //       //patse
  //       final data = response.data["data"];

  //       var message = response.data["message"] as String;

  //       //return
  //       return Success(message: message, data: data);
  //     },
  //   );
  // }

  @override
  FutureRequest<Success> verification(Attachment param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final formData = await param.toFormData();

        debugPrint(formData.fields.toString());
        debugPrint(formData.files.toString());
        debugPrint(" Verification Request: ${ApiEndpoints.verification}");

        final response = await appPigeon.post(
          ApiEndpoints.verification,
          data: formData,
        );
        debugPrint(response.data);
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> setVisibility(SetVisibilityReq param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.patch(
          ApiEndpoints.setVisibility,
          data: param.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success> status(StatusModel param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.patch(
          ApiEndpoints.status,
          data: param.toJson(),
        );
        return Success(message: extractSuccessMessage(response));
      },
    );
  }
}
