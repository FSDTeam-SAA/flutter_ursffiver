import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/user-profile_screen.dart';

class UserProfileCard extends StatelessWidget {
  final UserModel user;

  const UserProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfileScreen()),
        );
      },
      child: Row(
        children: [
          Container(
            width: 90,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image:
                    (user.imagePath != null &&
                        user.imagePath!.isNotEmpty &&
                        user.imagePath!.startsWith('http'))
                    ? NetworkImage(user.imagePath!) as ImageProvider
                    : const AssetImage('assets/image/profile.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(Icons.location_on, size: 20, color: Colors.grey),
                    const SizedBox(width: 4),
                    // Text(
                    //   user.address.city, // Assuming UseraddressModel has a city field
                    //   style: TextStyle(fontSize: 14, color: Colors.grey),
                    // ),
                    const SizedBox(width: 8),
                    Text(
                      user.status,
                      style: TextStyle(
                        fontSize: 16,
                        color: user.status == 'Available'
                            ? Colors.green
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Tags
                Column(
                  children: [
                    Row(
                      children: _buildInterestTags(
                        user.interests.map((e) => e.name).toList(),
                        0,
                        2,
                      ),
                    ),
                    Gap.h4,
                    Row(
                      children: _buildInterestTags(
                        user.interests.map((e) => e.name).toList(),
                        2,
                        4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap.w4,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.blue.shade600,
                    onPressed: () {},
                    icon: Icon(Icons.message, size: 28),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {},
                    icon: Icon(Icons.help_outline_sharp, size: 28),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInterestTags(List<String> tags, int start, int end) {
    List<Widget> tagsWidgets = [];
    final colors = [
      {'bg': Colors.blue.shade100, 'text': Colors.blue.shade700},
      {'bg': Colors.green.shade100, 'text': Colors.green.shade700},
      {'bg': Colors.pink.shade100, 'text': Colors.pink.shade700},
      {'bg': Colors.amber.shade100, 'text': Colors.amber.shade700},
    ];

    for (int i = start; i < end && i < tags.length; i++) {
      final colorIndex = i % colors.length;
      tagsWidgets.add(
        _buildTag(
          tags[i].length > 10 ? '${tags[i].substring(0, 8)}...' : tags[i],
          colors[colorIndex]['bg'] as Color,
          colors[colorIndex]['text'] as Color,
        ),
      );
      if (i < end - 1 && i < tags.length - 1) tagsWidgets.add(Gap.w4);
    }

    return tagsWidgets;
  }

  Widget _buildTag(String text, Color backgroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      height: 30,
      width: 95,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 10,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
