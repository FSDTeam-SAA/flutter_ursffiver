import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/home/model/status_model.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';

class StatusController extends GetxController {
  final HomeInterface homeService = Get.find<HomeInterface>();

  RxString statusMessage = "".obs;
  RxBool isUpdating = false.obs;
  String get userId {
    final manager = Get.find<AppManager>();
    final auth = manager.currentAuthStatus as Authenticated;
    return auth.auth.userId;
  }
  Future<void> updateStatus(String newStatus) async {
    statusMessage.value = newStatus;
    isUpdating.value = true;

    final body = StatusModel(id: userId, status: newStatus);

    final res = await homeService.status(body);
    handleFold(
      either: res,
      onSuccess: (_) {
        Get.snackbar(
          "Success",
          "Status selected successfully",
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      onError: (f) {
        Get.snackbar(
          "Error",
          f.uiMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      },
    );

    isUpdating.value = false;
  }
}
