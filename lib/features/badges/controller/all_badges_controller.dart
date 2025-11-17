import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_record.dart';
import 'package:flutter_ursffiver/features/badges/model/get_my_badges_request_param.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';
import 'package:get/get.dart';

class AllBadgesController extends GetxController {
  final RxList<BadgeModel> allBadges = <BadgeModel>[].obs;
  final RxList<BadgeRecord> receivedBadges = <BadgeRecord>[].obs;
  final RxList<BadgeRecord> awardedBadges = <BadgeRecord>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadBadges();
    allloadBadges();
  }

  // Load badges received/given by the user
  void loadBadges() async {
    try {
      isLoading.value = true;

      final lr = await Get.find<BadgesInterface>().getMyBadges(
        param: GetmyBadgesRequestParam(),
      );

      handleFold(
        either: lr,
        onSuccess: (success) {
          receivedBadges.value = success.received;
          awardedBadges.value = success.given;

          debugPrint(
            "Received Badges: ${receivedBadges.length}, Awarded Badges: ${awardedBadges.length}",
          );
        },
        onError: (failure) {
          debugPrint("Failed to load my badges: ${failure.fullError}");
        },
      );
    } catch (e, st) {
      debugPrint("Exception in loadBadges: $e");
      debugPrint("$st");
    } finally {
      isLoading.value = false;
    }
  }

  void allloadBadges() async {
    try {
      isLoading.value = true;

      final lr = await Get.find<BadgesInterface>().getAllBadges();

      handleFold(
        either: lr,
        onSuccess: (success) {
          allBadges.value = success;
          debugPrint("Total badges loaded: ${allBadges.length}");
        },
        onError: (failure) {
          debugPrint("Failed to load all badges: ${failure.fullError}");
          allBadges.value = [];
        },
      );
    } catch (e, st) {
      debugPrint("Exception in loadAllBadges: $e");
      debugPrint("$st");
    } finally {
      isLoading.value = false;
    }
  }
}
