
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
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Profile Image
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//               image: DecorationImage(
//                 image: imagePath.startsWith('http')
//                     ? NetworkImage(imagePath)
//                     : AssetImage(imagePath) as ImageProvider,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Gap.h16,
//           // User Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Name and Status Row
//                 Row(
//                   children: [
//                     Text(
//                       name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const Spacer(),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.blue[50],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: GestureDetector(
//                             onTap: onChat,
//                             child: Icon(
//                               Icons.chat_bubble_outline,
//                               size: 16,
//                               color: Colors.blue[600],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: GestureDetector(
//                             onTap: onInfo,
//                             child: Icon(
//                               Icons.info_outline,
//                               size: 16,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 // Distance and Availability
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       size: 14,
//                       color: Colors.grey[600],
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       distance,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.green[50],
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Text(
//                         status,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.green[600],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 // Action Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: onActivityHi,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.purple[100],
//                           foregroundColor: Colors.purple[700],
//                           elevation: 0,
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: const Text(
//                           'Activity/Hi',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: onExperience,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green[100],
//                           foregroundColor: Colors.green[700],
//                           elevation: 0,
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: const Text(
//                           'Experience',
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String distance;
  final String status;
  final List<String> tags; // New list of tags
  final List<Color> tagColors; // Corresponding tag colors
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
    required this.tags,
    required this.tagColors,
    required this.onActivityHi,
    required this.onExperience,
    required this.onChat,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: imagePath.startsWith('http')
                    ? NetworkImage(imagePath)
                    : AssetImage(imagePath) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Gap.h16,
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name, Distance & Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Text(
                                distance,
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Chat & Info Icons
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onChat,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.chat_bubble_outline, size: 16, color: Colors.blue[600]),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: onInfo,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Tags Row
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: List.generate(tags.length, (index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColors[index],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tags[index],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
