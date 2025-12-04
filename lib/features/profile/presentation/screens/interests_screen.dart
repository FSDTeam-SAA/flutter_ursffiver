import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/sheets/interest_picker_sheet.dart';
import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_model.dart';
import 'package:get/get.dart';
import 'package:flutter_ursffiver/features/home/presentation/widget/interest_grid.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  bool isEditing = false;

  final ProfileDataProvider _profileDataController =
      Get.find<ProfileDataProvider>();

  void _openInterestPicker() {
    final controller = _profileDataController.selectInterestController;

    // Pre-select existing interests
    final selectedIds =
        _profileDataController.userProfile.value?.interests
            .map((e) => e.id)
            .toList() ??
        [];
    for (var id in selectedIds) {
      controller.selectedInterests[id] = true;
    }
    controller.selectedIndexCnt.value = selectedIds.length;

    // Open bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return InterestPickerSheet.forFiltering(
          interestSelectionCntlr: controller,
          brandGradient: const LinearGradient(
            colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
          ),
          onConfirm: () async {
            final allInterests = _profileDataController
                .allInterestController
                .interestList
                .expand((cat) => cat.interests)
                .toList();

            final selected = controller.selectedInterests.entries
                .where((e) => e.value)
                .map((e) => allInterests.firstWhereOrNull((i) => i.id == e.key))
                .where((e) => e != null)
                .cast<InterestModel>()
                .toList();

            // Update local profile safely
            final oldUser = _profileDataController.userProfile.value!;
            _profileDataController.userProfile.value = oldUser.copyWith(
              interests: selected,
            );

            // API call
            await Get.find<ProfileInterface>().updateProfile(
              UpdateProfileModel(id: oldUser.id, interests: selected),
            );

            await _profileDataController.getCurrentUserProfile();

            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                isEditing = !isEditing;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEditing) ...[
                Text(
                  "Primary Interests",
                  style: AppText.lgMedium_18_500.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Your interests help others understand what you're into.",
                  style: AppText.smMedium_14_500.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                Gap.h8,
              ],
              Expanded(
                child: Obx(() {
                  final selectedInterests =
                      _profileDataController.userProfile.value?.interests ?? [];

                  if (selectedInterests.isEmpty) {
                    return const Center(
                      child: Text(
                        "No interests added.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return InterestsGrid(
                    chips: selectedInterests,
                    editable: isEditing,
                  );
                }),
              ),

              if (isEditing)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primarybutton,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _openInterestPicker,
                    child: Text(
                      "Add More Interests",
                      style: AppText.mdMedium_16_500.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
