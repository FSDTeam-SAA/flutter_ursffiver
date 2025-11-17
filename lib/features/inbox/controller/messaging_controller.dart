import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../interface/chat_interface.dart';
import '../model/send_message_request_param.dart';

class MessagingController extends GetxController {
  final String chatId;
  final TextEditingController textInputController = TextEditingController();
  final List<File> attachedFiles = [];

  MessagingController({required this.chatId});

  void attachFile(File file) {
    attachedFiles.add(file);
    update();
  }

  void removeAttachedFileAt(int index) {
    attachedFiles.removeAt(index);
    update();
  }

  void clearMessage() {
    textInputController.clear();
    attachedFiles.clear();
    update();
  }

  Future<void> sendMessage() async {
    final messageText = textInputController.text.trim();
    if (messageText.isEmpty && attachedFiles.isEmpty) {
      return;
    }

    final result = await Get.find<InboxInterface>().sendMessage(
      SendMessageReqParam(
        chatId: chatId,
        content: messageText,
        attachments: attachedFiles,
      ),
    );

    handleFold(
      either: result,
      onError: (failure) {},
      onSuccess: (success) {
        
      },
    );
    clearMessage();
  }
}
