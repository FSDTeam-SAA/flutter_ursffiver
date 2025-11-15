import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/cache/smart_network_image.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/home_screen.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/widget/send_message-dialog.dart';
import 'package:flutter_ursffiver/features/profile/model/badge_model.dart';
import 'package:flutter_ursffiver/features/profile/presentation/widget/badgeg_widget.dart';

class UserProfileScreen extends StatefulWidget {
  final UserModel user;
  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  /////////////////

  final List<IconBadgeModel> _badges = [
    IconBadgeModel(
      icon: Icons.verified_user,
      count: 5,
      color: Colors.purpleAccent,
    ),
    IconBadgeModel(
      icon: Icons.watch_later_outlined,
      count: 4,
      color: Colors.orangeAccent,
    ),
    IconBadgeModel(
      icon: Icons.location_on_outlined,
      count: 3,
      color: Colors.blueAccent,
    ),
    IconBadgeModel(
      icon: Icons.hearing_rounded,
      count: 2,
      color: Colors.pinkAccent,
    ),
    IconBadgeModel(
      icon: Icons.lightbulb_outline,
      count: 2,
      color: Colors.lightBlueAccent,
    ),
    IconBadgeModel(icon: Icons.link, count: 2, color: Colors.cyanAccent),
    IconBadgeModel(
      icon: Icons.person_4_outlined,
      count: 1,
      color: Colors.greenAccent,
    ),
    IconBadgeModel(icon: Icons.star, color: Colors.orangeAccent),
  ];

  //////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Active Now',
                  style: AppText.mdMedium_16_500.copyWith(
                    color: AppColors.secondaryTextblack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  SmartNetworkImage(
                    imageUrl: widget.user.imagePath,
                    height: 120,
                    width: 90,
                    borderRadius: BorderRadius.circular(8),

                    errorWidget: Container(
                      height: 130,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.user.firstName} ${widget.user.lastName}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.verified_user_outlined,
                        color: AppColors.interestsgreen,
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.user.bio,
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
                _buildStatItem(Icons.female, widget.user.gender),
                _buildStatItem(
                  Icons.check_circle_outline,
                  widget.user.ageRange,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Primary Interests
            const Text(
              'Primary Interests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [InterestsGrid(chips: widget.user.interests)],
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
            Column(children: [BadgeList(badges: _badges)]),
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
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 5,
                            ), // blur background
                            child: SendChatRequestDialog(user: widget.user),
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
