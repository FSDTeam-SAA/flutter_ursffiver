import 'package:flutter_ursffiver/core/constants/route_names.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/signup_model.dart';
import 'package:flutter_ursffiver/main.dart';
import 'package:get/get.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';

class SignUpController extends GetxController {
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );
  SnackbarNotifier? snackbarNotifier;
  SignUpController();

  void initSignUpCntlr(SnackbarNotifier? snackbarNotifier) {
    snackbarNotifier = snackbarNotifier;
  }

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

  // --- Create model ---
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
  );

  // --- Example signup method ---
  Future<void> signup({
    ProcessStatusNotifier? buttonNotifier,
    SnackbarNotifier? snackbarNotifier,
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
        navigatorKey.currentState?.pushNamed(RouteNames.emailVerification);
      },
    );
  }
}
