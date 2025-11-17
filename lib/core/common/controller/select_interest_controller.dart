import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/app/controller/app_global_controllers.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';
import 'package:flutter_ursffiver/core/common/model/interest_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../interface/interest_interface.dart';
import '../../helpers/handle_fold.dart' show handleFold;
import '../enum/interest_color.dart';

// Filter people suggestion with interest
class InterestSelectionController extends GetxController {

  InterestSelectionController() {
    // ignore: invalid_use_of_protected_member
    interestList.value = _interestList.value;
    search('');
  }
  
  final Debouncer _debouncer = Debouncer(delay:  Duration(milliseconds: 500));
  
  /// [Interest id] : bool
  RxMap<String, bool> selectedInterests = RxMap<String, bool>({});
  RxMap<CreateCustomInterestReqParam, bool> customRequests =
      RxMap<CreateCustomInterestReqParam, bool>({});
  RxList<InterestCategoryModel> get _interestList =>
      Get.find<AppGlobalControllers>().interestController.interestList;

  RxList<InterestCategoryModel> interestList = RxList<InterestCategoryModel>([]);
  @protected
  RxInt selectedIndexCnt = RxInt(0);

  bool isSelected(String id) => (selectedInterests.containsKey(id) && selectedInterests[id] == true);

  static Future<List<InterestCategoryModel>> _isolateSearch(
  Map<String, dynamic> message,
) async {
  debugPrint("isolate search: ${message['query']}");
  final String query = message['query'] as String;
  final List<InterestCategoryModel> interests =
      message['interestList'] as List<InterestCategoryModel>;

  final List<InterestCategoryModel> filteredList = [];

  for (final category in interests) {
    final filteredInterests = category.interests
        .where((interest) =>
            interest.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredInterests.isNotEmpty) {
      filteredList.add(category.copyWith(interests: filteredInterests));
      debugPrint('adding: ${category.name}');
    }
  }

  return filteredList;
}

void search(String query) async {
  debugPrint("search: $query");
  _debouncer.call(() async {
    final result = await compute(
      _isolateSearch,
      {
        'query': query,
        // ignore: invalid_use_of_protected_member
        'interestList': _interestList.value,
      },
    );

    interestList.value = result;
  });
}

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
