

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/controller/select_interest_controller.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/utils/helpers/handle_future_request.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/signup_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/create_custom_interest_req_param.dart';
import '../model/username_check_response.dart';

class SignUpController extends GetxController {
  final Debouncer _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  final InterestSelectionController interestSelectionCntlr =
      InterestSelectionController();

  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  SnackbarNotifier? snackbarNotifier;

  RxList<CreateCustomInterestReqParam> customInterests = RxList([]);

  // NEW – live count of selected interests
  RxInt get selectedCount =>
      interestSelectionCntlr.selectedIndexCnt;

  // -----------------------------------------------------------------
  final firstName = ''.obs;
  final lastName = ''.obs;
  final username = ''.obs;
  final email = ''.obs;
  final dateOfBirth = Rx<DateTime?>(null);
  final Rx<String?> gender = Rx<String?>(null);
  final Rx<String?> ageRange = Rx<String?>(null);
  final bio = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final RxBool showPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;
  final Rx<UsernameCheckResponse?> usernameCheckResponse = Rx<UsernameCheckResponse?>(null);

  void setFirstName(String value) {
    firstName.value = value;
    if(firstName.value.isNotEmpty && firstName.value[0] != firstName.value[0].toUpperCase()) firstName.value = firstName.value[0].toUpperCase() + firstName.value.substring(1);
    processNotifier.setEnabled();
  }

  void setLastName(String value) {
    lastName.value = value;
    if(lastName.value.isNotEmpty && lastName.value[0] != lastName.value[0].toUpperCase()) lastName.value = lastName.value[0].toUpperCase() + lastName.value.substring(1);
    processNotifier.setEnabled();
  }

  void setUsername(String value) {
    username.value = value;
    processNotifier.setEnabled();
    _debouncer.call(() {
      _checkUsernameAvailability(value);
    });
  }

  Future<void> _checkUsernameAvailability(String username) async {
    if(username.isEmpty) {
      usernameCheckResponse.value = null;
      return;
    }
    final UsernameCheckResponse? response = await handleFutureRequest(futureRequest: () {
      return  Get.find<AuthInterface>().checkUsernameAvailability(username);
    });
    usernameCheckResponse.value = response;
  }

  void setEmail(String value) {
    email.value = value;
    processNotifier.setEnabled();
  }

  void setDateOfBirth(DateTime value) {
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

  // void addCustomInterest(String interest, InterestColor color) {
  //   customInterests.add(
  //     CreateCustomInterestReqParam(name: interest, color: color),
  //   );
  // }

  // void removeCustomInterestAt(int index) {
  //   if (index < customInterests.length && index >= 0) {
  //     customInterests.removeAt(index);
  //     customInterests.refresh();
  //   }
  // }

  // void editCustomInterestAt(int index, String? interest, InterestColor? color) {
  //   if (index < customInterests.length && index >= 0) {
  //     customInterests[index] = customInterests[index].copyWith(
  //       name: interest,
  //       color: color,
  //     );
  //     customInterests.refresh();
  //   }
  // }

  // --- Build request model ---
  

  // --- Signup method ---
  Future<void> signup({
    ProcessStatusNotifier? buttonNotifier,
    SnackbarNotifier? snackbarNotifier,
    VoidCallback? onDone,
  }) async{
    _debouncer.call(() {
      _signup(
        buttonNotifier: buttonNotifier,
        snackbarNotifier: snackbarNotifier,
        onDone: onDone,
      );
    });
  }

  Future<void> _signup({
    ProcessStatusNotifier? buttonNotifier,
    SnackbarNotifier? snackbarNotifier,
    VoidCallback? onDone,
  }) async {
    if(dateOfBirth.value == null) {
      snackbarNotifier?.notify(message: "Please select your date of birth.");
      return;
    }
    buttonNotifier?.setLoading();
    SignupRequestParam signupModel = SignupRequestParam(
        firstName: firstName.value,
        lastName: lastName.value,
        username: username.value,
        email: email.value,
        dateOfBirth: dateOfBirth.value!,
        gender: gender.value,
        ageRange: ageRange.value,
        bio: bio.value,
        password: password.value,
        confirmPassword: confirmPassword.value,
        selectedInterests:
            interestSelectionCntlr.selectedInterests.keys.toList(),
        customInterests: interestSelectionCntlr.customRequests.keys.toList(),
      );
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
        onDone?.call();
      },
    );
  }
}