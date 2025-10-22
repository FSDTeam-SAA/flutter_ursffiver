import 'package:flutter/foundation.dart';

base class ApiEndpoints {
  static const String socketUrl = _LocalHostWifi.socketUrl;

  static const String baseUrl = _LocalHostWifi.baseUrl;

  /// ### post
  static const String login = _Auth.login;

  static const String signup = _Auth.signup;

  static const String verifyCode = _Auth.verifyCode;

  static const String registerVerify = _Auth.registerVerify;

  //static const String resetPassword = _Auth.resetPassword;

  static const String forgetPassword = _Auth.forgetPassword;

  static const String changePassword = _Auth.changePassword;

  static const String createNewPassword = _Auth.resetPassword;

  /// ### post
  static const String refreshToken = _Auth.refreshToken;


  //------------interest----------------
  /// ### get
  static const String getInterests = _Interest.getallInterests;



  //------------notification----------------
  /// ### get
  static const String getAllNotifications = _Notification.getAllNotifications;
  /// ### post
  static const String readAllNotifications = _Notification.readAllNotifications;
  /// ### patch
  static String markNotificationAsRead({required String notificationId}) =>
      _Notification.markNotificationAsRead(notificationId);
  /// ### patch
  static const String markAllAsRead = _Notification.markAllAsRead;

  // ---------------------- USER -----------------------------
  
  /// ### get
  static String getuserbyId(String id) => _User.getuserbyId(id);
  /// ### get
  static const String getCurrentProfile = _User.getCurrentProfile;
  /// ### put
  static const String editProfile = _User.editProfile;
  /// ### put
  static const String uploadProfileAvatar = _User.uploadProfileAvatar;
  /// ### get
  static const String history = _User.history;
  /// ### get
  static const String allUser = _User.allUser;


  // ---------------------- RIDE -----------------------------
  /// ### post
  static const String createRide = _Ride.createRide;
  static String updateRide(String id) => _Ride.updateRide(id);
  static String leaveRide(String id) => _Ride.leaveRide(id);
  static String finishRide(String id) => _Ride.finishRide(id);
  static String getRideById(String id) => _Ride.getRideById(id);
  static String joinRide(String id) => _Ride.joinRide(id);
  static String voteForKick(String id) => _Ride.voteForKick(id);
  static String deleteRide(String id) => _Ride.deleteRide(id);
  static const String filterRide = _Ride.filterRide;

  // ---------------------- Booking -----------------------------
  static String getAllBookingsForARide(String rideId) => _Booking.getAllBookingsForARide(rideId);
  static const String getMyBookings = _Booking.getMyBookings;


  // ---------------------- Message -----------------------------
  /// ### Get
  static const String getAllChat = _Message.getAllChat;
  /// ### Get
  static String getMessages(String chatId) => _Message.getMessages(chatId);
  /// ### Post
  static String sendMessage(String chatId) => _Message.sendMessage(chatId);
  /// ### Put
  static String messageRead(String messageId) => _Message.messageRead(messageId);
  /// ### Put
  static String editMessage(String messageId) => _Message.editMessage(messageId);
  /// ### Delete
  static String deleteMessage(String messageId) => _Message.deleteMessage(messageId);

}

//arrow360degree@gmail.com

class _RemoteServer {
  static const String socketUrl =
      'https://ursffiver-backend.onrender.com';

  static const String baseUrl =
      'https://ursffiver-backend.onrender.com/api/v1';
}

class _LocalHostWifi {
  static const String socketUrl = 'http://10.10.5.46:5001';

  static const String baseUrl = 'http://10.10.5.46:5001/api/v1';
}


class _Auth {
  @protected
  static const String _authRoute = '${ApiEndpoints.baseUrl}/auth';
  static const String login = '$_authRoute/login';
  static const String signup = '$_authRoute/signup';
  static const String forgetPassword = '$_authRoute/forgot-password';
  static const String refreshToken = '$_authRoute/refresh-token';
  static const String verifyCode = '$_authRoute/verify-otp';
  static const String registerVerify = '$_authRoute/register/verify';
  static const String changePassword = '$_authRoute/change-password';
  static const String resetPassword = '$_authRoute/reset-password';
}

//------------------------------ Interest -----------------------------
class _Interest {
  static const String _interestRoute = '${ApiEndpoints.baseUrl}/interest';
  static const String getallInterests = '$_interestRoute/';
}


// ---------------------- Notification -----------------------------
class _Notification {
  static const String _notificationRoute =
      '${ApiEndpoints.baseUrl}/notification';
  static String markNotificationAsRead(String notificationId) =>
      '$_notificationRoute/$notificationId/read';
  static const String readAllNotifications =
      '$_notificationRoute/read-all';
  static const String markAllAsRead = '$_notificationRoute/mark-all-as-read';
  static const String getAllNotifications = '$_notificationRoute/';
}


// ---------------------- USER -----------------------------
class _User {
  static const String _userRoute = '${ApiEndpoints.baseUrl}/user';
  static String getuserbyId(String id) => '$_userRoute/single-user/$id';
  static const String getCurrentProfile = '$_userRoute/';
  static const String editProfile = '$_userRoute/';
  static const String uploadProfileAvatar = '$_userRoute/upload-avatar';
  static const String history = '$_userRoute/history';
  static const String allUser = '$_userRoute/all-user';
}


// ---------------------- RIDE -----------------------------
class _Ride {
  static const String _rideRoute = '${ApiEndpoints.baseUrl}/ride';
  static const String createRide = _rideRoute;
  static String updateRide(String id) => "$_rideRoute/$id";
  static String leaveRide(String id) => "$_rideRoute/$id/leave";
  static String finishRide(String id) => "$_rideRoute/$id/filter";
  static const String filterRide = _rideRoute;
  static String getRideById(String id) => "$_rideRoute/$id";
  static String joinRide(String id) => "$_rideRoute/$id/join";
  static String voteForKick(String id) => "$_rideRoute/$id/kick";
  static String deleteRide(String id) => "$_rideRoute/$id";
}

class _Booking {
  static const String _bookingRoute = '${ApiEndpoints.baseUrl}/booking';
  static const String getMyBookings = "$_bookingRoute/my";
  static String getAllBookingsForARide(String rideId) => "$_bookingRoute/ride/$rideId";
}

// ---------------------- MESSAGE -----------------------------
class _Message {
  static const String _messageRoute = '${ApiEndpoints.baseUrl}/message';
  
  static const String getAllChat = "$_messageRoute/rooms";
  /// Get
  static String getMessages(String chatId) => "$_messageRoute/$chatId";
  /// Post
  static String sendMessage(String chatId) => "$_messageRoute/$chatId";
  /// Put
  static String messageRead(String messageId) => "$_messageRoute/read/$messageId";
  /// Put
  static String editMessage(String messageId) => "$_messageRoute/$messageId";
  /// Delete
  static String deleteMessage(String messageId) => "$_messageRoute/$messageId";
}

