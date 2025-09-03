import 'package:flutter/material.dart';
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
  String statusMessage = "Ready to connect - Tap to set status";
  final TextEditingController customMessageController = TextEditingController();
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
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Availability toggle
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
                        "Tap the button to become visible",
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

              /// Share status section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 1,
                color: isAvailable
                    ? Color(0xFFF5F5FE)
                    : Colors.white, // <-- change color
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Share what you’re up for and\nconnect with nearby SPEETsters:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryTextblack,
                        ),
                      ),
                      const SizedBox(height: 12),

                      /// Status box
                      InkWell(
                        onTap: isAvailable
                            ? () {
                                setState(() {
                                  isEditing = true;
                                });
                              }
                            : null, // disable tap if not available
                        child: Container(
                          height: 48, // set height
                          width: double.infinity, // full width of parent
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isAvailable
                                  ? AppColors.textFieldBorder
                                  : AppColors.textFieldBorder,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment
                              .centerLeft, // keep text aligned to the left
                          child: Text(
                            statusMessage,
                            style: TextStyle(
                              color: isAvailable ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Or enter a custom status:",
                                style: AppText.xsRegular_12_400.copyWith(
                                  color: AppColors.primaryTextblack,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text("Edit"),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// Custom message box
                      TextField(
                        enabled: isAvailable, // disable typing if off
                        controller: customMessageController,
                        decoration: InputDecoration(
                          hintText: "Click to enter a custom status message...",
                          hintStyle: AppText.xsRegular_12_400.copyWith(
                            color: AppColors.primaryTextblack,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
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

              SizedBox(height: 8),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 0,
                childAspectRatio: 3,
                children: [
                  Chip(
                    label: Text('Acting/Theate...'),
                    backgroundColor: AppColors.interestsblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  Chip(
                    label: Text('Escape Room...'),
                    backgroundColor: AppColors.interestsyellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  Chip(
                    label: Text('Arcade Gami...'),
                    backgroundColor: AppColors.interestsred,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  Chip(
                    label: Text('Arcade Gami...'),
                    backgroundColor: AppColors.interestsyellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  Chip(
                    label: Text('Expedition Tra...'),
                    backgroundColor: AppColors.interestsred,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  Chip(
                    label: Text('Acting/Theate...'),
                    backgroundColor: AppColors.interestsgreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Colors.transparent),
                    ),
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
              SizedBox(
                child: SingleChildScrollView(
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        "Nearby Actors",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
              Column(
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
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8),  // Add some space between user profiles
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
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8), 
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
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8), 
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
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8), // Add some space between user profiles
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
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
