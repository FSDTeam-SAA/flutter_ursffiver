import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';

final class BadgesInterfaceImpl extends BadgesInterface {
  BadgesInterfaceImpl({required this.appPigeon});
  final AppPigeon appPigeon;

  @override
  FutureRequest<Success<UserBadgesModel>> getuserbyid(String id) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(ApiEndpoints.getuserbyId(id));

        //patse
        final data = response.data["data"];

        var message = response.data["message"] as String;

        //return
        return Success(message: message, data: data);
      },
    );
  }
}
