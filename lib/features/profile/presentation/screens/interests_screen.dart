import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/home/presentation/widget/interest_grid.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  bool isEditing = false; // flag to toggle edit mode

  final ProfileDataProvider _profieDataController =
      Get.find<ProfileDataProvider>();

  final List<Map<String, dynamic>> interests = [
    {"title": "Acting/Theatre", "color": AppColors.primarybutton},
    {"title": "Escape Room", "color": AppColors.interestsred},
    {"title": "Arcade Gaming", "color": AppColors.interestsyellow},
    {"title": "Expedition Trips", "color": AppColors.interestsgreen},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Interests",
          style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing; // toggle edit mode
              });
            },
            child: Text(
              isEditing ? "Done" : "Edit Interests",
              style: AppText.mdMedium_16_500.copyWith(
                color: AppColors.primarybutton,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Only show this when not editing
            if (!isEditing)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Primary Interests",
                    style: AppText.lgMedium_18_500.copyWith(
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Your bio will be visible to nearby users as a preview of who you are.",
                    style: AppText.smMedium_14_500.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  Gap.h60,
                ],
              ),

            // Grid of interests
            // SliverToBoxAdapter(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const SizedBox(height: 20),
            //       const Text(
            //         "Primary Interests",
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //       ),
            //       const SizedBox(height: 8),
            //       Obx(() {
            //         final selectedInterests =
            //             _profieDataController.userProfile.value?.interests ??
            //             [];

            //         debugPrint(
            //           "selectedInterests: ${_profieDataController.userProfile.value?.interests.length ?? 0}",
            //         );

            //         if (selectedInterests.isEmpty) {
            //           return const Padding(
            //             padding: EdgeInsets.symmetric(
            //               vertical: 8.0,
            //               horizontal: 0,
            //             ),
            //             child: Text(
            //               "No interests found.",
            //               style: TextStyle(color: Colors.grey),
            //             ),
            //           );
            //         }

            //         return InterestsGrid(chips: selectedInterests);
            //       }),
            //       const SizedBox(height: 20),
            //     ],
            //   ),
            // ),
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 15,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
                  final item = interests[index % interests.length];
                  return _buildTag(item["title"], item["color"]);
                },
              ),
            ),
            Gap.h16,

            // Only show "Add More Interests" button when editing
            if (isEditing)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add More Interests',
                        style: AppText.lgMedium_18_500.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.add_circle_outline,
                        size: 36,
                        color: AppColors.primaryTextblack,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String title, Color color) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
