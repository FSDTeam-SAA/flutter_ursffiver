import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/badges/controller/all_badges_controller.dart';
import 'package:flutter_ursffiver/features/badges/model/badge_model.dart';
import 'package:flutter_ursffiver/features/badges/presentation/screen/badge_guide_screen.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:flutter_ursffiver/features/profile/model/badge_model.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class BadgesPage extends StatefulWidget {
  const BadgesPage({super.key});

  @override
  State<BadgesPage> createState() => _BadgesPageState();
}

class _BadgesPageState extends State<BadgesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getUserBadges();
    _tabController = TabController(length: 3, vsync: this);
  }

  void getUserBadges() {
    final badgeController = Get.put(AllBadgesController());
    badgeController.loadBadges();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,

        title: Row(
          children: [
            Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  size: 32,
                  color: AppColors.primarybutton,
                ),
                const SizedBox(width: 4),
                Text(
                  'Badge Management',
                  style: AppText.xlSemiBold_20_700.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BadgeGuideScreen(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.contact_support_outlined,
                        color: AppColors.primarybutton,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Badge Guide",
                        style: AppText.smMedium_14_600.copyWith(
                          color: AppColors.primarybutton,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primarybutton,
          unselectedLabelColor: AppColors.primarybutton,
          indicatorColor: AppColors.primarybutton,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Received'),
            Tab(text: 'Awarded'),
            Tab(text: 'All Badges'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ReceivedBadgesWidget(),
          AwardedBadgesWidget(),
          AllBadgesWidget(),
        ],
      ),
    );
  }
}

class ReceivedBadgesWidget extends StatelessWidget {
  const ReceivedBadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> badges = [];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              "Your Received Badges",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Recognition you've given to other users",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gap.h20,

            // Conditional rendering
            badges.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.card_giftcard,
                              size: 160,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "You haven't awarded any badges yet",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: badges.length,
                      itemBuilder: (context, index) {
                        final badge = badges[index];
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
                              Text(
                                badge['title'] ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                badge['description'] ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class AwardedBadgesWidget extends StatelessWidget {
  const AwardedBadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> badges = [];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Badges You've Awarded",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Recognition you've given to other users",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gap.h20,

            // Conditional rendering
            badges.isEmpty
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.card_giftcard,
                              size: 160,
                              color: Colors.grey[400],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "You haven't awarded any badges yet",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: badges.length,
                      itemBuilder: (context, index) {
                        final badge = badges[index];
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
                              Text(
                                badge['title'] ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                badge['description'] ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// class AllBadgesWidget extends StatelessWidget {
//   const AllBadgesWidget({super.key});

//   final List<Map<String, String>> badges = const [
//     {
//       'title': 'Great Listener',
//       'type': 'Communication',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//     {
//       'title': 'Knowledge Share',
//       'type': 'Knowledge',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//     {
//       'title': 'Great Listener',
//       'type': 'Communication',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//     {
//       'title': 'Great Listener',
//       'type': 'Communication',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//     {
//       'title': 'Great Listener',
//       'type': 'Communication',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//     {
//       'title': 'Great Listener',
//       'type': 'Communication',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//     {
//       'title': 'Great Listener',
//       'type': 'Communication',
//       'description':
//           'Awarded to someone who was truly attentive and engaged during your conversation.',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16),

//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(12)),
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Badges You've Awarded",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               "Badges you've given to other users",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: badges.length,
//                 itemBuilder: (context, index) {
//                   final badge = badges[index];
//                   final isCommunication = badge['type'] == 'Communication';
//                   final badgeColor = isCommunication
//                       ? Colors.blue[100]
//                       : Colors.green[100];
//                   final textColor = isCommunication
//                       ? Colors.blue
//                       : Colors.green;

//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 badge['title']!,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: badgeColor,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 badge['type']!,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: textColor,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           badge['description']!,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[700],
//                             height: 1.4,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class AllBadgesWidget extends StatelessWidget {
  const AllBadgesWidget({super.key});

  Color _parseColor(String colorCode) {
    try {
      return Color(int.parse(colorCode.replaceFirst('#', '0xFF')));
    } catch (_) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileDataController());

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Badges You've Awarded",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Badges you've given to other users",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                // if (controller.isLoading.value) {
                //   return const Center(child: CircularProgressIndicator());
                // }

                if (controller.userProfile.value!.badge!.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.card_giftcard,
                          size: 150,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "No badges found.",
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.userProfile.value!.badge!.length,
                  itemBuilder: (context, index) {
                    final UserBadgeModel badge =
                        controller.userProfile.value!.badge![index];
                    final Color badgeColor = _parseColor(badge.color);
                    final Color bgColor = badgeColor.withOpacity(0.1);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  badge.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  badge.tag,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: badgeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            badge.info,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
