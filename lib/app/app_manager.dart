import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/controller/home_controller.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:flutter_ursffiver/app/main_app.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../core/common/controller/interest_fetch_controller.dart';
import '../core/constants/api_endpoints.dart';
import 'controller/app_global_controllers.dart';

class AppManager extends GetxController {
  StreamSubscription? _authStreamSubscription;
  AuthStatus _authStatus = AuthLoading();
  AuthStatus get currentAuthStatus => _authStatus;
  Debouncer authDebouncer = Debouncer(delay: const Duration(milliseconds: 10));

  /// Initializes the stream to listen to auth status
  AppManager(){
    _init();
  }

  // listen to auth change
  void _init() async {
    debugPrint("AppManager initialized");

    await Get.find<AppPigeon>().currentAuth().then((initialAuthStatus) {
      _decideRoute(initialAuthStatus);
    });
    // Start listening to the auth status changes
    _authStreamSubscription = Get.find<AppPigeon>().authStream.listen((
      newStatus,
    ) async {
      authDebouncer.call(() {
        _decideRoute(newStatus);
      });
    });
  }

  void _decideRoute(AuthStatus? authStatus) async {
    if (authStatus is UnAuthenticated) {
       _authStatus = authStatus;
        Get.offAll(() => SignInScreen());
      } else if (authStatus is Authenticated && (authStatus).auth.userId.isNotEmpty) {
        _authStatus = authStatus;
        // initialize necessary acculamotory controllers
        await _initSocket();
        await _initializeControllers().then((val) {
          if(val) Get.offAll(() => MainApp());
        });
      }
      update();
  }

  Future<void> _initSocket() async{
    if(!(currentAuthStatus as Authenticated).auth.userId.isNotEmpty ) return;

     await Get.find<AppPigeon>()
        .socketInit(
          SocketConnetParamX(
            token: null,
            socketUrl: ApiEndpoints.socketUrl,
            joinId: (currentAuthStatus as Authenticated).auth.userId,
          ),
        );
    Get.find<AppPigeon>().emit(
      "join",
      ((currentAuthStatus as Authenticated).auth.userId),
    );
  }

  // initiate controllers on auth change[Authenticated]
  Future<bool> _initializeControllers() async {
    if ((currentAuthStatus as Authenticated).auth.userId.isNotEmpty) {
      debugPrint("Initializing controllers cause auth changed");
      if(Get.isRegistered<AppControllerInitializer>()) {
        await Get.delete<AppControllerInitializer>();
      }
      Get.put(AppControllerInitializer());
      return true;
    }
    return false;
  }
  
}
