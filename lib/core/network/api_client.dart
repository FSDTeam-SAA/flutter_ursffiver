import 'dart:async';
import 'package:dio/dio.dart';

import '../services/network/auth/auth_service.dart';
import 'api_endpoints.dart';


class ApiClient {
  final Dio _dio;
  final AuthService _authInterceptor;
  ApiClient(
    this._dio,
    this._authInterceptor,){
      _dio.interceptors.add(_authInterceptor);
      _dio.options.baseUrl = ApiEndpoints.baseUrl;
  }

  Stream<AuthStatus> get authStream => _authInterceptor.authStream;

  // 🧭 Public GET/POST/PUT/DELETE wrappers

  Future<Response> get(String path, {dynamic data, Map<String, dynamic>? query}) {
    return _dio.get(path, queryParameters: query, data: data);
  }

  Future<Response> post(String path, {dynamic data}) {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data, Options? options,}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response> patch(String path, {dynamic data}) {
    return _dio.patch(path, data: data);
  }

  Future<Response> delete(String path, {dynamic data}) {
    return _dio.delete(path, data: data);
  }
}
