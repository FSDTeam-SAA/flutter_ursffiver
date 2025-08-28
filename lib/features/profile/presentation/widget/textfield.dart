import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LabeledDropdown extends StatelessWidget {
  final String? title;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  // Shared style parameters
  final double textSize;
  final Color textColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final Color backgroundColor;

  // Hint text style
  final Color hintTextColor;
  final double hintTextSize;
  final FontWeight hintTextWeight;

  const LabeledDropdown({
    super.key,
    this.title,
    required this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
    this.textSize = 14,
    this.textColor = Colors.black,
    this.borderColor = AppColors.primaryTextblack, // light gray
    this.focusedBorderColor = Colors.blue,
    this.borderRadius = 8,
    this.backgroundColor = Colors.white, // (0xFFF5F5F5), 
    this.hintTextColor = const Color(0xFF9E9E9E),
    this.hintTextSize = 14,
    this.hintTextWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 6),
          ],
          DropdownButtonFormField<String>(
            value: value,
            style: TextStyle(fontSize: textSize, color: textColor),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: hintTextSize,
                color: hintTextColor,
                fontWeight: hintTextWeight,
              ),
              filled: true,
              fillColor: backgroundColor,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: focusedBorderColor, width: 2),
              ),
            ),
            items: items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: TextStyle(fontSize: textSize)),
                    ))
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}



class LabeledTextField extends StatelessWidget {
  final String title;
  final String hintText;

  // Text styles
  final double textSize;
  final Color textColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final Color backgroundColor;

  // Hint text style
  final Color hintTextColor;
  final double hintTextSize;
  final FontWeight hintTextWeight;

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const LabeledTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.textSize = 14,
    this.textColor = Colors.black,
    this.borderColor = AppColors.primaryTextblack,
    this.focusedBorderColor = Colors.blue,
    this.borderRadius = 8,
    this.backgroundColor =  Colors.white,
    this.hintTextColor =  AppColors.secondaryText,
    this.hintTextSize = 14,
    this.hintTextWeight = FontWeight.w400,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            onChanged: onChanged,
            style: TextStyle(fontSize: textSize, color: textColor),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: hintTextSize,
                color: hintTextColor,
                fontWeight: hintTextWeight,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: focusedBorderColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// example of uses

// Row(
//                   children: [
//                     Expanded(
//                       child: LabeledDropdown(
//                         title: "Title*",
//                         hintText: "Select Title",
//                         items: ["Mr.", "Ms.", "Mrs."],
//                         onChanged: (v) {},
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       flex: 2,
//                       child: LabeledTextField(
//                         title: 'First Name',
//                         hintText: 'e.g. Aliul',
//                       ),
//                     ),
//                   ],
//                 ),