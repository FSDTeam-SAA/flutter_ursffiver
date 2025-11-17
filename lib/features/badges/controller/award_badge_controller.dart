import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/features/badges/model/award_badges_to_user.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:get/get.dart';

import '../../../core/notifiers/snackbar_notifier.dart';
import '../services/badges_interface.dart';

class AwardBadgeController extends GetxController{
  AwardBadgeController({required this.toUserId});

  final RxList<BadgeModel> selectedBadges = <BadgeModel>[].obs;
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );
  final String toUserId;


  void toggleSelection(BadgeModel badge) {
    if (selectedBadges.contains(badge)) {
      selectedBadges.remove(badge);
    } else {
      selectedBadges.add(badge);
    }
    selectedBadges.isNotEmpty ? processNotifier.setEnabled() : processNotifier.setDisabled();
  }

  Future<void> awardBadges({
    SnackbarNotifier? errorSnackbarNotifier,
    SnackbarNotifier? successSnackbarNotifier,
  }) async {
    processNotifier.setLoading();
    final lr = await Get.find<BadgesInterface>().awardBadgestoUser(
      param: AwardBadgesToUser(
        userId: toUserId,
        badgeIds: selectedBadges.map((e) => e.id).toList(),
      ),
    );

    handleFold(
      either: lr,
      processStatusNotifier: processNotifier,
      successSnackbarNotifier: successSnackbarNotifier,
      errorSnackbarNotifier: errorSnackbarNotifier,
    );
  }

}
