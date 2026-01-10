class UsernameCheckResponse {
  final String username;
  final bool isUnique;
  final String message;

  UsernameCheckResponse({
    required this.username,
    required this.isUnique,
    required this.message,
  });

  factory UsernameCheckResponse.fromJson(Map<String, dynamic> json) {
    return UsernameCheckResponse(
      username: json['username'] as String,
      isUnique: json['isUnique'] as bool,
      message: json['message'] as String,
    );
  }
}