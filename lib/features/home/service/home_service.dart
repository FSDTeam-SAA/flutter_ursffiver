import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';

import '../model/get_user_suggestion_req_param.dart';

base class HomeService extends HomeInterface {
  HomeService({required this.appPigeon});

  final AppPigeon appPigeon;

  @override
  FutureRequest<Success<List<UserModel>>> getSuggestions(
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
              .map<UserModel>((e) => UserModel.fromJson(e))
              .toList(),
        );
      },
    );
  }
}
