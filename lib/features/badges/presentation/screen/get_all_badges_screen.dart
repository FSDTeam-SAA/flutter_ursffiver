import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/badges/controller/all_badges_controller.dart';
import 'package:flutter_ursffiver/features/badges/presentation/widget/all_badges_record_widget.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class GetAllBadgesScreen extends StatefulWidget {
  final String userId; // 👈 RECEIVING USER ID

  const GetAllBadgesScreen({
    super.key,
    required this.userId,
  });

  @override
  State<GetAllBadgesScreen> createState() => _GetAllBadgesScreenState();
}

class _GetAllBadgesScreenState extends State<GetAllBadgesScreen> {
  late AllBadgesController badgeController;
  String? selectedBadgeId;

  @override
  void initState() {
    super.initState();
    badgeController = Get.put(AllBadgesController());
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
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
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
                "All Badges",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              // 👇 PRINT USER ID BELOW TITLE (NO UI CHANGE)
              Text(
                "User ID: ${widget.userId}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),

              const Text(
                "Badges you can award",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Gap.h20,

              Expanded(
                child: Obx(() {
                  final badges = badgeController.allBadges;
                  if (badges.isEmpty) {
                    return Center(
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
                            "No badges yet",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: badges.length,
                    itemBuilder: (context, index) {
                      final badge = badges[index];
                      final isSelected = badge.id == selectedBadgeId;

                      return AllBadgesRecordWidget(
                        badge: badge,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedBadgeId = isSelected ? null : badge.id;
                          });
                        },
                      );
                    },
                  );
                }),
              ),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: selectedBadgeId != null
                      ? () {
                          final selectedBadge = badgeController.allBadges
                              .firstWhere((b) => b.id == selectedBadgeId);

                          print("Selected Badge Name: ${selectedBadge.name}");
                          print("Selected Badge ID: $selectedBadgeId");
                          print("Selected User ID: ${widget.userId}");
                        }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarybutton,
                    foregroundColor: Colors.black,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Send Badge",
                    style: AppText.mdMedium_16_500.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
