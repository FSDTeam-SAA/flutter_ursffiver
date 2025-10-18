import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/notification_controller.dart';
import '../model/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

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
        title: const Text(
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
                //onPressed: controller.readAllNotification,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                ),
                onPressed: () {},
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
            final data = controller.notifications[index];
            return NotificationItem(
              data: data,
              // onExpandToggle: () => controller.markAsRead(data),
              // onAccept: () => controller.acceptMessageRequest(data),
              // onReject: () => controller.rejectMessageRequest(data),
              timeText: _formatDateTime(data.createdAt),
              onExpandToggle: () {
                controller.toggleExpand(index);
                controller.markAsRead(index);
              },
            );
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
  bool isExpanded = false;

  void _handleTap() {
    setState(() => isExpanded = !isExpanded);
    widget.onExpandToggle();
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    if (data.type == "message request") {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/images/profilepic.png"),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  //overflow: TextOverflow.ellipsis,
                ),
                  ],
                ),
                Text(
                  data.message,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  maxLines: 2,
                  //overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  data.message,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            

            const SizedBox(width: 8),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.close, color: Colors.red, size: 22),
                  onPressed: widget.onReject,
                ),
                const SizedBox(width: 8),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.check, color: Colors.green, size: 22),
                  onPressed: widget.onAccept,
                ),
              ],
            ),
          ],

        ),
      );

      // return Container(
      //   margin: const EdgeInsets.only(bottom: 12),
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(12),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.05),
      //         blurRadius: 4,
      //         offset: const Offset(0, 2),
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       const CircleAvatar(
      //         radius: 20,
      //         backgroundImage: AssetImage("assets/images/profilepic.png"),
      //       ),
      //       const SizedBox(width: 10),
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Expanded(
      //                   child: Text(
      //                     data.title,
      //                     style: const TextStyle(
      //                       fontWeight: FontWeight.w600,
      //                       fontSize: 15,
      //                       color: Colors.black,
      //                     ),
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                 ),
      //                 Text(
      //                   widget.timeText,
      //                   style: const TextStyle(
      //                     fontSize: 12,
      //                     color: Colors.grey,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             const SizedBox(height: 2),
      //             Text(
      //               data.message,
      //               style: const TextStyle(fontSize: 13, color: Colors.black54),
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //             ),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(width: 5),
      //       Row(
      //         children: [
      //           IconButton(
      //             icon: const Icon(Icons.close, color: Colors.red, size: 22),
      //             onPressed: widget.onReject,
      //           ),
      //           IconButton(
      //             icon: const Icon(Icons.check, color: Colors.green, size: 22),
      //             onPressed: widget.onAccept,
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // );
    } else if (data.type == "message") {
      return GestureDetector(
        onTap: _handleTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: data.isRead ? Colors.white : Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/profilepic.png"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.type.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${data.createdAt.hour}:${data.createdAt.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.message,
                      maxLines: isExpanded ? null : 1,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                onPressed: _handleTap,
              ),
            ],
          ),
        ),
      );
    } else {}
    return GestureDetector(
      onTap: _handleTap,
      // child: Container(
      //   margin: const EdgeInsets.only(bottom: 12),
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      //   decoration: BoxDecoration(
      //     color: data.isRead ? Colors.white : Colors.blue.shade50,
      //     borderRadius: BorderRadius.circular(12),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.1),
      //         blurRadius: 6,
      //         offset: const Offset(0, 3),
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     children: [
      //       const CircleAvatar(
      //         radius: 22,
      //         backgroundImage: AssetImage("assets/images/profilepic.png"),
      //       ),
      //       const SizedBox(width: 12),
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(
      //                   data.title,
      //                   style: const TextStyle(
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 4),
      //             Column(
      //               children: [
      //                 Text(
      //                   widget.timeText,
      //                   style: const TextStyle(
      //                     fontSize: 12,
      //                     color: Colors.grey,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             const SizedBox(height: 4),
      //             // Text(
      //             //   data.message,
      //             //   maxLines: isExpanded ? null : 1,
      //             //   overflow: isExpanded
      //             //       ? TextOverflow.visible
      //             //       : TextOverflow.ellipsis,
      //             //   style: const TextStyle(fontSize: 13, color: Colors.black87),
      //             // ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
