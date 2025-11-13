import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_record.dart';
import 'package:flutter_ursffiver/features/badges/model/get_my_badges_request_param.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';
import 'package:get/get.dart';

class AllBadgesController extends GetxController {
  final RxList<BadgeRecord> receivedBadges = <BadgeRecord>[].obs;

  final RxList<BadgeRecord> awardedBadges = <BadgeRecord>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBadges();
  }

  void loadBadges() async {
    isLoading.value = true;
    final lr = await Get.find<BadgesInterface>().getMyBadges(
      param: GetmyBadgesRequestParam(),
    );
    handleFold(
      either: lr,
      onSuccess: (success) {
        receivedBadges.value = success.received;
        awardedBadges.value = success.given;
      },
      onError: (failure) {
        debugPrint(failure.fullError);
      },
    );
    isLoading.value = false;
  }
}
