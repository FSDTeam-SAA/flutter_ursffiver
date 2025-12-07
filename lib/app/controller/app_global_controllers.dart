// import 'package:flutter_ursffiver/app/controller/home_controller.dart';
// import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
// import 'package:get/get.dart';

// // Why do we need this controller?
// //
// // >>
// // We Want to have a single place to store all the essential information of the app.
// //
// // Instead of managing controllers with [GetX] in every feature, we can manage them here.
// // This way, all controllers will be in one place to inspect.
// class AppGlobalControllers extends GetxController {
//   final AllInterestFetchController interestController =
//       AllInterestFetchController();
//   late final HomeController homeController;
//   void beforeAuthInit() {
//     interestController.fetchInterests();

//     /// Add more controller intialization for essential information of the app
//   }

//   void afterAuthInit() {
//     interestController.fetchInterests();
//     homeController = HomeController();
//     /// Add more controller intialization for essential information of the app
//   }
// }


import 'package:flutter_ursffiver/app/controller/home_controller.dart';
import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:get/get.dart';

class AppGlobalControllers extends GetxController {
  final AllInterestFetchController interestController =
      AllInterestFetchController();

  late final HomeController homeController;
  late final InboxChatDataProvider inboxChatDataProvider;
  late final ProfileDataProvider profileDataProvider;

  void beforeAuthInit() {
    interestController.fetchInterests();
  }

  void afterAuthInit() {
    interestController.fetchInterests();

    if (!Get.isRegistered<HomeController>()) {
      homeController = Get.put(HomeController());
    } else {
      homeController = Get.find<HomeController>();
    }

    if(!Get.isRegistered<InboxChatDataProvider>()){
      Get.put<InboxChatDataProvider>(InboxChatDataProvider());
    } else {
      inboxChatDataProvider = Get.find<InboxChatDataProvider>();
    }

    if(!Get.isRegistered<ProfileDataProvider>()){
      Get.put<ProfileDataProvider>(ProfileDataProvider());
    } else {
      profileDataProvider = Get.find<ProfileDataProvider>();
    }
  }

  void clearControllers() {
    if (Get.isRegistered<HomeController>()) {
      Get.delete<HomeController>();
    }

    if (Get.isRegistered<InboxChatDataProvider>()) {
      Get.delete<InboxChatDataProvider>();
    }

    if (Get.isRegistered<ProfileDataProvider>()) {
      Get.delete<ProfileDataProvider>();
    }
  }
}
