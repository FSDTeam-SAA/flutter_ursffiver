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
  late AllBadgesController badgeController;

  @override
  void initState() {
    super.initState();
    // Initialize controller
    badgeController = Get.put(AllBadgesController());
    // Tab controller
    _tabController = TabController(length: 2, vsync: this);
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
            const Spacer(),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => BadgeGuideScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.contact_support_outlined,
                    color: AppColors.primarybutton,
                  ),
                  const SizedBox(width: 6),
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
        children: const [
          ReceivedBadgesWidget(),
          AwardedBadgesWidget(),
        ],
      ),
    );
  }
}

class ReceivedBadgesWidget extends StatelessWidget {
  const ReceivedBadgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AllBadgesController>();

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
            const Text(
              "Your Received Badges",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              "Recognition you've received from other users",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gap.h20,

            /// 🔥 Pull To Refresh
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshReceivedBadges();
                },
                child: Obx(() {
                  if (controller.receivedBadges.isEmpty) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
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
                                  "You haven't received any badges yet",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.receivedBadges.length,
                    itemBuilder: (context, index) {
                      final badge = controller.receivedBadges[index];
                      return BadgeRecordWidget(badge: badge);
                    },
                  );
                }),
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
    final controller = Get.find<AllBadgesController>();

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
            const Text(
              "Badges You've Awarded",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            const Text(
              "Recognition you've given to other users",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Gap.h20,

            /// 🔥 Pull To Refresh
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshAwardedBadges();
                },
                child: Obx(() {
                  if (controller.awardedBadges.isEmpty) {
                    return ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
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
                      ],
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.awardedBadges.length,
                    itemBuilder: (context, index) {
                      final badge = controller.awardedBadges[index];
                      return BadgeRecordWidget(badge: badge);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

