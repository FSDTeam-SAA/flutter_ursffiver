import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/core/common/model/coordinates.dart';
import 'package:flutter_ursffiver/core/componenet/pagination/pagination.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/home/model/set_visibility_req.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import 'package:geolocator/geolocator.dart';
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
  Future<void> setVisibility(
  bool visible,
  bool Function() shouldShareLocation,
) async {
  final yes = shouldShareLocation();

  if (yes) {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        debugPrint("User denied location permission.");
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      currentLocation = Coordinates(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  final response = await Get.find<HomeInterface>().setVisibility(
    SetVisibilityReq(active: visible, location: currentLocation),
  );

  handleFold(
    either: response,
    onError: (failure) {
      debugPrint("Set visibility error: $failure");
    },
    onSuccess: (data) {
      Get.find<ProfileDataController>().getCurrentUserProfile();
    },
  );
}

}
