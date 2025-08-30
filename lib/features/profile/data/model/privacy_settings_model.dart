class PrivacySettings {
  bool allowLocationTracking;
  bool showProfileToEveryone;
  bool includeProfilePicture;
  bool shareAgeRange;
  bool shareGender;
  bool preferSameGender;
  bool preferVerifiedUsersOnly;

  PrivacySettings({
    this.allowLocationTracking = true,
    this.showProfileToEveryone = true,
    this.includeProfilePicture = false,
    this.shareAgeRange = true,
    this.shareGender = false,
    this.preferSameGender = false,
    this.preferVerifiedUsersOnly = false,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'allowLocationTracking': allowLocationTracking,
      'showProfileToEveryone': showProfileToEveryone,
      'includeProfilePicture': includeProfilePicture,
      'shareAgeRange': shareAgeRange,
      'shareGender': shareGender,
      'preferSameGender': preferSameGender,
      'preferVerifiedUsersOnly': preferVerifiedUsersOnly,
    };
  }

  // Create from JSON
  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      allowLocationTracking: json['allowLocationTracking'] ?? true,
      showProfileToEveryone: json['showProfileToEveryone'] ?? true,
      includeProfilePicture: json['includeProfilePicture'] ?? false,
      shareAgeRange: json['shareAgeRange'] ?? true,
      shareGender: json['shareGender'] ?? false,
      preferSameGender: json['preferSameGender'] ?? false,
      preferVerifiedUsersOnly: json['preferVerifiedUsersOnly'] ?? false,
    );
  }

  // Copy with method for immutable updates
  PrivacySettings copyWith({
    bool? allowLocationTracking,
    bool? showProfileToEveryone,
    bool? includeProfilePicture,
    bool? shareAgeRange,
    bool? shareGender,
    bool? preferSameGender,
    bool? preferVerifiedUsersOnly,
  }) {
    return PrivacySettings(
      allowLocationTracking: allowLocationTracking ?? this.allowLocationTracking,
      showProfileToEveryone: showProfileToEveryone ?? this.showProfileToEveryone,
      includeProfilePicture: includeProfilePicture ?? this.includeProfilePicture,
      shareAgeRange: shareAgeRange ?? this.shareAgeRange,
      shareGender: shareGender ?? this.shareGender,
      preferSameGender: preferSameGender ?? this.preferSameGender,
      preferVerifiedUsersOnly: preferVerifiedUsersOnly ?? this.preferVerifiedUsersOnly,
    );
  }
}
