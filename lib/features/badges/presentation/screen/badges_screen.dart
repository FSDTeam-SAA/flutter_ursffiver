import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/badges/controller/all_badges_controller.dart';
import 'package:flutter_ursffiver/features/badges/presentation/screen/badge_guide_screen.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';
import '../widget/badge_record_widget.dart';

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
    _tabController = TabController(length: 2, vsync: this);
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
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ReceivedBadgesWidget(), AwardedBadgesWidget()],
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
            ObxValue(
              (badges) => badges.isEmpty
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
                          return BadgeRecordWidget(badge: badge);
                        },
                      ),
                    ),
              Get.find<AllBadgesController>().receivedBadges,
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

            ObxValue(
              (badges) => badges.isEmpty
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
                          return BadgeRecordWidget(badge: badge);
                        },
                      ),
                    ),
              Get.find<AllBadgesController>().receivedBadges,
            ),

            // badges.isEmpty
            //     ? Expanded(
            //         child: Center(
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                 width: 180,
            //                 height: 180,
            //                 decoration: BoxDecoration(
            //                   color: Colors.grey[100],
            //                   borderRadius: BorderRadius.circular(16),
            //                 ),
            //                 child: Icon(
            //                   Icons.card_giftcard,
            //                   size: 160,
            //                   color: Colors.grey[400],
            //                 ),
            //               ),
            //               const SizedBox(height: 16),
            //               Text(
            //                 "You haven't awarded any badges yet",
            //                 style: TextStyle(
            //                   fontSize: 15,
            //                   color: Colors.grey[600],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     : Expanded(
            //         child: ListView.builder(
            //           itemCount: badges.length,
            //           itemBuilder: (context, index) {
            //             final badge = badges[index];
            //             return Container(
            //               margin: const EdgeInsets.only(bottom: 12),
            //               padding: const EdgeInsets.all(12),
            //               decoration: BoxDecoration(
            //                 color: Colors.grey[50],
            //                 borderRadius: BorderRadius.circular(12),
            //                 border: Border.all(color: Colors.grey.shade300),
            //               ),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     badge['title'] ?? "",
            //                     style: const TextStyle(
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 8),
            //                   Text(
            //                     badge['description'] ?? "",
            //                     style: TextStyle(
            //                       fontSize: 14,
            //                       color: Colors.grey[600],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           },
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }
}