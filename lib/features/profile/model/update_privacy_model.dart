class UpdatePrivacyModel {
  final bool profilepicturevisibility;
  final bool profilevisibility;
  final bool agerangevisibility;
  final bool gendervisibility;
  final bool samegender;
  final bool verifieduser;
  final bool locationtracking; // new

  UpdatePrivacyModel({
    required this.profilepicturevisibility,
    required this.profilevisibility,
    required this.agerangevisibility,
    required this.gendervisibility,
    required this.samegender,
    required this.verifieduser,
    this.locationtracking = true,
  });

  factory UpdatePrivacyModel.fromJson(Map<String, dynamic> json) {
    return UpdatePrivacyModel(
      profilepicturevisibility: json['profile_picture_visibility'] ?? false,
      profilevisibility: json['profile_visibility'] ?? false,
      agerangevisibility: json['age_range_visibility'] ?? false,
      gendervisibility: json['gender_visibility'] ?? false,
      samegender: json['same_gender'] ?? false,
      verifieduser: json['verified_user'] ?? false,
      locationtracking: json['location_tracking'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_picture_visibility': profilepicturevisibility,
      'profile_visibility': profilevisibility,
      'age_range_visibility': agerangevisibility,
      'gender_visibility': gendervisibility,
      'same_gender': samegender,
      'verified_user': verifieduser,
      'location_tracking': locationtracking,
    };
  }
}
