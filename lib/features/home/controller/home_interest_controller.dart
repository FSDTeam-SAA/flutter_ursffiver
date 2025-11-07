import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';
import 'package:get/get.dart';

class HomeInterestController extends GetxController {
  final Rxn<UserBadgesModel> userProfile = Rxn<UserBadgesModel>();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadinterest();
  }

  void loadinterest() async {
    isLoading.value = true;
    final auth =
        (Get.find<AppManager>().currentAuthStatus as Authenticated).auth;
    final userid = auth.userId;

    final lr = await Get.find<BadgesInterface>().getuserbyid(userid);

    handleFold(
      either: lr,
      onSuccess: (success) {
        debugPrint("✅ Profile fetched: ${success.interests.first.name}");
        userProfile.value = success;
      },
      onError: (failure) {
        debugPrint(failure.fullError);
      },
    );
    isLoading.value = false;
  }
}
