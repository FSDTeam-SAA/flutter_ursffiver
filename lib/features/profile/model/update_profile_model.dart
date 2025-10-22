class UpdateProfileModel {
  final String id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? gender;
  String? ageRange;
  String? bio;
  String? profilePic;
  String? coverPic;

  UpdateProfileModel({
    required this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.gender,
    this.ageRange,
    this.bio,
    this.profilePic,
    this.coverPic,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileModel(
      id: json['_id'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      username: json['username'],
      email: json['email'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      bio: json['bio'],
      profilePic: json['profilePic'],
      coverPic: json['coverPic'],
    );
  }
}
