import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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

            _buildBadgeCard(
              'Great Listener',
              'Awarded to someone who was truly attentive and engaged during your conversation.',
              Colors.blue,
              'Communication',
              123,
            ),
            const SizedBox(height: 12),
            _buildBadgeCard(
              'Knowledge Share',
              'Awarded to someone who was truly attentive and engaged during your conversation.',
              Colors.green,
              'Knowledge',
              123,
            ),
            const SizedBox(height: 12),
            _buildBadgeCard(
              'Great Listener',
              'Awarded to someone who was truly attentive and engaged during your conversation.',
              Colors.blue,
              'Communication',
              123,
            ),

            const SizedBox(height: 32),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.primarybutton),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.emoji_events_outlined,
                          color: AppColors.primarybutton,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Award Badge',
                          style: TextStyle(
                            color: AppColors.primarybutton,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
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
      width: 120,
      height: 30,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        maxLines: 1,
        text,
        style: AppText.xsRegular_12_400.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBadgeCard(
    String title,
    String description,
    Color color,
    String category,
    int points,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    maxLines: 5,
                    description,
                    style: AppText.smMedium_14_600.copyWith(
                      color: AppColors.secondaryTextblack,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    points.toString(),
                    style: AppText.smMedium_14_600.copyWith(
                      color: AppColors.secondaryTextblack,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
