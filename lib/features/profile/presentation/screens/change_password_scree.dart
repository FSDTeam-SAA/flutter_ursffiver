import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  // Password visibility
  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  InputBorder get inputBorder => OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryTextblack),
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Opacity(
                    opacity: _isEditing ? 0.5 : 1,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _isEditing
                          ? null
                          : () {
                              setState(() {
                                _isEditing = true;
                              });
                            },
                    ),
                  ),
                ],
              ),

              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildPasswordField(
                      controller: currentPasswordController,
                      hintText: "Current Password",
                      obscureText: !_showCurrentPassword,
                      onToggleVisibility: () {
                        setState(() {
                          _showCurrentPassword = !_showCurrentPassword;
                        });
                      },
                    ),
                    _buildPasswordField(
                      controller: newPasswordController,
                      hintText: "New Password",
                      obscureText: !_showNewPassword,
                      onToggleVisibility: () {
                        setState(() {
                          _showNewPassword = !_showNewPassword;
                        });
                      },
                    ),
                    _buildPasswordField(
                      controller: confirmNewPasswordController,
                      hintText: "Confirm Password",
                      obscureText: !_showConfirmPassword,
                      onToggleVisibility: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),

                    Gap.h32,
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isEditing = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              fixedSize: const Size.fromHeight(50),
                            ),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Gap.h40,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        enabled: _isEditing,
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hintText cannot be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          disabledBorder: inputBorder,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: onToggleVisibility,
          ),
        ),
      ),
    );
  }
}
