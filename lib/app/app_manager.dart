import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:get/get.dart';

import '../core/constants/api_endpoints.dart';
import '../core/constants/route_names.dart';
import '../features/auth/controller/app_controllers.dart';
import '../main.dart';

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
    Get.put<AppGlobalControllers>(AppGlobalControllers()).beforeAuthInit();
    
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
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RouteNames.login,
          (route) => false,
        );
      } else if (_authStatus is Authenticated) {
        await _initializeControllers();
        await Get.find<AppPigeon>().socketInit(
          SocketConnetParamX(
            token: null,
            socketUrl: ApiEndpoints.socketUrl,
            joinId: (_authStatus as Authenticated).auth.userId,
          ),
        );
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RouteNames.home,
          (route) => false,
        );
      }
      update();
    }
  }

  // initiate controllers on auth change[Authenticated]
  _initializeControllers() {
    Get.find<AppGlobalControllers>().afterAuthInit();
  }
}
