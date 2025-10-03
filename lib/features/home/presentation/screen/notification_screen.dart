// import 'package:flutter/material.dart';
// import '../../../../core/theme/app_colors.dart';

// class NotificationModel {
//   final String title;
//   final String subtitle;
//   final String time;
//   bool isRead;
//   final bool hasAvatar;
//   final bool hasActions;

//   NotificationModel({
//     required this.title,
//     required this.subtitle,
//     required this.time,
//     this.isRead = false,
//     this.hasAvatar = false,
//     this.hasActions = false,
//   });
// }

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   // sample notifications
//   List<NotificationModel> notifications = [
//     NotificationModel(
//       title: 'Notification Title',
//       subtitle: 'Here\'s notification text.',
//       time: '34m ago',
//       isRead: false, // unread
//     ),
//     NotificationModel(
//       title: 'Notification Title',
//       subtitle: 'Here\'s notification text.',
//       time: '34m ago',
//       isRead: false, // unread
//     ),
//     NotificationModel(
//       title: 'Notification Title',
//       subtitle: 'Here\'s notification text.',
//       time: '34m ago',
//       isRead: false,
//     ),
//     NotificationModel(
//       title: 'Ureusus',
//       subtitle: 'wants to start a chat with you',
//       time: '1d ago',
//       isRead: true,
//       hasAvatar: true,
//       hasActions: true

//     ),
//     NotificationModel(
//       title: 'Notification Title',
//       subtitle: 'Here\'s notification text.',
//       time: '34m ago',
//       isRead: false,
//     ),
//     NotificationModel(
//       title: 'Notification Title',
//       subtitle: 'Here\'s notification text.',
//       time: '34m ago',
//       isRead: true,
//     ),
//   ];

//   void markAllAsRead() {
//     setState(() {
//       for (var n in notifications) {
//         n.isRead = true;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: false,
//         title: const Text(
//           'Notification',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: markAllAsRead,
//             child: const Text(
//               'Read all',
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: notifications.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 8),
//         itemBuilder: (context, index) {
//           final notif = notifications[index];
//           return _buildNotificationCard(notif);
//         },
//       ),
//     );
//   }

//   Widget _buildNotificationCard(NotificationModel notif) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           notif.isRead = true; // mark only this one as read
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: notif.isRead ? AppColors.white : AppColors.appber,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Avatar or indicator
//             if (notif.hasAvatar)
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: Colors.orange[300],
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.person, color: Colors.white, size: 20),
//               )
//             else if (!notif.isRead) // unread indicator
//               Container(
//                 width: 16,
//                 height: 16,
//                 margin: const EdgeInsets.only(top: 6),
//                 decoration: const BoxDecoration(
//                   color: AppColors.primarybutton,
//                   shape: BoxShape.circle,
//                 ),
//               )
//             else
//               const SizedBox(width: 8),

//             const SizedBox(width: 12),

//             // Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         notif.title,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: notif.isRead ? Colors.black87 : Colors.black,
//                         ),
//                       ),
//                       Text(
//                         notif.time,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     notif.subtitle,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                   ),
//                 ],
//               ),
//             ),

//             // Action buttons
//             if (notif.hasActions) ...[
//               const SizedBox(width: 12),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       child: const Icon(
//                         Icons.close,
//                         color: Colors.red,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       child: const Icon(
//                         Icons.check,
//                         color: Colors.green,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final String time;
  bool isRead;
  final bool hasAvatar;
  final bool hasActions;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false,
    this.hasAvatar = false,
    this.hasActions = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // sample notifications
  List<NotificationModel> notifications = [
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
  ];

  void markAllAsRead() {
    setState(() {
      for (var n in notifications) {
        n.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
            onPressed: markAllAsRead,
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return _buildNotificationCard(notif);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel notif) {
    return GestureDetector(
      onTap: () {
        setState(() {
          notif.isRead = true; // mark only this one as read
        });
      },
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
            // Avatar or indicator
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
              const SizedBox(width: 8),

            const SizedBox(width: 12),

            // Content
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

            // Action buttons
            if (notif.hasActions) ...[
              const SizedBox(width: 12),
              Row(
                children: [
                  // Cancel/Delete button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        notifications.remove(notif);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Go to Message screen button
                  GestureDetector(
                    onTap: () {
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
                      setState(() {
                        notif.isRead = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 20,
                      ),
                    ),
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
