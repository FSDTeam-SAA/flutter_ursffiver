import 'package:flutter/widgets.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/core/utils/helpers/format_response_data.dart';
import 'package:flutter_ursffiver/features/notification/interface/notification_interface.dart';
import 'package:flutter_ursffiver/features/notification/model/notification_model.dart';

final class NotificationInterfaceImpl extends NotificationInterface {
  final AppPigeon appPigeon;

  NotificationInterfaceImpl({required this.appPigeon});

  @override
  FutureRequest<Success> singleNotificationRead(String id) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        debugPrint(
          " ReadAllNotifications Request: ${ApiEndpoints.markNotificationAsRead(notificationId: id)}",
        );

        final response = await appPigeon.patch(
          ApiEndpoints.markNotificationAsRead(notificationId: id),
        );

        //patse
        final message = response.data["message"] as String;

        //return
        return Success(message: message);
      },
    );
  }

  @override
  FutureRequest<Success> allNotificationRead() async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.patch(
          ApiEndpoints.readAllNotifications,
        );
        //print Api endpoint
        debugPrint(
          " ReadAllNotifications Request: ${ApiEndpoints.readAllNotifications}",
        );
        //patse
        final message = response.data["message"] as String;
        debugPrint(message);
        //return
        return Success(message: message);
      },
    );
  }

  @override
  FutureRequest<Success<List<NotificationModel>>> getAllNotification() async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(ApiEndpoints.getAllNotifications);
        debugPrint(response.data.toString());
        //patse
        final data = response.data["data"] as List<dynamic>;
        debugPrint(response.data.toString());
        final List<NotificationModel> notifications = [];

        for (int i = 0; i < data.length; i++) {
          tryCatch(
            tryFunc: () {
              notifications.add(NotificationModel.fromJson(data[i]));
            },
          );
        }

        //return
        return Success(
          message: extractSuccessMessage(response),
          data: notifications,
        );
      },
    );
  }

  @override
  Stream<NotificationModel> notificationStream() {
    return appPigeon
        .listen("notificationUpdate")
        .map((event) => NotificationModel.fromJson(event));
  }
}
