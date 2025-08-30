// import 'dart:convert';
// import 'package:flutter_ursffiver/features/profile/data/model/privacy_settings_model.dart';

// class PrivacyService {
//   static const String _privacySettingsKey = 'privacy_settings';

//   // Save privacy settings to local storage
//   static Future<void> savePrivacySettings(PrivacySettings settings) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final settingsJson = jsonEncode(settings.toJson());
//       await prefs.setString(_privacySettingsKey, settingsJson);
//       print('[v0] Privacy settings saved successfully');
//     } catch (e) {
//       print('[v0] Error saving privacy settings: $e');
//     }
//   }

//   // Load privacy settings from local storage
//   static Future<PrivacySettings> loadPrivacySettings() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final settingsJson = prefs.getString(_privacySettingsKey);
      
//       if (settingsJson != null) {
//         final settingsMap = jsonDecode(settingsJson) as Map<String, dynamic>;
//         return PrivacySettings.fromJson(settingsMap);
//       }
//     } catch (e) {
//       print('[v0] Error loading privacy settings: $e');
//     }
    
//     // Return default settings if loading fails
//     return PrivacySettings();
//   }

//   // Reset to default settings
//   static Future<void> resetToDefaults() async {
//     final defaultSettings = PrivacySettings();
//     await savePrivacySettings(defaultSettings);
//   }
// }
