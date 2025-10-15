class SignupRequestParam {
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? dateOfBirth;
  final String? gender;
  final String? ageRange;
  final String? bio;
  final String? password;
  final String? confirmPassword;

  SignupRequestParam({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.ageRange,
    required this.bio,
    required this.password,
    required this.confirmPassword,
  });
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'username': username,
    'email': email,
    'dateOfBirth': dateOfBirth,
    'gender': gender?.trim().toLowerCase(),
    'ageRange': ageRange,
    'bio': bio,
    'password': password,
    'confirmPassword': confirmPassword,
  };
}
