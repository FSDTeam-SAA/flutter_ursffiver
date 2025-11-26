import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/auth/interface/auth_interface.dart';
import 'package:flutter_ursffiver/features/auth/model/forget_password_model.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );
  final SnackbarNotifier snackbarNotifier;
  ForgetPasswordController({required this.snackbarNotifier});

  String _email = '';
  String get email => _email;
  set email(String value) {
    if (value != _email) {
      _email = value;
      processNotifier.setEnabled();
    }
  }

  Future<void> forgetPassword({
    required ProcessStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
  }) async {
    buttonNotifier?.setLoading();
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      await Get.find<AuthInterface>()
          .forgetpassword(ForgetPasswordModel(email: email))
          .then((lr) {
            handleFold(
              either: lr,
              processStatusNotifier: buttonNotifier,
              successSnackbarNotifier: snackbarNotifier,
              errorSnackbarNotifier: snackbarNotifier,
            );
          });
    });
  }
}
