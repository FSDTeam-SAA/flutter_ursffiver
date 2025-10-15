import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/notification/controller/notification_controller.dart';
import 'package:flutter_ursffiver/features/notification/model/notification_model.dart';
import 'package:get/get.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: controller.markAllAsRead,
            child: const Text(
              'Read all',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];
            return _buildNotificationCard(notif, controller, context);
          },
        );
      }),
    );
  }

  Widget _buildNotificationCard(
      NotificationModel notif, NotificationController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => controller.markAsRead(notif),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notif.isRead ? AppColors.white : AppColors.appber,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (notif.hasAvatar)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              )
            else if (!notif.isRead)
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  color: AppColors.primarybutton,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(width: 20),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notif.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: notif.isRead ? Colors.black87 : Colors.black,
                        ),
                      ),
                      Text(
                        notif.time,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif.subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            if (notif.hasActions) ...[
              const SizedBox(width: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.removeNotification(notif),
                    child: const Icon(Icons.close, color: Colors.red, size: 20),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      controller.markAsRead(notif);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatScreen(
                            contactName: 'Ursusus',
                            avatarUrl:
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
                          ),
                        ),
                      );
                    },
                    child:
                        const Icon(Icons.check, color: Colors.green, size: 20),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
