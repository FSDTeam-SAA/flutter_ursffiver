import 'package:flutter/foundation.dart';

base class ApiEndpoints {
  static const String socketUrl = _RemoteServer.socketUrl;

  static const String baseUrl = _RemoteServer.baseUrl;

  /// ### post
  static const String login = _Auth.login;

  static const String signup = _Auth.signup;

  static const String verifyCode = _Auth.verifyCode;

  static const String registerVerify = _Auth.registerVerify;

  static const String resetPassword = _Auth.resetPassword;

  static const String forgetPassword = _Auth.forgetPassword;

  /// ### post
  static const String refreshToken = _Auth.refreshToken;

  /// ### get
  static const String getUserNotifications = _Notification.getUserNotifications;

  /// ### patch
  static String markNotificationAsRead({required String notificationId}) =>
      _Notification.markNotificationAsRead(notificationId);

  /// ### patch
  static const String markAllAsRead = _Notification.markAllAsRead;

  // ---------------------- USER -----------------------------
  /// ### get
  static const String getCurrentProfile = _User.getCurrentProfile;

  /// ### put
  static const String editProfile = _User.editProfile;

  /// ### get
  static const String changePassword = _User.changePassword;

  /// ### get
  static const String history = _User.history;


  // ---------------------- Audio -----------------------------
    static const String audioRoute = _Audio._audioRoute;
  /// ### get
  static const String getAllAudio = _Audio.getAudios;

  static const String singleAudio = _Audio.singleAudio;

  // ---------------------- Library -----------------------------
  /// ### get
  static const String getPlaylist = _LibraryPlaylist.getPlaylist;
  /// ### post
  static const String addToPlaylist = _LibraryPlaylist.addToPlaylist;
  /// ### delete
  static const String removeFromPlaylist = _LibraryPlaylist.removeFromPlaylist;

}
//arrow360degree@gmail.com

class _RemoteServer {
  static const String socketUrl =
      'https://ttrueno-backend.onrender.com';

  static const String baseUrl =
      'https://ttrueno-backend.onrender.com/api/v1';
}

class _LocalHostWifi {
  static const String socketUrl = 'http://10.10.5.46:5006';

  static const String baseUrl = 'http://10.10.5.46:5006/api/v1';
}


class _Auth {
  @protected
  static const String _authRoute = '${ApiEndpoints.baseUrl}/auth';
  static const String login = '$_authRoute/login';
  static const String signup = '$_authRoute/register/init';
  static const String forgetPassword = '$_authRoute/forget-password';
  static const String refreshToken = '$_authRoute/refresh-access-token';
  static const String verifyCode = '$_authRoute/verify-code';
  static const String registerVerify = '$_authRoute/register/verify';
  static const String resetPassword = '$_authRoute/reset-password';
}

class _Notification {
  static const String _notificationRoute =
      '${ApiEndpoints.baseUrl}/notifications';
  static const String getUserNotifications = '$_notificationRoute/';
  static String markNotificationAsRead(String notificationId) =>
      '$_notificationRoute/:$notificationId/read';
  static const String markAllAsRead = '$_notificationRoute/mark-all-as-read';
}

class _User {
  static const String _userRoute = '${ApiEndpoints.baseUrl}/user';
  static const String getCurrentProfile = '$_userRoute/profile';
  static const String editProfile = '$_userRoute/edit-profile';
  static const String changePassword = '$_userRoute/change-password';
  static const String history = '$_userRoute/history';
}

class _Audio {
  static const String _audioRoute = '${ApiEndpoints.baseUrl}/audio';
  static const String getAudios = '$_audioRoute/all-audio';
  static const String singleAudio = '$_audioRoute/single-audio';
}

class _LibraryPlaylist {
  static const String _libraryRoute = '${ApiEndpoints.baseUrl}/playlist';
  static const String getPlaylist = '$_libraryRoute/';
  static const String addToPlaylist = '$_libraryRoute/add';
  static const String removeFromPlaylist = '$_libraryRoute/remove';
}


