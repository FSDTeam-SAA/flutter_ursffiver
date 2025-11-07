import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/api_handler/trycatch.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/notification/model/notification_model.dart';

abstract base class NotificationInterface extends BaseRepository {
  FutureRequest<Success<List<NotificationModel>>> getAllNotification();

  FutureRequest<Success> singleNotificationRead(String id);

  FutureRequest<Success> allNotificationRead();

  Stream<NotificationModel> notificationStream();
}
