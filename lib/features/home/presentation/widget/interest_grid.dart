import 'package:flutter/material.dart';

import '../../../../core/common/model/interest_model.dart';
import '../../../../core/theme/text_style.dart';

class InterestsGrid extends StatelessWidget {
  final List<InterestModel> chips;
  const InterestsGrid({super.key, required this.chips});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips
          .map(
            (chip) => Chip(
              label: Text(
                chip.name,
                style: AppText.mdMedium_16_500.copyWith(
                  color: chip.color.deepColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: chip.color.softColor,
              side: BorderSide(color: chip.color.deepColor, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: chip.color.deepColor,
              elevation: 1,
            ),
          )
          .toList(),
    );
  }
}
