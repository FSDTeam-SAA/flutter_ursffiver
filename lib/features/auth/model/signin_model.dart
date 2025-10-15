class LoginRequestParams {
  final String email;
  final String password;

  LoginRequestParams({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class LoginResponse {
  final String userId;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      userId: map['userId'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
    );
  }
}
