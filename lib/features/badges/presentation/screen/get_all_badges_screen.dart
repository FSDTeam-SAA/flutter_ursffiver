import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/features/badges/controller/get_all_badges_controller.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../badges/model/badge_model.dart';

class GetAllBadgesScreen extends StatelessWidget {
  const GetAllBadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GiveBadgesController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            const Text(
              "All Badge",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap.h8,
            const Text(
              "Badges are a way to recognize your contributions to the community and support the development of our platform. Here's a list of all the badges we have available:",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            Gap.h20,
            const Text(
              "Badge Types",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Gap.h12,

            Obx(() {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.badges.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                  itemBuilder: (context, index) =>
                      BadgeTile(item: controller.badges[index]),
                ),
              );
            }),
            Gap.h20,
            SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarybutton,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Send Badge",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Gap.h40,
          ],
        ),
      ),
    );
  }
}

class BadgeTile extends StatelessWidget {
  final BadgeModel item;
  const BadgeTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: item.badgeColor.withOpacity(0.15),
              child: Icon(item.badgeIcon, color: item.badgeColor, size: 22),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    item.info,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
