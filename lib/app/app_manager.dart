import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:flutter_ursffiver/features/nabber_screen.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:get/get.dart';

import '../core/constants/api_endpoints.dart';
import 'controller/app_global_controllers.dart';

class AppManager extends GetxController {
  StreamSubscription? _authStreamSubscription;
  AuthStatus _authStatus = AuthLoading();
  AuthStatus get authStatus => _authStatus;

  /// Initializes the stream to listen to auth status
  AppManager() {
    _init();
  }

  // listen to auth change
  void _init() {
    final appGlobalControllers = Get.lazyPut<AppGlobalControllers>(
      () => AppGlobalControllers(),
    );
    Get.find<AppGlobalControllers>().beforeAuthInit();

    final initialAuthStatus = Get.find<AppPigeon>().currentAuth();
    _decideRoute(authStatus);
    // Start listening to the auth status changes
    _authStreamSubscription = Get.find<AppPigeon>().authStream.listen((
      newStatus,
    ) async {
      _decideRoute(newStatus);
    });
  }

  void _decideRoute(AuthStatus? authStatus) async {
    debugPrint("(In Appmanager)Auth status: $authStatus");
    if (authStatus != null) {
      _authStatus = authStatus;
      if (_authStatus is UnAuthenticated) {
        Get.to(() => SignInScreen());
        // navigatorKey.currentState?.pushNamedAndRemoveUntil(
        //   RouteNames.login,
        //   (route) => false,
        // );
      } else if (_authStatus is Authenticated) {
        await _initializeControllers();
        await Get.find<AppPigeon>().socketInit(
          SocketConnetParamX(
            token: null,
            socketUrl: ApiEndpoints.socketUrl,
            joinId: (_authStatus as Authenticated).auth.userId,
          ),
        );
        Get.to(() => AppGround());
        // navigatorKey.currentState?.pushNamedAndRemoveUntil(
        //   RouteNames.home,
        //   (route) => false,
        // );
      }
      update();
    }
  }

  // initiate controllers on auth change[Authenticated]
  Future<void> _initializeControllers() async {
    if (Get.isRegistered<AppGlobalControllers>()) {
      await Get.delete<AppGlobalControllers>();
    }
    if(Get.isRegistered<ProfileDataProvider>()) {
      await Get.delete<ProfileDataProvider>();
    }

    if(Get.isRegistered<InboxChatDataProvider>()) {
      await Get.delete<InboxChatDataProvider>();
    }

    Get.put<AppGlobalControllers>(AppGlobalControllers()).afterAuthInit();
    Get.put<ProfileDataProvider>(ProfileDataProvider()).getCurrentUserProfile();
    Get.put<InboxChatDataProvider>(InboxChatDataProvider());

  }
  
}
