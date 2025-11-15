import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/cache/smart_network_image.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controllerx.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return DateFormat('hh:mm a').format(date);
    } else {
      return DateFormat('MMM dd, hh:mm a').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: TextButton(
                onPressed: controller.readAllNotification,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Read all",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return const Center(child: Text("No notifications found"));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            return Obx(() {
              final data = controller.notifications[index];
              return NotificationItem(
                data: data,
                timeText: _formatDateTime(data.createdAt),
                onExpandToggle: () async {
                  await controller.markAsRead(index);
                  controller.toggleExpand(index);
                },
              );
            });
          },
        );
      }),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final NotificationModel data;
  final VoidCallback onExpandToggle;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final String timeText;

  const NotificationItem({
    super.key,
    required this.data,
    required this.onExpandToggle,
    this.onAccept,
    this.onReject,
    required this.timeText,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool minimized = false;
  bool isExpanded = false;

  void _handleTap() {
    setState(() {
      isExpanded = !isExpanded;
    });
    widget.onExpandToggle();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    if (data.type == NotificationType.messageRequest) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: !minimized ? 130 : 0,

        // width: !minimized ? null : 0,
        constraints: BoxConstraints(maxHeight: !minimized ? 100 : 0),
        child: GestureDetector(
          onTap: _handleTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: data.isRead ? Colors.white : Colors.blue.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 1.5),
                  ),
                  child: ClipOval(
                    child: SmartNetworkImage(
                      imageUrl: data.user.image,
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.title,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              timeago.format(data.createdAt),
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Flexible(
                        child: LayoutBuilder(
                          builder: (contextx, constraintsx) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: constraintsx.maxWidth - 100,
                                  child: Text(
                                    data.message,
                                    maxLines: isExpanded ? null : 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                    overflow: isExpanded
                                        ? TextOverflow.visible
                                        : TextOverflow.ellipsis,
                                  ),
                                ),
                                Flexible(
                                  child: SizedBox(
                                    // width: ,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 0,
                                            minHeight: 0,
                                          ),
                                          style: ButtonStyle(
                                            minimumSize: WidgetStatePropertyAll(
                                              Size.zero,
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 22,
                                          ),
                                          onPressed: () async {
                                            debugPrint(
                                              "Reject chat...${data.chatId}",
                                            );
                                            await Get.find<
                                                  InboxChatDataProvider
                                                >()
                                                .rejectChat(data.chatId ?? "")
                                                .then((value) {
                                                  setState(() {
                                                    minimized = true;
                                                  });
                                                });
                                            Get.snackbar(
                                              "Success",
                                              "Chat request rejected!",
                                            );
                                          },
                                        ),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(
                                            minWidth: 0,
                                            minHeight: 0,
                                          ),
                                          style: ButtonStyle(
                                            minimumSize: WidgetStatePropertyAll(
                                              Size.zero,
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                            size: 22,
                                          ),
                                          onPressed: () async {
                                            debugPrint(
                                              "Accepting chat...${data.chatId}",
                                            );
                                            await Get.find<
                                                  InboxChatDataProvider
                                                >()
                                                .acceptChat(data.chatId ?? "")
                                                .then((value) {
                                                  setState(() {
                                                    minimized = true;
                                                  });
                                                });
                                            Get.snackbar(
                                              "Success",
                                              "Chat request accepted!",
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (data.type == NotificationType.accepted) {
      return GestureDetector(
        onTap: _handleTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: data.isRead ? Colors.white : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: ClipOval(
                  child: SmartNetworkImage(
                    imageUrl: data.user.image,
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          // data.title,
                          data.title,
                          maxLines: 5,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 20),
                        Text(
                          timeago.format(data.createdAt),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.message,
                      maxLines: isExpanded ? null : 1,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {}
    return GestureDetector(onTap: _handleTap);
  }
}
