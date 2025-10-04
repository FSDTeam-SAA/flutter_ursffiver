part of '../app_pigeon.dart';

class SaveNewAuthParams {
  final String? accessToken;
  final String? refreshToken;
  /// Unique identifier of the user, if not given then it will be generated
  final String uid;
  final dynamic data;
  SaveNewAuthParams({
    required this.accessToken,
    required this.refreshToken,
    String? uid,
    required this.data,
  }): uid = uid ?? DateTime.now().microsecondsSinceEpoch.toString();

  
}

class UpdateAuthParams {
  final String accessToken;
  final String refreshToken;
  final dynamic data;
  UpdateAuthParams({
    required this.accessToken,
    required this.refreshToken,
    required this.data,
  });
}