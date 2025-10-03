import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';
import 'package:flutter_ursffiver/features/profile/presentation/model/badge_model.dart';
import 'package:flutter_ursffiver/features/profile/presentation/widget/badgeg_widget.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  /////////////////

  // Example badges
  final List<BadgeModel> _badges = [
    BadgeModel(icon: Icons.verified_user, count: 5, color: Colors.purpleAccent),
    BadgeModel(
      icon: Icons.watch_later_outlined,
      count: 4,
      color: Colors.orangeAccent,
    ),
    BadgeModel(
      icon: Icons.location_on_outlined,
      count: 3,
      color: Colors.blueAccent,
    ),
    BadgeModel(icon: Icons.hearing_rounded, count: 2, color: Colors.pinkAccent),
    BadgeModel(
      icon: Icons.lightbulb_outline,
      count: 2,
      color: Colors.lightBlueAccent,
    ),
    BadgeModel(icon: Icons.link, count: 2, color: Colors.cyanAccent),
    BadgeModel(
      icon: Icons.person_4_outlined,
      count: 1,
      color: Colors.greenAccent,
    ),
    BadgeModel(icon: Icons.star, color: Colors.orangeAccent), // no count
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
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/image/profile.png',
                        ), // Change to your asset path
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.grey.shade200, width: 2),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Urs Fischer',
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
                      'Passionate about tech, love, and deep conversations. Here to meet new people and explore meaningful connections. Always up for a good chat and fun!',
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
                _buildStatItem(Icons.female, 'Female'),
                _buildStatItem(Icons.check_circle_outline, '50 - 60'),
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

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildInterestTag('Acting/Theatre', AppColors.interestsgreen),
                _buildInterestTag('Escape Room', AppColors.interestsred),
                _buildInterestTag('Arcade Game', AppColors.interestsyellow),
                _buildInterestTag('Arcade Game', AppColors.interestsyellow),
                _buildInterestTag('Expedition Trip', AppColors.interestsgreen),
                _buildInterestTag('Acting/Practice', AppColors.interestsblue),
              ],
            ),

            const SizedBox(height: 32),

            // Earned Badges
            const Text(
              'Earned Badges',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            BadgeList(badges: _badges),
            const SizedBox(height: 32),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold()),
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
                      children: [
                        const Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        const Text(
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

  Widget _buildInterestTag(String text, Color color) {
    return Container(
      constraints: const BoxConstraints(minHeight: 30, minWidth: 60),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppText.smMedium_14_600.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        softWrap: true,
      ),
    );
  }
}
