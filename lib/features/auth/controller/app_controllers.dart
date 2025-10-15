import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
import 'package:get/get.dart';

class AppGlobalControllers extends GetxController {
  final AllInterestFetchController interestController =
      AllInterestFetchController();

  void beforeAuthInit() {
    interestController.fetchInterests();

    /// Add more controller intialization for essential information of the app
  }

  void afterAuthInit() {
    interestController.fetchInterests();

    /// Add more controller intialization for essential information of the app
  }
}
