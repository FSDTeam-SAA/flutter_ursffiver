import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';
import 'package:get/get.dart';

class AllBadgesController extends GetxController {
  final Rxn<UserBadgesModel> userProfile = Rxn<UserBadgesModel>();


  // Rx<UserBadgesModel> userProfile = UserBadgesModel().obs;
  // Loading indicator
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBadges();
  }

  // Simulated API/local data fetch
  void loadBadges() async {
    isLoading.value = true;
    final auth = (Get.find<AppManager>().authStatus as Authenticated).auth;
    final userid = auth.userId;

    final lr = await Get.find<BadgesInterface>().getuserbyid(userid);

    handleFold(
      either: lr,
      onSuccess: (success) {
        userProfile.value = success;
      },
      onError: (failure) {
        debugPrint(failure.fullError);
      },
    );

    // badges.assignAll([
    //   UserBadgeModel(
    //     id: '1',
    //     name: 'Great Listener',
    //     tag: 'Communication',
    //     info:
    //         'Awarded to someone who was truly attentive and engaged during your conversation.',
    //     color: '#2196F3',
    //   ),
    //   UserBadgeModel(
    //     id: '2',
    //     name: 'Knowledge Share',
    //     tag: 'Knowledge',
    //     info:
    //         'Recognized for generously sharing valuable insights and information.',
    //     color: '#4CAF50',
    //   ),
    //   UserBadgeModel(
    //     id: '3',
    //     name: 'Team Player',
    //     tag: 'Collaboration',
    //     info: 'For exceptional teamwork and supporting others.',
    //     color: '#FF9800',
    //   ),
    // ]);

    isLoading.value = false;
  }
}
