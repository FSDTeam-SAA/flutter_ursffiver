import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/update_privacy_model.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController {
  final ProfileInterface profileInterface;

  PrivacyController({required this.profileInterface});

  final profilePictureVisibility = false.obs;
  final showMyProfileToEveryone = true.obs;
  final shareAgeRange = true.obs;
  final shareGender = false.obs;
  final preferSameGender = false.obs;
  final preferVerifiedUsersOnly = false.obs;
  final allowLocationTracking = true.obs;
  final isLoading = false.obs;

  late String _userId;

  @override
  void onInit() {
    super.onInit();
    final auth = Get.find<AppManager>().currentAuthStatus;
    if (auth is Authenticated) {
      _userId = auth.auth.userId;
      loadPrivacySettings();
    }
  }

  Future<void> loadPrivacySettings() async {
    if (_userId.isEmpty) return;

    try {
      isLoading.value = true;

      final result = await profileInterface.getUserProfilebyId(_userId);

      result.fold(
        (failure) {
          debugPrint("Load privacy failed: $failure");
          Get.snackbarError("Failed to load privacy settings");
        },
        (response) {
          final data = response.data?.toJson() ?? {};
          debugPrint("Privacy data from server: $data");
          profilePictureVisibility(
            data['profile_picture_visibility'] as bool? ,
          );
          showMyProfileToEveryone(data['profile_visibility'] as bool?);
          shareAgeRange(data['age_range_visibility'] as bool?);
          shareGender(data['gender_visibility'] as bool? );
          preferSameGender(data['same_gender'] as bool? );
          preferVerifiedUsersOnly(data['verified_user'] as bool? );
          allowLocationTracking(data['location_tracking'] as bool? );
        },
      );
    } catch (e) {
      debugPrint("Exception loading privacy: $e");
      Get.snackbarError("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePrivacy() async {
    final model = UpdatePrivacyModel(
      profilepicturevisibility: profilePictureVisibility.value,
      profilevisibility: showMyProfileToEveryone.value,
      agerangevisibility: shareAgeRange.value,
      gendervisibility: shareGender.value,
      samegender: preferSameGender.value,
      verifieduser: preferVerifiedUsersOnly.value,
      // Add location_tracking to model if your API supports it
    );

    try {
      isLoading.value = true;

      final result = await profileInterface.updatePrivacy(model);

      result.fold((failure) => Get.snackbarError("Update failed: $failure"), (
        _,
      ) {
        Get.snackbarSuccess("Privacy settings updated!");
        loadPrivacySettings(); // refresh from server
      });
    } catch (e) {
      Get.snackbarError("Update error");
    } finally {
      isLoading.value = false;
    }
  }
}

// Optional: small extensions for nice snackbars
extension SnackbarExt on GetInterface {
  void snackbarSuccess(String message) =>
      snackbar("Success", message, backgroundColor: Colors.green[100]);
  void snackbarError(String message) =>
      snackbar("Error", message, backgroundColor: Colors.red[100]);
}
