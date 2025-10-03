// import 'package:flutter/material.dart';
// import 'package:another_flushbar/flushbar.dart';

// class FixedNotificationBanner {
//   static void show(BuildContext context) {
//     Flushbar(
//       message: null,
//       messageText: Row(
//         children: [
//           const CircleAvatar(
//             backgroundColor: Colors.grey,
//             child: Icon(Icons.person, color: Colors.white),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const Text(
//                       "Ursusus",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       "1d ago",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   "wants to start a chat with you",
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context, rootNavigator: true).pop();
//                 },
//                 child: const Text(
//                   "Decline",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context, rootNavigator: true).pop();
//                   // Handle Accept action
//                 },
//                 child: const Text(
//                   "Accept",
//                   style: TextStyle(color: Colors.purple),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       duration: const Duration(seconds: 5),
//       flushbarPosition: FlushbarPosition.TOP,
//       backgroundColor: const Color.fromARGB(255, 155, 193, 242),
//       borderRadius: BorderRadius.circular(12),
//       margin: const EdgeInsets.all(12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       boxShadows: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 4,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ).show(context);
//   }
// }

import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';

class FixedNotificationBanner {
  static void show(BuildContext context) {
    Flushbar(
      message: null,
      messageText: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Ursusus",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "1d ago",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "wants to start a chat with you",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // Decline Button with border
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  "Decline",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(width: 8),
              // Accept Button with border
              OutlinedButton(
                onPressed: () {
                  // Close the Flushbar first
                  Navigator.of(context, rootNavigator: true).pop();

                  // Navigate to InboxScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        contactName: 'Ursusus',
                        avatarUrl:
                            'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
                      ),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.purple, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  "Accept",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ],
      ),
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: const Color.fromARGB(255, 155, 193, 242),
      borderRadius: BorderRadius.circular(12),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ).show(context);
  }
}
