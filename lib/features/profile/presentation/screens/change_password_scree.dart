// import 'package:flutter/material.dart';
// import 'package:flutter_ursffiver/core/common/widget/reactive_button/save_button.dart';
// import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
// import 'package:flutter_ursffiver/core/theme/app_colors.dart';
// import 'package:flutter_ursffiver/features/profile/controller/change_password_controller.dart';
// import '../../../../core/theme/text_style.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   late final ChangePasswordController _changePasswordController;
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

//    @override
//   void initState() {
//     super.initState();

//     _changePasswordController = ChangePasswordController(
//       SnackbarNotifier(context: context),
//     );
//   }

//   InputBorder get inputBorder => OutlineInputBorder(
//     borderSide: BorderSide(color: AppColors.primaryTextblack),
//     borderRadius: BorderRadius.circular(8),
//   );

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
//                 const SizedBox(height: 100),
//               ],
//             ),
//           ),
//         ),
//       ),

//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(
//           16,
//           0,
//           16,
//           24,
//         ),
//         child: SizedBox(
//           height: 52,
//           child: RSaveButton(
//             key: UniqueKey(),
//             width: double.infinity,
//             height: 52,
//             buttonStatusNotifier: _changePasswordController.processNotifier,
//             saveText: "Change Password",
//             loadingText: "Changing password...",
//             doneText: "Done",
//             onDone: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Scaffold()),
//               );
//             },
//             onSaveTap: () {
//               debugPrint("Save tapped");
//               if (true) {
//                 _changePasswordController.changePassword(
//                   snackbarNotifier: _changePasswordController.snackbarNotifier,
//                 );
//               }
//             },
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
import 'package:flutter_ursffiver/core/common/widget/reactive_button/save_button.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/core/theme/app_colors.dart';
import 'package:flutter_ursffiver/features/profile/controller/change_password_controller.dart';
import '../../../../core/theme/text_style.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ChangePasswordController _changePasswordController;
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

  @override
  void initState() {
    super.initState();

    _changePasswordController = ChangePasswordController(
      SnackbarNotifier(context: context),
    );

    // Text field listeners to update controller values
    currentPasswordController.addListener(() {
      _changePasswordController.currentPassword =
          currentPasswordController.text.trim();
    });
    newPasswordController.addListener(() {
      _changePasswordController.newPassword =
          newPasswordController.text.trim();
    });
    confirmNewPasswordController.addListener(() {
      _changePasswordController.confirmPassword =
          confirmNewPasswordController.text.trim();
    });
  }

  InputBorder get inputBorder => OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryTextblack),
        borderRadius: BorderRadius.circular(8),
      );

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

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
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),

      /// BOTTOM BUTTON
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: SizedBox(
          height: 52,
          child: RSaveButton(
            key: UniqueKey(),
            width: double.infinity,
            height: 52,
            buttonStatusNotifier: _changePasswordController.processNotifier,
            saveText: "Change Password",
            loadingText: "Changing password...",
            doneText: "Done",
            onDone: () {
              Navigator.pop(context);
            },
            onSaveTap: () {
              if (_formKey.currentState!.validate()) {
                _changePasswordController.changePassword(
                  snackbarNotifier: _changePasswordController.snackbarNotifier,
                );
              }
            },
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
