import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/create_new_password_model.dart';
import 'package:get/get.dart';

class CreateNewPasswordController extends GetxController {
  final String email;
  CreateNewPasswordController({required this.email});

  String _newPassword = '';
  String get newPassword => _newPassword;
  set newPassword(String value) {
    _newPassword = value;
    debugPrint("New Password: $_newPassword");
  }

  String _confirmPassword = '';
  String get confirmPassword => _confirmPassword;
  set confirmPassword(String value) {
    _confirmPassword = value;
    debugPrint("Confirm Password: $_confirmPassword");
  }

  bool get isFormValid {
    return _newPassword.isNotEmpty &&
        _confirmPassword.isNotEmpty &&
        _newPassword == _confirmPassword;
  }

  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );

  void createNewPassword(SnackbarNotifier? snackbarNotifier) async {
    if (isFormValid) {
      processNotifier.setEnabled();
    } else {
      processNotifier.setDisabled();
    }

    await Get.find<AuthInterface>()
        .createNewPassword(
          CreatePasswordModel(
            email: email,
            newPassword: newPassword,
            confirmPassword: confirmPassword,
          ),
        )
        .then((lr) {
          handleFold(
            either: lr,
            processStatusNotifier: processNotifier,
            successSnackbarNotifier: snackbarNotifier,
            errorSnackbarNotifier: snackbarNotifier,
          );
        });
  }
}
