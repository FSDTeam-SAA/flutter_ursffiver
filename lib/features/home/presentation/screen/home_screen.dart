import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_ursffiver/app/controller/app_global_controllers.dart';
import 'package:flutter_ursffiver/core/common/sheets/interest_picker_sheet.dart';
import 'package:flutter_ursffiver/core/componenet/pagination/widget/paginated_list.dart';
import 'package:flutter_ursffiver/features/common/textfield.dart';
import 'package:flutter_ursffiver/features/home/controller/filter_people_suggestion_controller.dart';
import 'package:flutter_ursffiver/features/home/controller/status_controller.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/user_verification_screen.dart';
import 'package:flutter_ursffiver/features/home/presentation/widget/user_profile_card.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/user_unvarifaid_screen.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../common/app_logo.dart';
import '../../../notification/screen/notification_screen.dart';
import '../../../profile/controller/profile_data_controller.dart';
import '../../../profile/model/user_profile.dart';
import '../widget/interest_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FilterPeopleSuggestionController _filterPeopleSuggestionController =
      Get.find<AppGlobalControllers>()
          .homeController
          .filterPeopleSuggestionController;

  final statusController = Get.put(StatusController());
  final ProfileDataProvider _profieDataController =
      Get.find<ProfileDataProvider>();

  @override
  void initState() {
    super.initState();
    _profieDataController.getCurrentUserProfile();
  }

  static const _brandGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF4C5CFF), Color(0xFF8F79FF)],
  );

  bool isAvailable = false;
  String? statusMessage;
  final TextEditingController customMessageController = TextEditingController();
  final FocusNode _customStatusFocus = FocusNode();
  bool isEditing = false;
  int selectedRange = 2;

  final List<String> ranges = [
    "Bluetooth",
    "Nearby",
    "Up to 1 mile",
    "Up to 5 miles",
    "Up to 10 miles",
  ];

  // Define icons (same length as ranges)
  final List<IconData> rangeIcons = [
    Icons.bluetooth,
    Icons.location_on_outlined,
    Icons.location_on_outlined,
    Icons.location_on_outlined,
    Icons.location_on_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: AppLogo(height: 30, width: 100),
        centerTitle: false,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.donut_large_rounded, color: Colors.black),
          //   iconSize: 28,
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       barrierDismissible: false,
          //       builder: (context) => Center(
          //         child: SizedBox(
          //           width: MediaQuery.of(context).size.width * 0.9,
          //           child: LocationShare(
          //             onAccept: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => LiveLocationSharingWidget(
          //                     sharingWith: '',
          //                     userInitials: '',
          //                     userName: '',
          //                   ),
          //                 ),
          //               );
          //             },
          //             onDecline: () {
          //               debugPrint("❌ Declined");
          //             },
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),

          // ///
          // IconButton(
          //   icon: Icon(Icons.donut_large_rounded, color: Colors.black),
          //   iconSize: 28,
          //   onPressed: () {
          //     FixedNotificationBanner.show(context);
          //   },
          // ),
          Obx(
            () => IconButton(
              onPressed: () {
                final user = _profieDataController.userProfile.value;
                if (user != null) {
                  if (user.adminVerify == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnVerificationScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerificationScreen(),
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.verified_user_outlined),
              iconSize: 28,
              color:
                  _profieDataController.userProfile.value?.adminVerify == true
                  ? Colors.green
                  : Colors.red[400],
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            iconSize: 32,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            /// Availability Switch
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Availability",
                        style: AppText.smMedium_14_600.copyWith(
                          color: AppColors.primaryTextblack,
                        ),
                      ),
                      Text(
                        isAvailable
                            ? "You are visible to other nearby"
                            : "You are not available to connect",
                        style: AppText.xsRegular_12_400.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isAvailable,
                    onChanged: (val) {
                      setState(() {
                        isAvailable = val;
                      });
                      _filterPeopleSuggestionController.setVisibility(val, () {
                        return true;
                      });
                    },
                  ),
                  // Switch(
                  //   value: isAvailable,
                  //   onChanged: (val) async {
                  //     if (val == true) {
                  //       final permission = await Geolocator.checkPermission();

                  //       if (permission == LocationPermission.denied ||
                  //           permission == LocationPermission.deniedForever) {
                  //         await showLocationPermissionDialog(context);

                  //         return;
                  //       }
                  //     }
                  //     setState(() {
                  //       isAvailable = val;
                  //     });

                  //     _filterPeopleSuggestionController.setVisibility(val, () {
                  //       return val;
                  //     });
                  //   },
                  // ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                color: isAvailable ? const Color(0xFFF5F5FE) : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Share what you’re up for and\nconnect with nearby SPEETsters:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AbsorbPointer(
                        absorbing: !isAvailable,
                        child: Opacity(
                          opacity: isAvailable ? 1.0 : 0.6,
                          child: Obx(
                            () => LabeledDropdown(
                              height: 52,
                              title: "Status",
                              hintText: "Ready to connect - tap to set status",
                              items: [
                                "Ready to connect - tap to set status",
                                "Looking to chat with someone nearby right now",
                                "Free for coffee or quick meetup",
                                "Want to grab food together?",
                                "Walking my dog - join me!",
                                "New here - looking for local friends",
                                "Available for spontaneous adventures",
                                "Study buddy needed",
                                "Workout partner wanted",
                              ],
                              value:
                                  statusController.statusMessage.value.isEmpty
                                  ? null
                                  : statusController.statusMessage.value,
                              textSize: 14,
                              textColor: isAvailable
                                  ? Colors.black87
                                  : Colors.grey,
                              borderColor: isAvailable
                                  ? AppColors.buttonTextColor
                                  : Colors.grey[300]!,
                              borderRadius: 8,
                              hintTextColor: Colors.grey,
                              hintTextSize: 14,
                              hintTextWeight: FontWeight.w400,
                              onChanged: (value) {
                                if (value != null) {
                                  statusController.updateStatus(value);
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Text(
                            "Or enter a custom status:",
                            style: AppText.xsRegular_12_400.copyWith(
                              color: AppColors.primaryTextblack,
                            ),
                          ),
                          const Spacer(),
                          if (!isEditing) ...[
                            TextButton(
                              onPressed: isAvailable
                                  ? () {
                                      setState(() {
                                        isEditing = true;
                                      });
                                      FocusScope.of(
                                        context,
                                      ).requestFocus(_customStatusFocus);
                                    }
                                  : null,
                              child: const Text("Edit"),
                            ),
                          ] else ...[
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.cancel,
                                    size: 18,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "cancel",
                                    style: AppText.mdMedium_16_500.copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check,
                                    size: 18,
                                    color: AppColors.primarybutton,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Save",
                                    style: AppText.mdMedium_16_500.copyWith(
                                      color: AppColors.primarybutton,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        child: TextField(
                          enabled: isAvailable,
                          focusNode: _customStatusFocus,
                          controller: customMessageController,
                          decoration: InputDecoration(
                            hintText:
                                "Click to enter a custom status message...",
                            hintStyle: AppText.xsRegular_12_400.copyWith(
                              color: AppColors.primaryTextblack,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Primary Interests",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Obx(() {
                    final selectedInterests =
                        _profieDataController.userProfile.value?.interests ??
                        [];

                    debugPrint(
                      "selectedInterests: ${_profieDataController.userProfile.value?.interests.length ?? 0}",
                    );

                    if (selectedInterests.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 0,
                        ),
                        child: Text(
                          "No interests found.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return InterestsGrid(chips: selectedInterests);
                  }),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              toolbarHeight: 196,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Location Range",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          ranges.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: SizedBox(
                                height: 62,
                                width: 58,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      rangeIcons[index],
                                      size: 24,
                                      color: selectedRange == index
                                          ? AppColors.primarybutton
                                          : Colors.grey,
                                    ),
                                    const SizedBox(height: 6),
                                    Flexible(
                                      child: Text(
                                        ranges[index],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: selectedRange == index
                                              ? AppColors.primarybutton
                                              : Colors.black87,
                                          fontSize: 12,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              selected: selectedRange == index,
                              onSelected: (val) {
                                setState(() {
                                  selectedRange = index;
                                });
                              },
                              selectedColor: const Color(0xFFECEDFD),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: selectedRange == index
                                      ? AppColors.primarybutton
                                      : AppColors.textFieldBorder,
                                  width: 1.5,
                                ),
                              ),
                              showCheckmark: false,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        const Text(
                          "People Nearby",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            _filterPeopleSuggestionController.findSuggestion(
                              forceFresh: true,
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.refresh,
                                size: 24,
                                color: AppColors.primarybutton,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "Refresh",
                                style: AppText.mdMedium_16_500.copyWith(
                                  color: AppColors.primarybutton,
                                ),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            showModalBottomSheet<Set<String>>(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => InterestPickerSheet.forFiltering(
                                interestSelectionCntlr:
                                    _filterPeopleSuggestionController
                                        .selectInterestController,
                                brandGradient: _brandGradient,
                                onConfirm: () {
                                  _filterPeopleSuggestionController
                                      .findSuggestion(forceFresh: true);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                color: AppColors.primarybutton,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Filtering",
                                style: AppText.mdMedium_16_500.copyWith(
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
              ),
            ),

            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: PaginatedListWidget(
                  physics: AlwaysScrollableScrollPhysics(),
                  pagination: _filterPeopleSuggestionController.suggestionList,
                  onRefresh: null,
                  skeleton: UserSuggestionSkeleton(),
                  skeletonCount: 3,
                  builder: (index, data) => _UserSuggestionCard(profile: data),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserSuggestionCard extends StatefulWidget {
  final UserProfile profile;
  const _UserSuggestionCard({required this.profile});

  @override
  State<_UserSuggestionCard> createState() => _UserSuggestionCardState();
}

class _UserSuggestionCardState extends State<_UserSuggestionCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        UserProfileCard(user: widget.profile),
        const SizedBox(height: 8),
        const Divider(color: Colors.grey),
        const SizedBox(height: 8),
      ],
    ).animate().fadeIn(duration: 300.ms, delay: (100).ms);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// skeleton for user suggestion card
class UserSuggestionSkeleton extends StatelessWidget {
  const UserSuggestionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 10,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer(
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade300,
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
            stops: const [0.4, 0.5, 0.6],
          ),
          child: Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              // text skeleton
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0),
                      Container(
                        width: 200,
                        height: 16,
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 16,
                        constraints: BoxConstraints(
                          maxWidth: max(constraints.maxWidth - 50, 0),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class InterestsGrid extends StatelessWidget {
//   final List<InterestModel> chips;

//   const InterestsGrid({super.key, required this.chips});

//   @override
//   Widget build(BuildContext context) {
//   return Wrap(
//     spacing: 8,
//     runSpacing: 8,
//     children: chips.map(
//       (chip) => Chip(
//         label: Text(
//           chip.name,
//           style: AppText.mdMedium_16_500.copyWith(
//             color: chip.color.deepColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         backgroundColor: chip.color.softColor,
//         side: BorderSide(
//           color: chip.color.deepColor,
//           width: 1.2,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         shadowColor: chip.color.deepColor,
//         elevation: 1,
//       ),
//     ).toList(),
//   );
// }

// }
