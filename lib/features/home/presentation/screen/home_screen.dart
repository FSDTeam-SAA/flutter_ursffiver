import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/common/textfield.dart';
import 'package:flutter_ursffiver/features/home/presentation/screen/delete.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';
import '../../../common/app_logo.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAvailable = true;
  String? statusMessage; // fixed: nullable for dropdown
  final TextEditingController customMessageController = TextEditingController();
  final FocusNode _customStatusFocus = FocusNode();
  bool isEditing = false;
  int selectedRange = 2;

  final List<String> interests = [
    "Acting/Theatre",
    "Escape Room",
    "Arcade Gaming",
    "Expedition Travel",
    "Meditation",
    "Cooking",
  ];

  final List<String> ranges = [
    "Bluetooth",
    "Nearby",
    "Up to 1 mile",
    "Up to 5 miles",
    "Up to 10 miles",
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.verified_user_outlined),
            iconSize: 28,
            color: AppColors.secondaryText,
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            iconSize: 32,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Availability Switch
              Row(
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
                            ? "You are available to connect"
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
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
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

                      /// Status dropdown
                      AbsorbPointer(
                        absorbing: !isAvailable,
                        child: Opacity(
                          opacity: isAvailable ? 1.0 : 0.6,
                          child: LabeledDropdown(
                            height: 52,
                            title: "Status",
                            hintText: "Select status",
                            items: const [
                              "Available",
                              "Not Available",
                              "Pending",
                            ],
                            value: statusMessage,
                            textSize: 14,
                            textColor: isAvailable
                                ? Colors.black87
                                : Colors.grey,
                            borderColor: isAvailable
                                ? AppColors.buttonTextColor
                                : Colors.grey[300]!,

                            //borderColor: AppColors.textFieldBorder,
                            //focusedBorderColor: Colors.blue,
                            borderRadius: 8,
                            //backgroundColor: Colors.white,
                            hintTextColor: Colors.grey,
                            hintTextSize: 14,
                            hintTextWeight: FontWeight.w400,
                            onChanged: (String? value) {
                              setState(() {
                                statusMessage = value!;
                              });
                            },
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
                          TextButton(
                            onPressed: isAvailable
                                ? () {
                                    FocusScope.of(
                                      context,
                                    ).requestFocus(_customStatusFocus);
                                  }
                                : null, // disable button if switch off
                            child: const Text("Edit"),
                          ),
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

              const SizedBox(height: 20),
              const Text(
                "Primary Interests",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              InterestsGrid(
                chips: [
                  InterestChip(
                    label: 'Acting/Theatre',
                    color: AppColors.interestsblue,
                  ),
                  InterestChip(
                    label: 'Escape Room',
                    color: AppColors.interestsyellow,
                  ),
                  InterestChip(
                    label: 'Arcade Gaming',
                    color: AppColors.interestsred,
                  ),
                  InterestChip(
                    label: 'Expedition Trail',
                    color: AppColors.interestsgreen,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Location Range
              const Text(
                "Location Range",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    ranges.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: SizedBox(
                          height: 52,
                          width: 48,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 24,
                                color: selectedRange == index
                                    ? AppColors.primarybutton
                                    : Colors.grey,
                              ),
                              const SizedBox(height: 6),
                              Flexible(
                                child: Text(
                                  ranges[index],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: selectedRange == index
                                        ? AppColors.primarybutton
                                        : Colors.black87,
                                    fontSize: 13,
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

              /// Nearby Actors
              Row(
                children: [
                  const Text(
                    "Nearby Actors",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {},
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
                ],
              ),

              InkWell(
                onTap: () {},
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

              Gap.h12,

              /// Example user cards
              Column(
                children: List.generate(
                  30,
                  (index) => Column(
                    children: [
                      UserProfileCard(
                        name: 'Brooklyn Simmons',
                        imagePath: 'assets/image/profile.png',
                        distance: '5 ft',
                        status: 'Available',
                        onActivityHi: () {},
                        onExperience: () {},
                        onChat: () {},
                        onInfo: () {},
                      ),
                      const SizedBox(height: 8),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 8),
                    ],
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

// prymary interasts chip widget
// Model for each chip
class InterestChip {
  final String label;
  final Color color;

  InterestChip({required this.label, required this.color});
}

// Reusable Grid widget
class InterestsGrid extends StatelessWidget {
  final List<InterestChip> chips;

  const InterestsGrid({super.key, required this.chips});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 6,
      mainAxisSpacing: 6,
      childAspectRatio: 3,
      children: chips
          .map(
            (chip) => Chip(
              label: Text(
                chip.label,
                style: AppText.mdMedium_16_500.copyWith(color: Colors.white),
              ),
              backgroundColor: chip.color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide.none,
              ),
              
            ),
          )
          .toList(),
    );
  }
}
