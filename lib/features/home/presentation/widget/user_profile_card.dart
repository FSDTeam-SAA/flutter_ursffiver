import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/cache/smart_network_image.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import 'package:flutter_ursffiver/features/home/model/interest_model.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/user-profile_screen.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/widget/send_message-dialog.dart';
import 'package:flutter_ursffiver/features/profile/model/user_profile.dart';
import 'package:get/get.dart';

class UserProfileCard extends StatefulWidget {
  final UserProfile user;

  const UserProfileCard({super.key, required this.user});

  @override
  State<UserProfileCard> createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  final InboxChatDataProvider inboxDataProvider =
      Get.find<InboxChatDataProvider>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(user: widget.user),
          ),
        );
      },
      child: Row(
        children: [
          // user image
          SmartNetworkImage(
            imageUrl: widget.user.image,
            height: 130,
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

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // user full name
                Text(
                  '${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // availability
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: widget.user.status == 'Available'
                              ? Colors.green
                              : Colors.grey,
                        ),
                        const SizedBox(width: 6),

                        Text(
                          widget.user.status ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.user.status == 'Available'
                                ? Colors.green
                                : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: Colors.blue.shade600,
                          style: IconButton.styleFrom(
                            minimumSize: const Size(0, 0),
                          ),
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
                                  ),
                                  child: SendChatRequestDialog(
                                    user: widget.user,
                                  ),
                                );
                              },
                            );
                          },
                          icon: Image.asset(
                            "assets/icon/message.png",
                            width: 28,
                            height: 28,
                          ),
                        ),

                        IconButton(
                          color: Colors.grey,
                          style: IconButton.styleFrom(
                            minimumSize: const Size(0, 0),
                          ),
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/icon/Frame.png",
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Tags
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runSpacing: 4,
                      spacing: 4,
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: _buildInterestTags(
                        (widget.user.interests + widget.user.customInterests),
                        4,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap.w4,
        ],
      ),
    );
  }

  List<Widget> _buildInterestTags(List<InterestModel> interests, int max) {
    List<Widget> tagsWidgets = [];
    int maxTags = max;
    int i;
    for (i = 0; i < min(maxTags, interests.length); i++) {
      tagsWidgets.add(
        _buildTag(
          interests[i].name.length > 10
              ? '${interests[i].name.substring(0, 8)}...'
              : interests[i].name,
          interests[i].color.softColor,
          interests[i].color.deepColor,
        ),
      );
      tagsWidgets.add(Gap.w4);
    }
    if (maxTags < interests.length) {
      tagsWidgets.add(Text("..."));
    } else {
      if (tagsWidgets.isNotEmpty) tagsWidgets.removeLast();
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
            fontSize: 12,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
