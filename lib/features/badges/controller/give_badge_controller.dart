import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/model/give_badge.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';
import 'package:get/get.dart';

class AllBadgesController2 extends GetxController {
  final RxList<BadgeModel> allBadges = <BadgeModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllBadges();
  }

  /// Load all badges
  void loadAllBadges() async {
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
          allBadges.value = [];
          debugPrint("Failed to load badges: ${failure.fullError}");
        },
      );
    } catch (e, st) {
      debugPrint("Exception in loadAllBadges: $e");
      debugPrint("$st");
      allBadges.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Send a badge to user
  Future<void> giveBadge({
    required String receiverUserId,
    required String badgeId,
  }) async {
    try {
      isLoading.value = true;

      final param = GiveBadge(userId: receiverUserId, badgeId: badgeId);
      final lr = await Get.find<BadgesInterface>().giveBadge(param: param);

      handleFold(
        either: lr,
        onSuccess: (_) {
          //SnackbarNotifier.show(message: "Badge sent successfully!");
        },
        onError: (failure) {
          //SnackbarNotifier.show(message: "Error: ${failure.message}");
        },
      );
    } catch (e, st) {
      debugPrint("Exception in giveBadge: $e");
      debugPrint("$st");
      //SnackbarNotifier.show(message: "Error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
