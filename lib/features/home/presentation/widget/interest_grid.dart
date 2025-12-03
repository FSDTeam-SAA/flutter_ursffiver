import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../auth/model/interest_model.dart';

class InterestsGrid extends StatelessWidget {
  final List<InterestModel> chips;
  const InterestsGrid({super.key, required this.chips});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: chips
          .map(
            (chip) => Chip(
              label: Text(
                chip.name,
                style: AppText.mdMedium_16_500.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: chip.color.deepColor,
              side: BorderSide(color: chip.color.deepColor, width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
          .toList(),
    );
  }
}
