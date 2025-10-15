import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
class ReusebleTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefix;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;

  const ReusebleTextField({
    super.key,
    required this.hintText,
    this.prefix,
    required this.obscureText,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 53),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 14),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 16, right: 8),
            child: Icon(prefix, color: AppColors.secondaryText),
          ),
          // prefixIconConstraints: const BoxConstraints(
          //   minWidth: 0,
          //   minHeight: 0,
          // ),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 0,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          errorStyle: TextStyle(
            color: AppColors.primarybutton,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
