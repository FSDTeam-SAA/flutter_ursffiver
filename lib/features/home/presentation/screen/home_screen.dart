import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../common/app_logo.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppLogo(height: 30, width: 100),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            iconSize: 32,
            onPressed: () {},
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

              /// Primary Interests
              const Text(
                "Primary Interests",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: interests
                    .map(
                      (interest) => Chip(
                        label: Text(interest),
                        backgroundColor: Colors.blue.shade100,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              /// Location Range
              const Text(
                "Location Range",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: List.generate(
              //     ranges.length,
              //     (index) => ChoiceChip(
              //       label: Text(ranges[index]),
              //       selected: selectedRange == index,
              //       onSelected: (val) {
              //         setState(() {
              //           selectedRange = index;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      ranges.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(
                          right: 8,
                        ),
                        child: ChoiceChip(
                          label: SizedBox(
                            height: 62, // control box height
                            width: 62, // control box width
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: selectedRange == index
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    ranges[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: selectedRange == index
                                          ? Colors.white
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
                          selectedColor: Color(0xFFECEDFD),
                          backgroundColor: Colors.grey.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          showCheckmark: false,
                        ),
                      ),
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
