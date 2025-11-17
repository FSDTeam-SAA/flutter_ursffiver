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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BadgeModel &&
        other.id == id &&
        other.name == name &&
        other.tag == tag &&
        other.info == info &&
        other.color == color;
  }
}