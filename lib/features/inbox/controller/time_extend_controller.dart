import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_request_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/time_extend_model.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:get/get.dart';

class TimeExtendController extends GetxController {
  final InboxInterface inboxInterface;

  TimeExtendController({required this.inboxInterface});

  final TextEditingController timeController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> extendTime({
    required String input,
    required String chatId,
  }) async {
    if (input.isEmpty) return;

    try {
      isLoading.value = true;

      final param = TimeExtendModel(
        sendMessageReqParam: SendMessageReqParam(
          chatId: chatId,
          content: '',
          attachments: [],
        ),
        time: int.parse(input),
      );

      await inboxInterface.timeExtend(param);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    timeController.dispose();
    super.onClose();
  }
}
