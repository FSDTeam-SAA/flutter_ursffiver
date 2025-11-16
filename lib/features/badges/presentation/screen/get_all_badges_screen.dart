// import 'package:flutter/material.dart';
// import 'package:flutter_ursffiver/features/badges/controller/get_all_badges_controller.dart';
// import 'package:get/get.dart';
// import '../../../../core/theme/app_gap.dart';
// import '../../../badges/model/badge_model.dart';
// import 'package:flutter_ursffiver/core/theme/app_colors.dart';

// class GetAllBadgesScreen extends StatelessWidget {
//   const GetAllBadgesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(GetAllBadgesController());

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: false,
//         title: const Text(
//           "All Badge",
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Select a badge for a awarded",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//                 height: 1.4,
//               ),
//             ),
//             Gap.h20,

//             const Text(
//               "Badge Types",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//             ),
//             Gap.h12,

//             Obx(() {
//               return Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: controller.badges.length,
//                   separatorBuilder: (_, __) => const SizedBox(height: 0),
//                   itemBuilder: (context, index) {
//                     final item = controller.badges[index];
//                     return GestureDetector(
//                       onTap: () => controller.selectBadge(item.id),
//                       child: BadgeTile(item: item),
//                     );
//                   },
//                 ),
//               );
//             }),

//             Gap.h20,

//             Obx(() {
//               return SizedBox(
//                 height: 52,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: controller.selectedBadgeId.isEmpty
//                         ? Colors.grey
//                         : AppColors.primarybutton,
//                     foregroundColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4),
//                       side: const BorderSide(color: Colors.grey, width: 1),
//                     ),
//                   ),
//                   onPressed: controller.selectedBadgeId.isEmpty
//                       ? null
//                       : () {
//                           // You can send the selected badge here
//                           debugPrint(
//                             "Selected Badge ID: ${controller.selectedBadgeId.value}",
//                           );
//                         },
//                   child: const Text(
//                     "Send Badge",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               );
//             }),

//             Gap.h40,
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BadgeTile extends StatelessWidget {
//   final BadgeModel item;
//   const BadgeTile({super.key, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<GetAllBadgesController>();

//     return Obx(() {
//       final bool isSelected = controller.selectedBadgeId.value == item.id;

//       return Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(4),
//           side: BorderSide(
//             color: isSelected ? AppColors.primarybutton : Colors.grey.shade300,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 20,
//                 backgroundColor: item.badgeColor.withOpacity(0.15),
//                 child: Icon(item.badgeIcon, color: item.badgeColor, size: 22),
//               ),
//               const SizedBox(width: 12),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item.name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       item.info,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               if (isSelected)
//                 const Icon(Icons.check_circle, color: Colors.green, size: 24),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/badges/controller/all_badges_controller.dart';
import 'package:flutter_ursffiver/features/badges/presentation/widget/all_badges_recorn_widget.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class GetAllBadgesScreen extends StatefulWidget {
  const GetAllBadgesScreen({super.key});

  @override
  State<GetAllBadgesScreen> createState() => _GetAllBadgesScreenState();
}

class _GetAllBadgesScreenState extends State<GetAllBadgesScreen> {
  late AllBadgesController badgeController;

  @override
  void initState() {
    super.initState();
    badgeController = Get.put(AllBadgesController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              size: 32,
              color: AppColors.primarybutton,
            ),
            const SizedBox(width: 4),
            Text(
              'Badge Management',
              style: AppText.xlSemiBold_20_700.copyWith(
                color: AppColors.primaryTextblack,
              ),
            ),
            const Spacer(),
          ],
        ),
        centerTitle: false,
      ),

      // Removed TabBar and TabBarView — now only main widget
      body: const AllBadgesRecordWidget(),
    );
  }
}

class AllBadgesRecordWidget extends StatelessWidget {
  const AllBadgesRecordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllBadgesController>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "All Badges",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Badges you can awarded",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gap.h20,

            Obx(() {
              if (controller.allBadges.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.card_giftcard,
                            size: 160,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No badges yet",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.allBadges.length,
                  itemBuilder: (context, index) {
                    final badge = controller.allBadges[index];
                    return AllBadgesRecornWidget(badge: badge,);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
