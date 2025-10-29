import 'dart:io';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/profile/interface/profile_interface.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../model/report_model.dart';

class ReportController extends GetxController {
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  var attachedFiles = <File>[].obs;
  var messageCharCount = 0.obs;
  final int maxMessageLength = 500;

  @override
  void onInit() {
    super.onInit();
    messageController.addListener(() {
      messageCharCount.value = messageController.text.length;
    });
  }

  Future<void> pickFiles(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        attachedFiles.value = result.paths.map((path) => File(path!)).toList();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error picking files: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFile(File file) {
    attachedFiles.remove(file);
  }

  /// Sends report with validation and calls backend API
  Future<void> sendReport({
    required ProcessStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
  }) async {
    final title = titleController.text.trim();
    final message = messageController.text.trim();

    // Validation
    if (title.isEmpty) {
      Get.snackbar(
        "Missing Info",
        "Please enter a title",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (message.isEmpty) {
      Get.snackbar(
        "Missing Info",
        "Please enter a message",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final report = ReportModel(
      title: title,
      message: message,
      url: attachedFiles.isNotEmpty ? attachedFiles.first.path : null,
    );

    debugPrint(
      "Report created => title: ${report.title}, message: ${report.message}, file: ${report.url}",
    );

    // Call API and handle result
    await reportandProblem(
      buttonNotifier: buttonNotifier,
      snackbarNotifier: snackbarNotifier,
    );

    // Reset form after submission
    titleController.clear();
    messageController.clear();
    attachedFiles.clear();

    Future.delayed(const Duration(seconds: 1), () {
      Get.back(); // navigate back
    });
  }

  @override
  void onClose() {
    titleController.dispose();
    messageController.dispose();
    super.onClose();
  }

  /// Calls backend API to send report
  Future<void> reportandProblem({
    required ProcessStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
  }) async {
    buttonNotifier?.setLoading();

    try {
      final report = ReportModel(
        title: titleController.text.trim(),
        message: messageController.text.trim(),
        url: attachedFiles.isNotEmpty ? attachedFiles.first.path : null,
      );

      final response = await Get.find<ProfileInterface>().reportandProblem(report);

      handleFold(
        either: response,
        processStatusNotifier: buttonNotifier,
        successSnackbarNotifier: snackbarNotifier,
      );
    } catch (e) {
      buttonNotifier?.setError();
    }
  }
}
