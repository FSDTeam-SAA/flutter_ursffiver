import 'package:flutter/foundation.dart';
import 'package:flutter_ursffiver/core/common/model/coordinates.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/home/model/set_visibility_req.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../model/get_user_suggestion_req_param.dart';

// Filter people suggestion with interest
class FilterPeopleSuggestionController extends GetxController {
  final InterestSelectionController selectInterestController =
      InterestSelectionController();

  RxMap<String, bool> get selectedInterest =>
      selectInterestController.selectedInterests;

  List<String> get selectedInterestIds {
    return selectedInterest.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
  }

  Coordinates? currentLocation;
  Rx<LocationRange?> selectedLocationRange = Rx<LocationRange?>(LocationRange.nearby);

  Future<void> setVisibility(
    bool visible,
    bool Function() shouldShareLocation,{
      required SnackbarNotifier notifier,
    }
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
          notifier.notify(message: "Location permission denied. Cannot share location!");
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
        Get.find<ProfileDataProvider>().getCurrentUserProfile();
      },
    );
  }

}
