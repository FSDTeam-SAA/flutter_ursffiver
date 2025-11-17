import 'package:flutter/material.dart';

class BadgeModel {
  final String id;
  final String name;
  final String tag;
  final String info;
  final String color;

  BadgeModel({
    required this.id,
    required this.name,
    required this.tag,
    required this.info,
    required this.color,
  });

  Color get badgeColor {
    if (color.isEmpty) return Colors.grey;

    switch (color.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'pink':
        return Colors.pink;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'grey':
      case 'gray':
        return Colors.grey;
    }

    try {
      String hex = color.replaceAll("#", "");
      if (hex.length == 6) hex = "FF$hex";
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      debugPrint("Invalid color format: $color");
      return Colors.grey;
    }
  }

  IconData get badgeIcon {
    if (name == 'goodspeaker' ||
        name == 'GoodSpeaker' ||
        name == 'Good Speaker' ||
        name == 'good speaker') {
      return Icons.record_voice_over;
    } else if (name == 'Great Lisaner' ||
        name == 'great lisaner' ||
        name == 'GreatLisaner' ||
        name == 'greatlisaner') {
      return Icons.hearing;
    } else if (name == 'Thoughtful Question' ||
        name == 'thoughtful question' ||
        name == 'thoughtfulQuestion' ||
        name == 'ThoughtfulQuestion') {
      return Icons.question_answer;
    } else if (name == 'Knowledge Share' ||
        name == 'knowledge share' ||
        name == 'knowledgeShare' ||
        name == 'KnowledgeShare') {
      return Icons.lightbulb_outline_rounded;
    } else if (name == 'Local Expert' ||
        name == 'local expert' ||
        name == 'localExpert' ||
        name == 'LocalExpert') {
      return Icons.location_on;
    } else if (name == 'Rellable' || name == 'rellable') {
      return Icons.check_circle_outline;
    } else if (name == 'trusted' || name == 'Trusted') {
      return Icons.person_2_outlined;
    } else if (name == 'creative' || name == 'Creative') {
      return Icons.light_sharp;
    } else if (name == 'helpful' || name == 'Helpful') {
      return Icons.help_outline_outlined;
    } else if (name == 'Respectful' || name == 'respectful') {
      return Icons.shield_outlined;
    } else if (name == 'Community Builder' ||
        name == 'community builder' ||
        name == 'communityBuilder' ||
        name == 'CommunityBuilder') {
      return Icons.lightbulb;
    } else if (name == 'Connector' || name == 'connector') {
      return Icons.link;
    } else {
      return Icons.star;
    }
  }

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
      info: json['info'] ?? '',
      color: json['color'] ?? '#000000',
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'tag': tag, 'info': info, 'color': color};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeModel &&
          badgeIcon == other.badgeIcon &&
          badgeColor == other.badgeColor;

  @override
  int get hashCode => badgeIcon.hashCode ^ badgeColor.hashCode;
}

// class UserBadgesModel {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String fullname;
//   final String ageRange;
//   final String bio;
//   final String email;
//   final String username;
//   final String gender;
//   final DateTime? dateOfBirth;
//   final bool isEmailVerified;
//   final String role;
//   final String status;
//   final bool adminVerify;
//   final List<UserInterestModel> interests;
//   final bool active;
//   final List<UserAddressModel> address;
//   final String? imagePath;
//   final List<UserBadgeModel> badges;

//   UserBadgesModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.fullname,
//     required this.ageRange,
//     required this.bio,
//     required this.email,
//     required this.username,
//     required this.gender,
//     required this.dateOfBirth,
//     required this.isEmailVerified,
//     required this.role,
//     required this.status,
//     required this.adminVerify,
//     required this.interests,
//     required this.active,
//     required this.address,
//     this.imagePath,
//     required this.badges,
//   });

//   factory UserBadgesModel.fromJson(Map<String, dynamic> json) {
//     debugPrint("user badges model json : ${json['firstName']}");

//     return UserBadgesModel(
//       id: json['_id'] ?? '',
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       fullname: json['fullname'] ?? '',
//       ageRange: json['ageRange'] ?? '',
//       bio: json['bio'] ?? '',
//       email: json['email'] ?? '',
//       username: json['username'] ?? '',
//       gender: json['gender'] ?? '',
//       dateOfBirth: json['dateOfBirth'] == null
//           ? null
//           : DateTime.tryParse(json['dateOfBirth'] ?? ''),
//       isEmailVerified: json['isEmailVerified'] ?? false,
//       role: json['role'] ?? '',
//       status: json['status'] ?? '',
//       adminVerify: json['adminVerify'] ?? false,
//       interests: json['interest'] == null
//           ? []
//           : (json['interest'] as List)
//               .map((e) => UserInterestModel.fromJson(e))
//               .toList(),
//       active: json['active'] ?? false,
//       address: [],
//       imagePath: json['profileImage'] as String?,
//       badges: json['badge'] == null
//           ? []
//           : (json['badge'] as List)
//               .map((e) => UserBadgeModel.fromJson(e))
//               .toList(),
//     );
//   }
// }
