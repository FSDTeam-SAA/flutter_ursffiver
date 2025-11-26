import 'dart:io';

import 'package:dio/dio.dart';

class SendMessageParam {
  final String chatId;
  final String content;
  final List<File> attachments;
  final String? replyToMessageId;

  SendMessageParam({
    required this.chatId,
    required this.content,
    required this.attachments,
    this.replyToMessageId,
  });

  Future<FormData> toFormData() async{
    final FormData formData = FormData();
    formData.fields.add(MapEntry('chatId', chatId));
    formData.fields.add(MapEntry('content', content));
    if(replyToMessageId != null){
      formData.fields.add(MapEntry('replyToMessageId', replyToMessageId!));
    }
    for (var i = 0; i < attachments.length; i++) {
      formData.files.add(MapEntry('attachments[$i]', await MultipartFile.fromFile(attachments[i].path)));
    }
    return formData;
  }
}