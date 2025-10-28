import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ursffiver/core/common/widget/reactive_button/save_button.dart';
import 'package:flutter_ursffiver/core/constants/route_names.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/auth/controller/forget_password%20controller.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/verify_screen.dart';
import 'package:flutter_ursffiver/features/common/app_logo.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  static const _borderColor = Color(0xFFE6E6E9);

  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ForgetPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      ForgetPasswordController(
        snackbarNotifier: SnackbarNotifier(context: context),
      ),
    );
    emailController.addListener(() {
      controller.email = emailController.text;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: _borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.black54, height: 1.4);

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),
                  const AppLogo(height: 24, width: 52),
                  const SizedBox(height: 14),

                  const Center(
                    child: Text(
                      'Enter Your Email Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your email or phone number to get code\nfor reset your account password.',
                    style: caption,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),

                  const Text(
                    'Email Address',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: _decoration('hello@example.com'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const Spacer(),

                  SizedBox(
                    height: 50,
                    child: RSaveButton(
                      key: UniqueKey(),
                      width: double.infinity,
                      height: 54,
                      buttonStatusNotifier: controller.processNotifier,
                      saveText: "Send OTP",
                      loadingText: "Sending...",
                      doneText: "Done",
                      onDone: () {
                        //Navigator.pushNamed(context, RouteNames.verifyScreen);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyScreen(email: emailController.text, isFromRegisterScreen: false,),
                          ),
                        );
                      },
                      onSaveTap: () async {
                        controller.forgetPassword(
                          buttonNotifier: controller.processNotifier,
                          snackbarNotifier: SnackbarNotifier(context: context),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ursffiver/core/common/reactive_buttons/save_button.dart';
// import 'package:flutter_ursffiver/features/auth/controller/forget_password%20controller.dart';
// import 'package:flutter_ursffiver/features/common/app_logo.dart';
// import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
// import 'package:get/get.dart';

// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});

//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }

// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   static const _borderColor = Color(0xFFE6E6E9);

//   final _formKey = GlobalKey<FormState>();
//   late final ForgetPasswordController controller;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controller via GetX
//     controller = Get.put(
//       ForgetPasswordController(snackbarNotifier: SnackbarNotifier(context: context)),
//     );
//   }

//   InputDecoration _decoration(String hint) => InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: _borderColor),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFFBAC0FF)),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     final caption = Theme.of(context)
//         .textTheme
//         .bodySmall
//         ?.copyWith(color: Colors.black54, height: 1.4);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//           systemNavigationBarColor: Colors.white,
//           systemNavigationBarIconBrightness: Brightness.dark,
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   const SizedBox(height: 4),
//                   const AppLogo(height: 24, width: 52),
//                   const SizedBox(height: 14),

//                   const Center(
//                     child: Text(
//                       'Enter Your Email Address',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Enter your email or phone number to get code\nfor reset your account password.',
//                     style: caption,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 22),

//                   const Text(
//                     'Email Address',
//                     style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: controller.emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: _decoration('hello@example.com'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your email address';
//                       }
//                       final emailRegex =
//                           RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                       if (!emailRegex.hasMatch(value)) {
//                         return 'Please enter a valid email';
//                       }
//                       return null;
//                     },
//                   ),

//                   const Spacer(),

//                   SizedBox(
//                     height: 50,
//                     child: RSaveButton(
//                       key: UniqueKey(),
//                       width: double.infinity,
//                       height: 54,
//                       buttonStatusNotifier: controller.processNotifier,
//                       saveText: "Send OTP",
//                       loadingText: "Sending...",
//                       doneText: "Done",
//                       onDone: () {},
//                       onSaveTap: () async {
//                         if (_formKey.currentState!.validate()) {
//                           await controller.forgetPassword();
//                         }
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
