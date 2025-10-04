import 'package:flutter_ursffiver/features/notification/model/notification_model.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[
    NotificationModel(
      title: 'Notification Title',
      subtitle: 'Here\'s notification text.',
      time: '34m ago',
      isRead: false,
    ),
    NotificationModel(
      title: 'Notification Title',
      subtitle: 'Here\'s notification text.',
      time: '34m ago',
      isRead: false,
    ),
    NotificationModel(
      title: 'Notification Title',
      subtitle: 'Here\'s notification text.',
      time: '34m ago',
      isRead: false,
    ),
    NotificationModel(
      title: 'Ureusus',
      subtitle: 'wants to start a chat with you',
      time: '1d ago',
      isRead: true,
      hasAvatar: true,
      hasActions: true,
    ),
    NotificationModel(
      title: 'Notification Title',
      subtitle: 'Here\'s notification text.',
      time: '34m ago',
      isRead: false,
    ),
    NotificationModel(
      title: 'Notification Title',
      subtitle: 'Here\'s notification text.',
      time: '34m ago',
      isRead: true,
    ),
  ].obs;

  void markAllAsRead() {
    for (var n in notifications) {
      n.isRead = true;
    }
    notifications.refresh();
  }

  void markAsRead(NotificationModel notif) {
    notif.isRead = true;
    notifications.refresh();
  }

  void removeNotification(NotificationModel notif) {
    notifications.remove(notif);
  }
}
