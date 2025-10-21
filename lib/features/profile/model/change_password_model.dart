class ChangePasswordModel {
  final String password;
  final String newPassword;

  ChangePasswordModel({
    required this.password,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'oldPassword': password,
    'newPassword': newPassword,
  };
}
