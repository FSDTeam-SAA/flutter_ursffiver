import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/profile/controller/update_privacy_controller.dart';
import 'package:flutter_ursffiver/features/profile/services/profile_interface_impl.dart';
import 'package:get/get.dart';

class PrivacySettingsScreen extends StatelessWidget {
  PrivacySettingsScreen({super.key});

  final PrivacyController controller = Get.put(
    PrivacyController(
      profileInterface: ProfileInterfaceImpl(appPigeon: Get.find<AppPigeon>()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Privacy Settings",
          style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.check, color: AppColors.primarybutton),
                  onPressed: controller.updatePrivacy,
                )),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _switchTile(
              title: "Profile Picture Visibility",
              value: controller.profilePictureVisibility.value,
              onChanged: (v) => controller.profilePictureVisibility(v),
            ),
            _switchTile(
              title: "Show my profile to everyone",
              value: controller.showMyProfileToEveryone.value,
              onChanged: (v) => controller.showMyProfileToEveryone(v),
            ),
            _switchTile(
              title: "Share my age range",
              value: controller.shareAgeRange.value,
              onChanged: (v) => controller.shareAgeRange(v),
            ),
            _switchTile(
              title: "Share my gender",
              value: controller.shareGender.value,
              onChanged: (v) => controller.shareGender(v),
            ),
            _switchTile(
              title: "Prefer same gender",
              value: controller.preferSameGender.value,
              onChanged: (v) => controller.preferSameGender(v),
            ),
            _switchTile(
              title: "Prefer Verified users only",
              value: controller.preferVerifiedUsersOnly.value,
              onChanged: (v) => controller.preferVerifiedUsersOnly(v),
            ),
            _switchTile(
              title: "Allow Location Tracking",
              value: controller.allowLocationTracking.value,
              onChanged: (v) => controller.allowLocationTracking(v),
            ),
          ],
        ),
      ),
    );
  }

  Widget _switchTile({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primarybutton,
          ),
        ],
      ),
    );
  }
}