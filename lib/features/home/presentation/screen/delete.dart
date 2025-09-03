// import 'package:flutter/material.dart';
// import 'package:flutter_ursffiver/core/theme/app_gap.dart';

// class UserProfileCard extends StatelessWidget {
//   final String name;
//   final String imagePath;
//   final String distance;
//   final String status;
//   final VoidCallback onActivityHi;
//   final VoidCallback onExperience;
//   final VoidCallback onChat;
//   final VoidCallback onInfo;

//   const UserProfileCard({
//     super.key,
//     required this.name,
//     required this.imagePath,
//     required this.distance,
//     required this.status,
//     required this.onActivityHi,
//     required this.onExperience,
//     required this.onChat,
//     required this.onInfo,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 90,
//           height: 130,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(
//               image: AssetImage(imagePath), // Using AssetImage instead of NetworkImage
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         // Main Content
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Name
//               Text(
//                 name,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Distance and Status
//               Row(
//                 children: [
//                   const Icon(Icons.location_on, size: 16, color: Colors.grey),
//                   const SizedBox(width: 4),
//                   Text(
//                     distance,
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     status,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: status == 'Available' ? Colors.green : Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Tags
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       _buildTag(
//                         "Acting/Th...",
//                         Colors.blue.shade100,
//                         Colors.blue.shade700,
//                       ),
//                       Gap.w4,
//                       _buildTag(
//                         "Expedition...",
//                         Colors.green.shade100,
//                         Colors.green.shade700,
//                       ),
//                     ],
//                   ),
//                   Gap.h4,
//                   Row(
//                     children: [
//                       _buildTag(
//                         "Escape Ro...",
//                         Colors.pink.shade100,
//                         Colors.pink.shade700,
//                       ),
//                       Gap.w4,
//                       _buildTag(
//                         "Arcade G...",
//                         Colors.amber.shade100,
//                         Colors.amber.shade700,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Gap.w4,
//         Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(
//                   Icons.message_outlined,
//                   color: Colors.blue.shade600,
//                   size: 28,
//                 ),
//                 Gap.w12,
//                 Icon(Icons.help_outline_sharp, color: Colors.grey, size: 28),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// ////////////////////
// Widget _buildTag(String text, Color backgroundColor, Color textColor) {
//   return Container(
//     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//     height: 30, // Fixed height
//     width: 90, // Fixed width
//     decoration: BoxDecoration(
//       color: backgroundColor,
//       borderRadius: BorderRadius.circular(8),
//     ),
//     child: Center(
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 10,
//           color: textColor,
//           fontWeight: FontWeight.w500,
//         ),
//         textAlign: TextAlign.center, // Center the text
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/user-profile_screen.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String distance;
  final String status;
  final VoidCallback onActivityHi;
  final VoidCallback onExperience;
  final VoidCallback onChat;
  final VoidCallback onInfo;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.distance,
    required this.status,
    required this.onActivityHi,
    required this.onExperience,
    required this.onChat,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfileScreen()),
        );
      },
      child: Row(
        children: [
          Container(
            width: 90,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Main Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Distance and Status
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 14,
                        color: status == 'Available' ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tags
                Column(
                  children: [
                    Row(
                      children: [
                        _buildTag(
                          "Acting/Th...",
                          Colors.blue.shade100,
                          Colors.blue.shade700,
                        ),
                        Gap.w4,
                        _buildTag(
                          "Expedition...",
                          Colors.green.shade100,
                          Colors.green.shade700,
                        ),
                      ],
                    ),
                    Gap.h4,
                    Row(
                      children: [
                        _buildTag(
                          "Escape Ro...",
                          Colors.pink.shade100,
                          Colors.pink.shade700,
                        ),
                        Gap.w4,
                        _buildTag(
                          "Arcade G...",
                          Colors.amber.shade100,
                          Colors.amber.shade700,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap.w4,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.message_outlined,
                    color: Colors.blue.shade600,
                    size: 28,
                  ),
                  Gap.w12,
                  Icon(Icons.help_outline_sharp, color: Colors.grey, size: 28),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

////////////////////
Widget _buildTag(String text, Color backgroundColor, Color textColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    height: 30, // Fixed height
    width: 90, // Fixed width
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center, // Center the text
      ),
    ),
  );
}
