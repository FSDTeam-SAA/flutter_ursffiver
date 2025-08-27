part of 'auth_service.dart';

base class _SecureStorageKey {
  static String get currentUserKey {
    return "current_user";
  }

  static String userAuthKey({required String userId}){
    return "auth_$userId";
  }
}