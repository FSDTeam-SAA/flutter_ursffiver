import 'package:flutter/rendering.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import 'package:get/get.dart';

class ProfileDataProvider extends GetxController {
  Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);

  // Add this: Interest selection controller
  final InterestSelectionController selectInterestController =
      InterestSelectionController();

  // Add this: All interests fetch controller
  final AllInterestFetchController allInterestController =
      AllInterestFetchController();
  @override
  void onInit() {
    super.onInit();
    allInterestController.fetchInterests();
    getCurrentUserProfile();
  }

  Future<void> getCurrentUserProfile() async {
    if (Get.find<AppManager>().currentAuthStatus is Authenticated) {
      final auth =
          (Get.find<AppManager>().currentAuthStatus as Authenticated).auth;
      final userid = auth.userId;

      final lr = await Get.find<ProfileInterface>().getUserProfilebyId(userid);

      lr.fold((failure) {}, (success) {
        userProfile.value = success.data;
        selectInterestController.init(
          preSelectedInterests: success.data?.interests,
          preSelectedCustomInterest: success.data?.customInterests,
        );
        debugPrint("✅ Profile fetched: ${success.data?.email}");
        userProfile.refresh();
      });
    }
  }
}
