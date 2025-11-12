import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';
import 'package:flutter_ursffiver/core/notifiers/snackbar_notifier.dart';
import 'package:flutter_ursffiver/features/home/model/verification_model.dart';
import 'package:flutter_ursffiver/features/home/service/home_interface.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VerificationController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final RxList<File> selectedFiles = <File>[].obs;
  Future<void> pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null) {
      for (final platformFile in result.files) {
        if (platformFile.path != null) {
          selectedFiles.add(File(platformFile.path!));
        }
      }
    }
  }

  Future<void> takeImage() async {
    final XFile? img = await _picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      selectedFiles.add(File(img.path));
    }
  }

  void removeFile(int index) => selectedFiles.removeAt(index);
  Future<void> submitDocuments({
    required ProcessStatusNotifier? buttonNotifier,
    required SnackbarNotifier? snackbarNotifier,
  }) async {
    if (selectedFiles.isEmpty) {
      Get.snackbar(
        "Missing Info",
        "Please select at least one document",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    final attachment = Attachment(file: selectedFiles.first);

    buttonNotifier?.setLoading();

    try {
      final response = await Get.find<HomeInterface>().verification(attachment);

      handleFold(
        either: response,
        processStatusNotifier: buttonNotifier,
        successSnackbarNotifier: snackbarNotifier,
      );
    } catch (e) {
      buttonNotifier?.setError();
    } finally {
      // Reset UI
      selectedFiles.clear();
      Future.delayed(const Duration(seconds: 2), () => Get.back());
    }
  }

  @override
  void onClose() {
    selectedFiles.clear();
    super.onClose();
  }
}