import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
import 'package:flutter_ursffiver/features/auth/controller/app_controllers.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';
import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
import 'package:get/get.dart';

import '../../../features/auth/interface/interest_interface.dart';
import '../../helpers/handle_fold.dart' show handleFold;

// Filter people suggestion with interest
class SelectInterestController extends GetxController {
  /// [Interest id] : bool
  RxMap<String, bool> selectedInterests = RxMap<String, bool>({});
  RxMap<CreateCustomInterestReqParam, bool> customRequests =
      RxMap<CreateCustomInterestReqParam, bool>({});
  RxList<InterestCategoryModel> get interestList =>
      Get.find<AppGlobalControllers>().interestController.interestList;

  RxString searchQuery = ''.obs;
  @protected
  RxInt selectedIndexCnt = RxInt(0);

  void search(String query) async {}

  void toggleSelectInterest(InterestModel interest) {
    if (!selectedInterests.containsKey(interest.id)) {
      selectedInterests[interest.id] = true;
    }
    else {
      selectedInterests[interest.id] = !selectedInterests[interest.id]!;
    }

    if(selectedInterests[interest.id]!) {
      selectedIndexCnt.value++;
    } else {
      selectedIndexCnt.value--;
    }
  }

  void toggleSelectCustomInterest(CreateCustomInterestReqParam interest) {
    if (!customRequests.containsKey(interest)) {
      customRequests[interest] = true;
    }
    else {
      customRequests[interest] = !customRequests[interest]!;
    }

    if(customRequests[interest]!) {
      selectedIndexCnt.value++;
    } else {
      selectedIndexCnt.value--;
    }
  }

  void addCustomInterest(CreateCustomInterestReqParam interest) {
    customRequests[interest] = true;
  }

  Future<void> createInterest({
    required String name,
    required InterestColor color,
  }) async {
    await Get.find<InterestInterface>()
        .createCustomInterest(
          CreateCustomInterestReqParam(name: name, color: color),
        )
        .then((lr) {
          handleFold(
            either: lr,
            onSuccess: (success) {
              interestList.value = success;
            },
            onError: (failure) {
              debugPrint(failure.fullError);
            },
          );
        });
  }
}
