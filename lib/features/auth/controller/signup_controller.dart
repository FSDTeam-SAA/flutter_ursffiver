import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/signup_model.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final model = SignupModel().obs;

  // Text controllers
  final firstNameCtl = TextEditingController();
  final lastNameCtl = TextEditingController();
  final usernameCtl = TextEditingController();
  final emailCtl = TextEditingController();
  final dobCtl = TextEditingController();
  final bioCtl = TextEditingController();
  final passwordCtl = TextEditingController();
  final confirmPasswordCtl = TextEditingController();

  // UI states
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  // Dropdown options
  final List<String> ageRanges = ["18-24", "25-34", "35-44", "45+"];
  final List<String> allInterests = [
    "Music", "Sports", "Movies", "Tech", "Books", "Travel", "Food", "Gaming"
  ];

  void togglePassword() => showPassword.value = !showPassword.value;
  void toggleConfirmPassword() => showConfirmPassword.value = !showConfirmPassword.value;

  void setGender(String? gender) {
    model.update((m) => m?.gender = gender);
  }

  void setAgeRange(String? age) {
    model.update((m) => m?.ageRange = age);
  }

  void toggleInterest(String interest) {
    model.update((m) {
      if (m!.interests.contains(interest)) {
        m.interests.remove(interest);
      } else {
        m.interests.add(interest);
      }
    });
  }

  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      model.update((m) {
        m!.firstName = firstNameCtl.text;
        m.lastName = lastNameCtl.text;
        m.username = usernameCtl.text;
        m.email = emailCtl.text;
        m.dob = dobCtl.text;
        m.bio = bioCtl.text;
        m.password = passwordCtl.text;
        m.confirmPassword = confirmPasswordCtl.text;
      });
      return true;
    }
    return false;
  }

  @override
  void onClose() {
    firstNameCtl.dispose();
    lastNameCtl.dispose();
    usernameCtl.dispose();
    emailCtl.dispose();
    dobCtl.dispose();
    bioCtl.dispose();
    passwordCtl.dispose();
    confirmPasswordCtl.dispose();
    super.onClose();
  }
}
