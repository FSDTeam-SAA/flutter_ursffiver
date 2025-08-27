import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../network/api_client.dart';
import 'network/auth/auth_service.dart';
import 'ui/auth/auth_controller.dart';

class AppServices {
  // Getters
  static final Dio _dio = Dio();
  static final ApiClient apiClient = ApiClient(
    _dio,
    authService
  );

  // ----------------- Services -----------------
  // Network services
  static final AuthService authService = AuthService(
    const FlutterSecureStorage(),
    _dio,
  );

  // UI services/controllers
  static final AuthController authController = AuthController();

  // static Future<void> init() async {
  //   DebugService.instance(
  //     allowsOnly: {
  //       DebugLabel.ui,
  //       DebugLabel.service,
  //       DebugLabel.controller,
  //       DebugLabel.audio,
  //     });

  //   await AudioService().initialize();
  // }

  static Future<void> coreInit() async {
    //await notificationController.init();
  }

  // static Future<void> dispose() async {
  //   await AudioService().dispose();
  // }
}
