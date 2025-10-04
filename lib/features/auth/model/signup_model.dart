class SignupModel {
  String firstName;
  String lastName;
  String username;
  String email;
  String dob;
  String bio;
  String password;
  String confirmPassword;
  String? gender;
  String? ageRange;
  Set<String> interests;

  SignupModel({
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.dob = '',
    this.bio = '',
    this.password = '',
    this.confirmPassword = '',
    this.gender,
    this.ageRange,
    this.interests = const {},
  });

  // Password validation rules
  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(password);
  bool get hasLowercase => RegExp(r'[a-z]').hasMatch(password);
  bool get hasNumber => RegExp(r'\d').hasMatch(password);
  bool get hasSpecial => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  bool get isPasswordValid =>
      hasMinLength && hasUppercase && hasLowercase && hasNumber && hasSpecial;
}
