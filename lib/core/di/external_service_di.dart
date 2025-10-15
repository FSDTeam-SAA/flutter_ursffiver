import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/refresh_token_manager.dart';
import 'package:get/get.dart';

void externalServiceDI() {
  // Initialize other external services here
  Get.put(AppPigeon(
    Dio(),
    FlutterSecureStorage(),
    RefreshTokenManager(ApiEndpoints.refreshToken),
    baseUrl: ApiEndpoints.baseUrl,
  ));
}