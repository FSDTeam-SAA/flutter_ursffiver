import 'package:flutter/widgets.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/common/interface/interest_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';
import 'package:get/get.dart';

import '../model/interest_model.dart';

class AllInterestFetchController extends GetxController {
  RxList<InterestCategoryModel> interestList = RxList([]);

  // fetch
  Future<void> fetchInterests({bool isRefresh = false}) async {
    await Get.find<InterestInterface>().getAllInterests().then((lr) {
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
