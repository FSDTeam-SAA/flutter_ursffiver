import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../../../helpers/dekhao.dart';
import '../../../helpers/format_response_data.dart';
import '../../../network/api_endpoints.dart';
part 'secure_storage_key.dart';
part 'auth.dart';
part 'auth_status.dart';

class _AuthStatusDecider {
  static AuthStatus get(Auth? auth) {
    if(auth == null) {
      return UnAuthenticated();
    } 
    return Authenticated(auth: auth);
  }
}

class RefreshAccessTokenResponse {
  final String accessToken;
  final String refreshToken;

  RefreshAccessTokenResponse({required this.accessToken, required this.refreshToken});

  factory RefreshAccessTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshAccessTokenResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}

typedef OnRefreshAccessToken = Future<RefreshAccessTokenResponse> Function(String refreshToken);

class AuthService extends Interceptor {
  final Dio dio;
  Auth? _currentAuth;
  final StreamController<AuthStatus> _authStreamController = StreamController.broadcast(sync: true);
  Stream<AuthStatus> get authStream => _authStreamController.stream;
  final FlutterSecureStorage _secureStorage;

  AuthService(this._secureStorage, this.dio){
    _init();
  }

  void _init() {
    _authStreamController.add(AuthLoading());
    _listenToAuthChangeInSecureStore();
  }

  Future<void> dispose() async{
    _authStreamController.close();
    _secureStorage.unregisterAllListeners();
  }

  Future<void> _authAndServices() async{
    return await _secureStorage.read(key: _SecureStorageKey.currentUserKey).then((currentUserKey) async{
      if(currentUserKey != null) {
        final endcodedAuth = await _secureStorage.read(key: _SecureStorageKey.userAuthKey(userId: currentUserKey));
        if(endcodedAuth != null) {
          _currentAuth = Auth._fromJson(endcodedAuth);
          final AuthStatus authStatus = _AuthStatusDecider.get(_currentAuth);
          // If authenticated we run the services [SocketService]
          dekhao( "Current auth: ${_currentAuth?.toJson()}");
          _authStreamController.add(authStatus);
        } else {
          _authStreamController.add(UnAuthenticated());
        }
      } else {
        dekhao("No user and auth!!");
        _authStreamController.add(UnAuthenticated());
      }
    });
  }

  _listenToAuthChangeInSecureStore() async{
    _authAndServices();

    // Listen to current account changes
    _secureStorage.registerListener(
      key: _SecureStorageKey.currentUserKey, 
      listener: (currentUserID) {
        dekhao("Secure storage modified.. $currentUserID");
        if(currentUserID != null) {
          _authAndServices();
        } else {
          _authStreamController.add(UnAuthenticated());
        }
      }
    );
  }

  /// Attach access token to every request
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = _currentAuth?._accessToken;
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }
  
  /// Handle errors like 401 and retry with new access token if refreshed
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if(err.requestOptions.cancelToken != null) {
      return handler.reject(err);
    }
    if (err.response?.statusCode == 401 && !_isRefreshRequest(err.requestOptions)) {
      await _refreshToken().then((_) async{
        // Wait a second to receive changes from secure storage.
        await Future.delayed(Duration(seconds: 1)).then((_) async{
          if(_currentAuth == null) return;
          final RequestOptions requestOptions = err.requestOptions;
          final newAccessToken = _currentAuth!._accessToken;
          final opts = Options(
            method: requestOptions.method,
            headers: {
              ...requestOptions.headers,
              'Authorization': 'Bearer $newAccessToken',
            },
          );

          try {
            final cloneReq = await dio.request(
              requestOptions.path,
              cancelToken: CancelToken(),
              options: opts,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );
            return handler.resolve(cloneReq);
          } catch (e) {
            return handler.reject(e as DioException);
          }
        });
      });
    }

    return handler.next(err);
  }

  bool _isRefreshRequest(RequestOptions request) {
    return request.path.contains(ApiEndpoints.refreshToken);
  }

  Future<void> _refreshToken() async{
    if(_currentAuth == null) return;
    try {
      dekhao("Refreshing token");
      final response = await dio.post(
        ApiEndpoints.refreshToken,
        data: {
          "refreshToken": _currentAuth!._refreshToken
        }
      );
      // Extract refresh token from response.
      final data = extractBodyData(response);
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];
      // Save auth
      await saveNewAuth(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
        userId: _currentAuth!.userId
      );

    } catch (e) {
      dekhao("Failed to get refresh-token. $e");
      rethrow;
    }
  }

  /// Saves the new auth as currentAuth.
  /// Throws Exception, if user is still logged in.
  /// Must logout first.
  Future<void> saveNewAuth({String? accessToken, String? refreshToken, required String userId}) async{
    dekhao("Saving new auth");
    // if(_currentAuth != null) {
    //   dekhao("Can not save the new auth. Found a logged in user. Must logout first");
    //   throw Exception("Can not save the new auth. Found a logged in user. Must logout first");
    // }
    // New auth
    final newAuth = Auth._internal(accessToken: accessToken, refreshToken: refreshToken, userId: userId);
    await _secureStorage.write(
      key: _SecureStorageKey.userAuthKey(userId: userId), 
      value: jsonEncode(newAuth.toJson())
    ).then((_) async{
      await _secureStorage.write(key: _SecureStorageKey.currentUserKey, value: userId);
    });
  }


  Future<void> updateCurrentAuth({required String accessToken, required String refreshToken}) async{
    dekhao("Updating current auth");
    if(_currentAuth == null ) {
      throw Exception("Current auth does not exist.");
    }
    final userId = _currentAuth!.userId;
    var encodedAuth = await _secureStorage.read(key: _SecureStorageKey.userAuthKey(userId: userId));
    if(encodedAuth == null) {
      throw Exception("Current auth does not exist.");
    } else {
      // Update auth
      final Auth updatedAuth = Auth._fromJson(encodedAuth).copyWith(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      await _secureStorage.write(
        key: _SecureStorageKey.userAuthKey(userId: userId), 
        value: jsonEncode(updatedAuth.toJson())).then((_) async{
          await _secureStorage.write(key: _SecureStorageKey.currentUserKey, value: userId);
        });
    }
  }

  Future<void> clearCurrentAuthRecord() async {
    dekhao2("Clearing auth record");
    await _secureStorage.deleteAll().then((_){
      _currentAuth = null;
      _authStreamController.add(UnAuthenticated());
    });
  }
}
