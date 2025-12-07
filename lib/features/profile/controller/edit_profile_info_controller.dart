import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/app/app_manager.dart';
import 'package:flutter_ursffiver/core/helpers/auth_role.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileInfoController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final genderController = TextEditingController();
  final ageRangeController = TextEditingController();
  final bioController = TextEditingController();

  // PROFILE IMAGE
  Rx<File?> profileImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  String originalEmail = "";
  var isEditing = false.obs;
  var isVerified = true.obs;
  var verifiedDate = "12/10/2025".obs;

  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  @override
  void onInit() {
    super.onInit();
    loadDataFromProfile();

    final profileController = Get.find<ProfileDataProvider>();

    if (profileController.userProfile.value != null) {
      loadDataFromProfile();
    } else {
      profileController.getCurrentUserProfile().then((_) {
        loadDataFromProfile();
      });
    }
  }

  void loadDataFromProfile() {
    final user = Get.find<ProfileDataProvider>().userProfile.value;
    if (user == null) return;

    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    userNameController.text = user.userName ?? "";
    fullNameController.text = "${user.firstName ?? ''} ${user.lastName ?? ''}"
        .trim();
    emailController.text = user.email ?? "";
    usernameController.text = user.userName ?? "";
    genderController.text = user.gender ?? "";
    ageRangeController.text = user.ageRange ?? "";
    bioController.text = user.bio ?? "";

    originalEmail = user.email ?? "";
  }

  // ✅ FIXED pickImage() (now uses passed source)
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(source: source);

      if (picked != null) {
        profileImage.value = File(picked.path);
        update();
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  Future<void> removePhoto() async {
    if (!isEditing.value) return;
    profileImage.value = null;
  }

  // SAVE PROFILE
  Future<void> saveProfile({
    required ProcessStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
  }) async {
    buttonNotifier?.setLoading();

    final lr = await Get.find<ProfileInterface>().updateProfile(
      UpdateProfileModel(
        id: (Get.find<AppManager>().currentAuthStatus as Authenticated)
            .auth
            .userId,
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        username: userNameController.text.trim(),
        email: emailController.text.trim(),
        gender: genderController.text.trim(),
        ageRange: ageRangeController.text.trim(),
        bio: bioController.text.trim(),
        profileImage: profileImage.value,
        fullName: fullNameController.text.trim(),
      ),
    );

    handleFold(
      either: lr,
      processStatusNotifier: buttonNotifier,
      successSnackbarNotifier: snackbarNotifier,
      errorSnackbarNotifier: snackbarNotifier,
    );
  }

  void verifyEmail() {
    isVerified.value = true;
    verifiedDate.value = "30/08/2025";
    Get.snackbar("Success", "Email verified successfully!");
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    ageRangeController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
