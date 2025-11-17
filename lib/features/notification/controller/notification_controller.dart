import 'package:flutter/widgets.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:get/get.dart';
import '../interface/notification_interface.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final isLoading = false.obs;
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();


  NotificationController() {
    getAllNotification();
  }

  void toggleExpand(int index) {
    notifications.refresh();
  }

  void markAsReadById(String id) async {
    final idx = notifications.indexWhere((n) => n.id == id);
    if (idx != -1) await markAsRead(idx);
  }

  Future<bool> markAsRead(int index) async {
    if (index < 0 || index >= notifications.length) return false;

    final old = notifications[index];
    if (old.isRead) return false;

    final lr = await Get.find<NotificationInterface>().singleNotificationRead(
      old.id
    );
    return lr.fold(
      (error) {
        return false;
      },
      (success) {
        notifications[index] = old.copyWith(
          isRead: true,
          updatedAt: DateTime.now(),
        );
        notifications.refresh();
        return true;
      },
    );
  }

  Future<void> readAllNotification() async {
    final lr = await Get.find<NotificationInterface>().allNotificationRead();

    lr.fold(
      (error) {
        debugPrint("error >> ${error.toString()}");
      },
      (success) {
        for (var i = 0; i < notifications.length; i++) {
          final n = notifications[i];
          if (!n.isRead) {
            notifications[i] = n.copyWith(
              isRead: true,
              updatedAt: DateTime.now(),
            );
          }
        }
        notifications.refresh();
        update();
      },
    );
  }

  Future<void> getAllNotification() async {
    processStatusNotifier.setLoading();
    isLoading.value = true;

    await Get.find<NotificationInterface>().getAllNotification().then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: processStatusNotifier,
        onError: (error) {
          debugPrint("error >> ${error.toString()}");
          if (error.failure == Failure.forbidden) ();
        },
        onSuccess: (data) {
          notifications.value = data;
          print("data >> ${data.length}");
          notifications.refresh();
          update();
        },
      );
    });

    isLoading.value = false;
  }

  void removeNotification(NotificationModel notif) {
    notifications.removeWhere((n) => n.id == notif.id);
    notifications.refresh();
  }
}
