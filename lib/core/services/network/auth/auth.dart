part of 'auth_service.dart';

base class Auth{
  final String? _accessToken;
  final String? _refreshToken;
  final String userId;

  Auth._internal({
    required String? accessToken,
    required String? refreshToken,
    required this.userId,
  }): _accessToken = accessToken, _refreshToken = refreshToken;

  bool get isVerified => _accessToken != null && _refreshToken != null;

  Auth copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return Auth._internal(
      accessToken: accessToken ?? _accessToken,
      refreshToken: refreshToken ?? _refreshToken,
      userId: userId ,
    );
  }

  factory Auth.fromMap(Map<String, dynamic> json) {
    return Auth._internal(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      userId: json['userId'] as String,
    );
  }

  factory Auth._fromJson(String source) {
    return Auth.fromMap(jsonDecode(source));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'access_token': _accessToken,
      'refresh_token': _refreshToken,
      'userId': userId,
    };
    return data;
  }

  @override
  String toString() {
    return 'Auth{accessToken: $_accessToken, refreshToken: $_refreshToken, tokenType: $userId,}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Auth &&
        other._accessToken == _accessToken &&
        other._refreshToken == _refreshToken &&
        other.userId == userId;
  }

  @override
  int get hashCode => Object.hash(_accessToken, _refreshToken, userId);
}

