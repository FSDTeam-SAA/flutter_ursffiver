import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/auth/controller/app_controllers.dart';
import 'package:flutter_ursffiver/core/common/controller/interest_fetch_controller.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';
import 'package:get/get.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';

import 'create_custom_interest_bottom_sheet.dart';
import 'select_interest_widget.dart';

class InterestPickerSheet extends StatefulWidget {
  const InterestPickerSheet({
    super.key,
    required this.initialSelection,
    required this.brandGradient,
  });

  final Set<String> initialSelection;
  final Gradient brandGradient;

  @override
  State<InterestPickerSheet> createState() => _InterestPickerSheetState();
}

class _InterestPickerSheetState extends State<InterestPickerSheet> {
  late final AllInterestFetchController allInterestFetchController;
  final SelectInterestController selectInterestController =
      SelectInterestController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allInterestFetchController =
        Get.find<AppGlobalControllers>().interestController;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      minChildSize: 0.6,
      maxChildSize: 0.98,
      builder: (context, scrollCtrl) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                blurRadius: 24,
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E6E9),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 12),

              // Header + Search + Custom link
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Your Interests",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Select interests to help find compatible people nearby. Choose up to 15.",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      onChanged: (value) =>
                          selectInterestController.searchQuery.value = value,
                      decoration: InputDecoration(
                        hintText: "Search interests",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE6E6E9),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE6E6E9),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFBAC0FF),
                          ),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () => showCreateCustomInterest(
                        context,
                        selectInterestController,
                      ),
                      child: Text(
                        "Create Custom Interests",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF4C5CFF),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Interest list
              Expanded(
                child: ObxValue(
                  (data) => ListView.builder(
                    controller: scrollCtrl,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                    itemCount: data.length,
                    itemBuilder: (_, idx) {
                      final interestCategory =
                          data[idx];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          Text(
                            interestCategory.name,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),

                          ListView.builder(
                            itemCount: interestCategory.interests.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 8),
                            itemBuilder: (_, idx) {
                              final interest = interestCategory.interests[idx];
                              return SelectInterestTile(
                                interest: interest,
                                isSelected: widget.initialSelection.contains(
                                  interest.id,
                                ),
                                onTap: () {
                                  selectInterestController.toggleSelectInterest(
                                    interest,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                   selectInterestController.interestList
                ),
              ),

              // Bottom bar (sticky)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Color(0xFFE6E6E9))),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            "Selected: ${selectInterestController.selectedIndexCnt}/15",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 8),
                          if (selectInterestController
                              .selectedInterests
                              .isEmpty)
                            const Text(
                              "Please select at least 1",
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4C5CFF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            "Save interest (${selectInterestController.selectedInterests.length}/15)",
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Gap.h40,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RulesBox extends StatelessWidget {
  const RulesBox({super.key, required this.checks});
  final Map<String, bool> checks;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: checks.entries.map((e) {
          final text = e.key;
          final valid = e.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Icon(
                  valid ? Icons.check_circle : Icons.radio_button_unchecked,
                  size: 16,
                  color: valid ? Colors.green : Colors.black45,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: valid ? Colors.green : Colors.black87,
                      fontWeight: valid ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
