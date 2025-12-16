import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/cache/smart_network_image.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/widget/send_message_dialog.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import 'package:get/get.dart';

import '../../../../core/common/model/interest_model.dart';

class UserProfileScreen extends StatefulWidget {
  final UserProfile user;
  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              margin: const EdgeInsets.only(left: 0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: widget.user.active ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.user.active ? 'Active Now' : 'Offline',
                    style: AppText.mdMedium_16_500.copyWith(
                      color: AppColors.secondaryTextblack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SmartNetworkImage(
                    imageUrl: widget.user.image,
                    height: 120,
                    width: 120,
                    borderRadius: BorderRadius.circular(8),
                    errorWidget: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // '${widget.user.firstName ?? ''} ${widget.user.lastName ?? ''}',
                        widget.user.userName ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (widget.user.adminVerify == true)
                        const Icon(
                          Icons.verified_user_outlined,
                          color: Colors.green,
                          size: 24,
                        ),
                    ],
                  ),
                  if (widget.user.status != null &&
                      widget.user.status!.isNotEmpty &&
                      widget.user.active)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primarybutton.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 8,
                        ),
                        child: Text(
                          "${widget.user.status}",
                          style: AppText.mdMedium_16_500.copyWith(
                            color: AppColors.secondaryTextblack,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  if (widget.user.bio != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        widget.user.bio!,
                        textAlign: TextAlign.center,
                        style: AppText.mdRegular_16_400.copyWith(
                          color: AppColors.secondaryTextblack,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(Icons.location_on_outlined, '1 ft away'),
                _buildStatItem(Icons.female, widget.user.gender ?? ''),
                _buildStatItem(
                  Icons.check_circle_outline,
                  widget.user.ageRange ?? '',
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Text(
              'Primary Interests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            InterestsGrid(
              chips: widget.user.interests + widget.user.customInterests,
            ),

            const SizedBox(height: 32),

            const Text(
              'Earned Badges',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            BadgeList(badges: widget.user.badges),

            const SizedBox(height: 32),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierColor: Colors.transparent,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: SendChatRequestDialog(user: widget.user, inboxchatdatacontroller: Get.find(),),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primarybutton,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.chat_bubble_outline, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Invite to Chat',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primarybutton, size: 20),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppText.smMedium_14_600.copyWith(
            color: AppColors.secondaryTextblack,
          ),
        ),
      ],
    );
  }
}

class BadgeList extends StatelessWidget {
  final List<BadgeModel> badges;

  const BadgeList({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    final Map<String, int> badgeCount = {};
    for (var badge in badges) {
      badgeCount[badge.name] = (badgeCount[badge.name] ?? 0) + 1;
    }
    final uniqueBadges = badges.toSet().toList();

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: uniqueBadges.map((badge) {
        final count = badgeCount[badge.name] ?? 1;
        return BadgeIconWithCount(badge: badge, count: count);
      }).toList(),
    );
  }
}

class BadgeIconWithCount extends StatelessWidget {
  final BadgeModel badge;
  final int count;

  const BadgeIconWithCount({
    super.key,
    required this.badge,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final badgeColor = badge.badgeColor;
    final bgColor = badgeColor.withOpacity(0.1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: badgeColor),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badge.badgeIcon, color: badgeColor, size: 16),
          const SizedBox(width: 4),
          Text(
            "x$count",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: badgeColor,
            ),
          ),
        ],
      ),
    );
  }
}

class InterestsGrid extends StatelessWidget {
  final List<InterestModel> chips;

  const InterestsGrid({super.key, required this.chips});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips.map((interest) {
        final name = interest.name.length > 12
            ? '${interest.name.substring(0, 10)}...'
            : interest.name;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: interest.color.softColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            name,
            style: TextStyle(
              color: interest.color.deepColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
