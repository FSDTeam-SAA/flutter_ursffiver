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
import 'package:flutter_ursffiver/features/profile/model/update_profile_avatar_param.dart';
import 'package:flutter_ursffiver/features/profile/model/update_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Either<L, R> {
  final L? left;
  final R? right;

  Either({this.left, this.right});
}

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

  var profileImage = Rx<File?>(null);
  final beforeUserProfile = Get.find<ProfileDataController>().userProfile.value; // Store the user profile before editing>
  
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

    final profileController = Get.find<ProfileDataController>();

    // If profile data already exists, load it immediately
    if (profileController.userProfile.value != null) {
      loadDataFromProfile();
    } else {
      // Otherwise, fetch and then load it
      profileController.getCurrentUserProfile().then((_) {
        loadDataFromProfile();
      });
    }
  }

  void loadDataFromProfile() {
    final user = Get.find<ProfileDataController>().userProfile.value;
    if (user == null) return;

    firstNameController.text = user.firstname ?? "";
    lastNameController.text = user.lastname ?? "";
    userNameController.text = user.username ?? "";
    fullNameController.text = "${user.firstname ?? ''} ${user.lastname ?? ''}"
        .trim();
    emailController.text = user.email ?? "";
    usernameController.text = user.username ?? "";
    genderController.text = user.gender ?? "";
    ageRangeController.text = user.ageRange ?? "";
    bioController.text = user.bio ?? "";
    originalEmail = user.email ?? "";
  }

  Future<void> pickImage(ImageSource source) async {
    if (!isEditing.value) return;
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = File(picked.path);
    }
  }

  Future<void> removePhoto() async {
    if (!isEditing.value) return;
    profileImage.value = null;
  }

  Future<void> saveProfile({
    required ProcessStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
  }) async {
    buttonNotifier?.setLoading();
    return await Get.find<ProfileInterface>()
        .updateProfile(
          UpdateProfileModel(
            id: (Get.find<AppManager>().authStatus as Authenticated)
                .auth
                .userId,
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            username: userNameController.text.trim(),
            email: emailController.text.trim(),
            gender: genderController.text.trim(),
            ageRange: ageRangeController.text.trim(),
            bio: bioController.text.trim(),
          ),
        )
        .then((lr) {
          handleFold(
            either: lr,
            processStatusNotifier: buttonNotifier,
            successSnackbarNotifier: snackbarNotifier,
            onSuccess: (data) async {
              if (profileImage.value != null) {

                await Get.find<ProfileInterface>().uploadProfileAvatar(
                  UploadProfileAvatarParam(
                    userId: (Get.find<AppManager>().authStatus as Authenticated)
                        .auth
                        .userId,
                    bytes: await profileImage.value!.readAsBytes(),
                    fileName: profileImage.value?.path ?? "",
                  ),
                );
              } else {
                debugPrint("No image selected");
              }
              Get.find<ProfileDataController>().getCurrentUserProfile();
            },
          );
        });
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
