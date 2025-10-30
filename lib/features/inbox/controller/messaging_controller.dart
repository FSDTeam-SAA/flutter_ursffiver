import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_param.dart';
import 'package:get/get.dart';

import '../../../core/helpers/handle_fold.dart';
import '../service/inbox_interface.dart';

class MessagingController extends GetxController{
  final String chatId;
  final TextEditingController messageController = TextEditingController();
  final List<File> attachedFiles = [];

  MessagingController({required this.chatId});

  void attachFile(File file){
    attachedFiles.add(file);
    update();
  }

  void removeAttachedFileAt(int index){
    attachedFiles.removeAt(index);
    update();
  }

  void clearMessage(){
    messageController.clear();
    attachedFiles.clear();
    update();
  }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    if(messageText.isEmpty && attachedFiles.isEmpty){
      return;
    }

    final result = await Get.find<InboxInterface>().sendMessage(
      SendMessageParam(chatId: chatId, content: messageText, attachments: attachedFiles)
    );

    handleFold(
      either: result,
      onError: (failure) {
        
      },
      onSuccess: (success) {
        clearMessage();
      },
    );
  }

}