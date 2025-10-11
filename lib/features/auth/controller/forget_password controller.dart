// lib/features/auth/controller/forget_password_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/auth/model/forget_password_model.dart';
import 'package:flutter_ursffiver/features/auth/presentation/screens/verify_screen.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Simulate or call API for password reset
  Future<void> sendCode() async {
    if (!formKey.currentState!.validate()) return;

    final model = ForgetPasswordModel(email: emailController.text.trim());
    debugPrint('Forget Password Request: ${model.toJson()}');

    // TODO: Replace with API call
    // Example: await authRepository.sendResetCode(model);

    Get.off(() => const VerifyScreen());
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
