
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/profile/model/badge_model.dart';

// Single Badge widget
class BadgeWidget extends StatelessWidget {
  final IconBadgeModel badge;

  const BadgeWidget({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: badge.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: badge.color.withOpacity(1), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badge.icon, color: badge.color, size: 20),
          if (badge.count != null) ...[
            const SizedBox(width: 14),
            Text(
              'x${badge.count}',
              style: TextStyle(
                color: badge.color.withOpacity(1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Badge Header (dynamic text)
class BadgeHeader extends StatelessWidget {
  final String? nameAndAge;
  final String? username;
  final String sectionTitle;
  final IconData sectionIcon;
  final Color sectionIconColor;

  const BadgeHeader({
    super.key,
    this.nameAndAge,
    this.username,
    required this.sectionTitle,
    this.sectionIcon = Icons.emoji_events_outlined,
    this.sectionIconColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(
        //   nameAndAge ?? '',
        //   style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        // ),
        Text(username ?? "", style: TextStyle(fontSize: 24, color: Colors.black)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(sectionIcon, color: sectionIconColor),
            const SizedBox(width: 8),
            Text(
              sectionTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}

// Badge List
class BadgeList extends StatelessWidget {
  final List<IconBadgeModel> badges;

  const BadgeList({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: badges.map((badge) => BadgeWidget(badge: badge)).toList(),
    );
  }
}

// Badge Section (optional wrapper combining header + list)
class BadgeSection extends StatelessWidget {
  final String nameAndAge;
  final String username;
  final String sectionTitle;
  final IconData sectionIcon;
  final Color sectionIconColor;
  final List<IconBadgeModel> badges;

  const BadgeSection({
    super.key,
    required this.nameAndAge,
    required this.username,
    required this.sectionTitle,
    this.sectionIcon = Icons.emoji_events_outlined,
    this.sectionIconColor = Colors.blueAccent,
    required this.badges,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BadgeHeader(
          nameAndAge: nameAndAge,
          username: username,
          sectionTitle: sectionTitle,
          sectionIcon: sectionIcon,
          sectionIconColor: sectionIconColor,
        ),
        const SizedBox(height: 12),
        BadgeList(badges: badges),
      ],
    );
  }
}
