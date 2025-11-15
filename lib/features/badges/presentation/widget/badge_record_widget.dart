import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_record.dart';

class BadgeRecordWidget extends StatelessWidget {
  final BadgeRecord badge;
  const BadgeRecordWidget({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    final badgeData = badge.badge; // shorthand
    final Color badgeColor = badgeData.badgeColor;
    final Color bgColor = badgeColor.withOpacity(0.1);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// Badge Icon
              // Container(
              //   padding: const EdgeInsets.all(6),
              //   decoration: BoxDecoration(
              //     color: bgColor,
              //     shape: BoxShape.circle,
              //   ),
              //   child: Icon(
              //     badgeData.badgeIcon,
              //     color: badgeColor,
              //     size: 20,
              //   ),
              // ),
              // const SizedBox(width: 8),

              /// Badge Name
              Expanded(
                child: Text(
                  badgeData.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              /// Badge Tag Chip
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeData.tag,
                  style: TextStyle(
                    color: badgeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// Badge Info Text
          Text(
            badgeData.info,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
