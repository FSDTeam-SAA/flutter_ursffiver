// import 'package:flutter/foundation.dart';
// import 'package:flutter_ursffiver/core/common/model/coordinates.dart';
// import 'package:flutter_ursffiver/core/componenet/pagination/pagination.dart';
// import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
// import 'package:flutter_ursffiver/features/home/model/user_model.dart';
// import 'package:flutter_ursffiver/features/home/service/home_interface.dart';
// import 'package:get/get.dart';

// import '../../../core/helpers/handle_fold.dart';
// import '../model/get_user_suggestion_req_param.dart';

// // Filter people suggestion with interest
// class FilterPeopleSuggestionController extends GetxController {
//   final InterestSelectionController selectInterestController =
//       InterestSelectionController();

//   RxMap<String, bool> get interests =>
//       selectInterestController.selectedInterests;

//   Rx<Pagination<UserModel>> suggestionList = Rx<Pagination<UserModel>>(
//     NotInitialized([]),
//   );
//   Coordinates? currentLocation;
//   Rx<LocationRange?> selectedLocationRange = Rx<LocationRange?>(null);

//   Future<void> findSuggestion({bool forceFresh = false}) async {
//     if (forceFresh) {
//       suggestionList.value = RefreshingPage([]);
//     } else {
//       suggestionList.value = LoadingMorePage(suggestionList.value.data);
//     }

//     await Get.find<HomeInterface>().getSuggestions(
//       GetUserSuggestionReqParam(
//         interests: selectInterestController.selectedInterests.keys.toList(),
//         location: currentLocation,
//         locationRange: selectedLocationRange.value,
//       )
//     ).then((lr) {
//       handleFold(
//         either: lr,
//         onSuccess: (success) {
//           final allData = suggestionList.value.data + success;
//           suggestionList.value = success.isEmpty
//               ? AllLoaded(allData)
//               : Loaded(allData);
//         },
//         onError: (failure) {
//           debugPrint(failure.fullError);
//           suggestionList.value = Loaded(suggestionList.value.data);
//         },
//       );
//     });
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/core/common/model/coordinates.dart';
import 'package:flutter_ursffiver/core/componenet/pagination/pagination.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import 'package:get/get.dart';

import '../../../app/app_manager.dart';
import '../../../core/helpers/auth_role.dart';
import '../../../core/helpers/handle_fold.dart';
import '../model/get_user_suggestion_req_param.dart';

// Filter people suggestion with interest
class FilterPeopleSuggestionController extends GetxController {
  final InterestSelectionController selectInterestController =
      InterestSelectionController();

  RxMap<String, bool> get interests =>
      selectInterestController.selectedInterests;

  Rx<Pagination<UserProfile>> suggestionList = Rx<Pagination<UserProfile>>(
    NotInitialized([]),
  );

  Coordinates? currentLocation;
  Rx<LocationRange?> selectedLocationRange = Rx<LocationRange?>(null);

  Future<void> findSuggestion({bool forceFresh = false}) async {
    if (forceFresh) {
      suggestionList.value = RefreshingPage([]);
    } else {
      suggestionList.value = LoadingMorePage(suggestionList.value.data);
    }

    await Get.find<HomeInterface>()
        .getSuggestions(
          GetUserSuggestionReqParam(
            interests: selectInterestController.selectedInterests.keys.toList(),
            location: currentLocation,
            locationRange: selectedLocationRange.value,
          ),
        )
        .then((lr) {
          handleFold(
            either: lr,
            onSuccess: (success) {
              // Get current logged-in user ID
              final authStatus = Get.find<AppManager>().currentAuthStatus;
              String? currentUserId;
              if (authStatus is Authenticated) {
                currentUserId = authStatus.auth.userId;
              }

              // Filter out the logged-in user from suggestions
              final filteredList = success
                  .where((user) => user.id != currentUserId)
                  .toList();

              // Merge and update pagination list
              final allData = suggestionList.value.data + filteredList;
              suggestionList.value = filteredList.isEmpty
                  ? AllLoaded(allData)
                  : Loaded(allData);
            },
            onError: (failure) {
              debugPrint(failure.fullError);
              suggestionList.value = Loaded(suggestionList.value.data);
            },
          );
        });
  }
}
