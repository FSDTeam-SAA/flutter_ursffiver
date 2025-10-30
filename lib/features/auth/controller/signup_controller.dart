

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/core/constants/route_names.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/core/common/model/interest_model.dart';
import 'package:flutter_ursffiver/features/auth/model/signup_model.dart';
import 'package:flutter_ursffiver/main.dart';
import 'package:get/get.dart';
import '../../../core/common/enum/interest_color.dart';
import '../../../core/common/model/create_custom_interest_param.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../presentation/screens/verify_screen.dart';

class SignUpController extends GetxController {
  final InterestSelectionController interestSelectionCntlr =
      InterestSelectionController();

  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  SnackbarNotifier? snackbarNotifier;

  RxList<CreateCustomInterestParam> customInterests = RxList([]);

  // NEW – live count of selected interests
  RxInt get selectedCount =>
      interestSelectionCntlr.selectedInterests.length.obs;

  // -----------------------------------------------------------------
  final firstName = ''.obs;
  final lastName = ''.obs;
  final username = ''.obs;
  final email = ''.obs;
  final dateOfBirth = ''.obs;
  final gender = ''.obs;
  final ageRange = ''.obs;
  final bio = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;

  void setFirstName(String value) {
    firstName.value = value;
    processNotifier.setEnabled();
  }

  void setLastName(String value) {
    lastName.value = value;
    processNotifier.setEnabled();
  }

  void setUsername(String value) {
    username.value = value;
    processNotifier.setEnabled();
  }

  void setEmail(String value) {
    email.value = value;
    processNotifier.setEnabled();
  }

  void setDateOfBirth(String value) {
    dateOfBirth.value = value;
    processNotifier.setEnabled();
  }

  void setGender(String value) {
    gender.value = value;
    processNotifier.setEnabled();
  }

  void setAgeRange(String value) {
    ageRange.value = value;
    processNotifier.setEnabled();
  }

  void setBio(String value) {
    bio.value = value;
    processNotifier.setEnabled();
  }

  void setPassword(String value) {
    password.value = value;
    processNotifier.setEnabled();
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
    processNotifier.setEnabled();
  }

  void addCustomInterest(String interest, InterestColor color) {
    customInterests.add(
      CreateCustomInterestParam(name: interest, color: color),
    );
  }

  void removeCustomInterestAt(int index) {
    if (index < customInterests.length && index >= 0) {
      customInterests.removeAt(index);
      customInterests.refresh();
    }
  }

  void editCustomInterestAt(int index, String? interest, InterestColor? color) {
    if (index < customInterests.length && index >= 0) {
      customInterests[index] = customInterests[index].copyWith(
        name: interest,
        color: color,
      );
      customInterests.refresh();
    }
  }

  // --- Build request model ---
  SignupRequestParam get signupModel => SignupRequestParam(
        firstName: firstName.value,
        lastName: lastName.value,
        username: username.value,
        email: email.value,
        dateOfBirth: dateOfBirth.value,
        gender: gender.value,
        ageRange: ageRange.value,
        bio: bio.value,
        password: password.value,
        confirmPassword: confirmPassword.value,
        selectedInterests:
            interestSelectionCntlr.selectedInterests.keys.toList(),
        customInterests: customInterests,
      );

  // --- Signup method ---
  Future<void> signup({
    ProcessStatusNotifier? buttonNotifier,
    SnackbarNotifier? snackbarNotifier,
    VoidCallback? onDone,
  }) async {
    buttonNotifier?.setLoading();
    final lr = await Get.find<AuthInterface>().signup(signupModel);
    return handleFold(
      either: lr,
      errorSnackbarNotifier: snackbarNotifier,
      successSnackbarNotifier: snackbarNotifier,
      onError: (failure) {
        buttonNotifier?.setError();
      },
      onSuccess: (success) {
        buttonNotifier?.setSuccess();
        Get.to(() => VerifyScreen(email: email.value, isFromRegisterScreen: true,));
        // navigatorKey.currentState?.pushNamed(RouteNames.emailVerification);
        onDone?.call();
      },
    );
  }
}