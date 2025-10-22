class UserProfile {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? username;
  final String? email;
  final String? gender;
  final String? ageRange;
  final String? bio;
  final String? image;

  UserProfile({
    this.id,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.gender,
    this.ageRange,
    this.bio,
    this.image,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      firstname: json['firstName'],
      lastname: json['lastName'],
      username: json['username'],
      email: json['email'],
      gender: json['gender'],
      ageRange: json['ageRange'],
      bio: json['bio'],
      image: json['image'],
    );
  }
}