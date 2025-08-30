import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Toggle states
  bool allowLocationTracking = true;
  bool showProfileToEveryone = true;
  bool includeProfilePicture = false;
  bool shareAgeRange = true;
  bool shareGender = false;
  bool preferSameGender = false;
  bool preferVerifiedUsersOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Settings",
            style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black)),
        centerTitle: false,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile(
            title: "Allow location tracking",
            value: allowLocationTracking,
            onChanged: (val) => setState(() => allowLocationTracking = val),
          ),
          _buildSwitchTile(
            title: "Show my profile to everyone",
            value: showProfileToEveryone,
            onChanged: (val) => setState(() => showProfileToEveryone = val),
          ),
          _buildSwitchTile(
            title: "Include my profile picture",
            value: includeProfilePicture,
            onChanged: (val) => setState(() => includeProfilePicture = val),
          ),
          _buildSwitchTile(
            title: "Share my age range",
            value: shareAgeRange,
            onChanged: (val) => setState(() => shareAgeRange = val),
          ),
          _buildSwitchTile(
            title: "Share my gender",
            value: shareGender,
            onChanged: (val) => setState(() => shareGender = val),
          ),
          _buildSwitchTile(
            title: "Prefer same gender",
            value: preferSameGender,
            onChanged: (val) => setState(() => preferSameGender = val),
          ),
          _buildSwitchTile(
            title: "Prefer Verified users only",
            value: preferVerifiedUsersOnly,
            onChanged: (val) =>
                setState(() => preferVerifiedUsersOnly = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primarybutton,
          ),
        ],
      ),
    );
  }
}
