import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/app/controller/app_global_controllers.dart';
import 'package:flutter_ursffiver/features/auth/model/create_custom_interest_req_param.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../model/interest_model.dart';
import '../interface/interest_interface.dart';
import '../../helpers/handle_fold.dart' show handleFold;
import 'interest_fetch_controller.dart';

class SelectedInterestPostData {
  final List<String> interestIds;
  final List<CreateCustomInterestReqParam> customInterests;

  SelectedInterestPostData({
    required this.interestIds,
    required this.customInterests,
  });
}

class InterestSelectionController extends GetxController {
  InterestSelectionController({List<InterestModel>? preSelectedInterests, List<InterestModel>? preSelectedCustomInterest}):preselectedInterests = preSelectedInterests ?? [] {
    
    init(
      preSelectedInterests: preSelectedInterests,
      preSelectedCustomInterest: preSelectedCustomInterest,
    );
  }

  final Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 500));
  final List<InterestModel> preselectedInterests;
  final AllInterestDataProvider interestDataProvider = AllInterestDataProvider();

  /// [Interest id] : bool
  RxMap<String, bool> selectedInterests = RxMap<String, bool>({});

  RxMap<CreateCustomInterestReqParam, bool> customRequests =
      RxMap<CreateCustomInterestReqParam, bool>({});


  final RxList<InterestCategoryModel> interestList = RxList<InterestCategoryModel>([]);

  SelectedInterestPostData get selectedInterestPostData =>
      SelectedInterestPostData(
        interestIds: selectedInterests.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList(),
        customInterests: customRequests.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList(),
      );

  @protected
  RxInt selectedIndexCnt = RxInt(0);

  /// Check if interest is selected
  bool isSelected(String id) =>
      (selectedInterests.containsKey(id) && selectedInterests[id] == true);

  /// Max selection reached
  bool get isMaxSelected => selectedIndexCnt.value >= 15;

  void init({List<InterestModel>? preSelectedInterests, List<InterestModel>? preSelectedCustomInterest}) async{
    await interestDataProvider.fetchInterests();
    interestList.value = interestDataProvider.interestList.value;
    for (var interest in preselectedInterests) {
      selectedInterests[interest.id] = true;
      selectedIndexCnt.value++;
    }
    for (var interest in preSelectedCustomInterest ?? []) {
      final reqParam = CreateCustomInterestReqParam.fromInterest(interest);
      customRequests[reqParam] = true;
      selectedIndexCnt.value++;
    }
    search('');
  }

  static Future<List<InterestCategoryModel>> _isolateSearch(
    Map<String, dynamic> message,
  ) async {
    final String query = message['query'] as String;
    final List<InterestCategoryModel> interests =
        message['interestList'] as List<InterestCategoryModel>;
    final List<InterestCategoryModel> filteredList = [];

    for (final category in interests) {
      final filteredInterests = category.interests
          .where(
            (interest) =>
                interest.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      if (filteredInterests.isNotEmpty) {
        filteredList.add(category.copyWith(interests: filteredInterests));
      }
    }

    return filteredList;
  }

  void search(String query) async {
    _debouncer.call(() async {
      final result = await compute(_isolateSearch, {
        'query': query,
        'interestList': interestDataProvider.interestList.value,
      });
      interestList.value = result;
    });
  }

  void toggleSelectInterest(InterestModel interest) {
    // Deselecting is always allowed
    if (selectedInterests[interest.id] == true) {
      selectedInterests[interest.id] = false;
      selectedIndexCnt.value--;
      return;
    }

    // Selecting only if max not reached
    if (isMaxSelected) {
      Get.snackbar(
        "Limit reached",
        "You can select a maximum of 15 interests",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    selectedInterests[interest.id] = true;
    selectedIndexCnt.value++;
  }

  void toggleSelectCustomInterest(CreateCustomInterestReqParam interest) {
    if (customRequests[interest] == true) {
      customRequests[interest] = false;
      selectedIndexCnt.value--;
      return;
    }

    if (isMaxSelected) {
      Get.snackbar(
        "Limit reached",
        "You can select a maximum of 15 interests",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    customRequests[interest] = true;
    selectedIndexCnt.value++;
  }

  void addCustomInterest(CreateCustomInterestReqParam interest) {
    debugPrint("Adding custom interest: ${interest.name}");
    customRequests[interest] = true;
    selectedIndexCnt.value++;
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
