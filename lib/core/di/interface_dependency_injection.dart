import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/auth/interface/interest_interface.dart';
import 'package:flutter_ursffiver/features/auth/service/interest_interface_impl.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface.dart';
import 'package:flutter_ursffiver/features/badges/services/badges_interface_impl.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/service/chat_interface_impl.dart';
import 'package:flutter_ursffiver/features/notification/interface/notification_interface.dart';
import 'package:flutter_ursffiver/features/notification/service/notification_interface_impl.dart';
import 'package:flutter_ursffiver/features/home/service/home_service.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/services/profile_interface_impl.dart';
import 'package:get/get.dart';
import '../../features/auth/service/auth_interface_impl.dart';
import '../../features/home/service/home_interface.dart';

void initInterfaces() {
  // Initialize other interfaces here
  Get.lazyPut<AuthInterface>(() => AuthInterfaceImpl(Get.find()));
  Get.lazyPut<InterestInterface>(
    () => InterestInterfaceImpl(appPigeon: Get.find()),
  );
  Get.lazyPut<NotificationInterface>(
    () => NotificationInterfaceImpl(appPigeon: Get.find()),
  );
  Get.lazyPut<HomeInterface>(
    () => HomeService(appPigeon: Get.find()),
    fenix: true,
  );
  Get.lazyPut<ProfileInterface>(
    () => ProfileInterfaceImpl(appPigeon: Get.find()),
  );
  Get.lazyPut<BadgesInterface>(
    () => BadgesInterfaceImpl(appPigeon: Get.find()),
  );
  Get.lazyPut<ChatInterface>(
    () => ChatInterfaceImpl(appPigeon: Get.find()),
    fenix: true,
  );
}
