// import 'package:flutter/material.dart';
// import 'package:flutter_ursffiver/core/theme/app_colors.dart';
// import 'package:flutter_ursffiver/core/theme/app_gap.dart';

// import '../../../../core/theme/text_style.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   bool _isEditing = true; // allow editing by default
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final TextEditingController currentPasswordController =
//       TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmNewPasswordController =
//       TextEditingController();

//   // Password visibility
//   bool _showCurrentPassword = false;
//   bool _showNewPassword = false;
//   bool _showConfirmPassword = false;

//   InputBorder get inputBorder => OutlineInputBorder(
//         borderSide: BorderSide(color: AppColors.primaryTextblack),
//         borderRadius: BorderRadius.circular(8),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text(
//           'Change Password',
//           style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Enter Old Password",
//                     style: AppText.mdSemiBold_16_600.copyWith(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 _buildPasswordField(
//                   controller: currentPasswordController,
//                   hintText: "Current Password",
//                   obscureText: !_showCurrentPassword,
//                   onToggleVisibility: () {
//                     setState(() {
//                       _showCurrentPassword = !_showCurrentPassword;
//                     });
//                   },
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Enter New Password",
//                     style: AppText.mdSemiBold_16_600.copyWith(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 _buildPasswordField(
//                   controller: newPasswordController,
//                   hintText: "New Password",
//                   obscureText: !_showNewPassword,
//                   onToggleVisibility: () {
//                     setState(() {
//                       _showNewPassword = !_showNewPassword;
//                     });
//                   },
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Confirm New Password",
//                     style: AppText.mdSemiBold_16_600.copyWith(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 _buildPasswordField(
//                   controller: confirmNewPasswordController,
//                   hintText: "Confirm Password",
//                   obscureText: !_showConfirmPassword,
//                   onToggleVisibility: () {
//                     setState(() {
//                       _showConfirmPassword = !_showConfirmPassword;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               setState(() {
//                 _isEditing = false;
//               });
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primarybutton,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             fixedSize: const Size.fromHeight(50),
//           ),
//           child: Text(
//             "Change Password",
//             style: AppText.mdSemiBold_16_600.copyWith(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField({
//     required TextEditingController controller,
//     required String hintText,
//     required bool obscureText,
//     required VoidCallback onToggleVisibility,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         enabled: _isEditing,
//         obscureText: obscureText,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "$hintText cannot be empty";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           hintText: hintText,
//           border: inputBorder,
//           enabledBorder: inputBorder,
//           focusedBorder: inputBorder,
//           disabledBorder: inputBorder,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 16,
//           ),
//           suffixIcon: IconButton(
//             icon: Icon(
//               obscureText ? Icons.visibility_off : Icons.visibility,
//               color: Colors.grey,
//             ),
//             onPressed: onToggleVisibility,
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Change Password',
          style: AppText.xlSemiBold_20_600.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter Old Password",
                    style: AppText.mdSemiBold_16_600.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter New Password",
                    style: AppText.mdSemiBold_16_600.copyWith(
                      color: Colors.black,
                    ),
                  ),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm New Password",
                    style: AppText.mdSemiBold_16_600.copyWith(
                      color: Colors.black,
                    ),
                  ),
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
                const SizedBox(height: 100), // Push content above button
              ],
            ),
          ),
        ),
      ),

      /// Button moved to bottom with gap
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24), // <-- added bottom gap
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {}
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primarybutton,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            fixedSize: const Size.fromHeight(50),
          ),
          child: Text(
            "Change Password",
            style: AppText.mdSemiBold_16_600.copyWith(color: Colors.white),
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
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
