import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_response_model.dart';
import 'package:get/get.dart';

import '../model/accept_reject_chat_req_param.dart';

final class ChatInterfaceImpl extends ChatInterface {
  final AppPigeon appPigeon;

  ChatInterfaceImpl({required this.appPigeon});

  ///-----------------------------------Get All Chats-----------------------------------
  @override
  Future<Either<DataCRUDFailure, Success<List<ChatData>>>> getAllChat() async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get('/chat/get-chat');
        debugPrint("Get all chats response: ${response.data}");

        // Handle different response formats
        if (response.data is Map<String, dynamic>) {
          final dataMap = response.data as Map<String, dynamic>;

          if (dataMap['data'] is List) {
            final chatList = (dataMap['data'] as List)
                .map((item) => ChatData.fromJson(item))
                .toList();
            return Success(message: "Chats Loaded", data: chatList);
          }
        }

        // If response format is unexpected, return empty list
        return Success(message: "Chats Loaded", data: []);
      },
    );
  }

  @override
  Future<Either<DataCRUDFailure, Success<ChatData>>> inviteChat({
    required CreateChatRequestModel param,
  }) async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          '/chat/create-chat',
          data: param.toJson(),
        );

        final dataMap = (response.data is Map<String, dynamic>)
            ? response.data
            : Map<String, dynamic>.from(response.data);
        debugPrint("Create chat response: $dataMap");
        final model = ChatData.fromJson(dataMap['data']);

        return Success(message: "Chat Created", data: model);
      },
    );
  }

  @override
  Future<Either<DataCRUDFailure, Success<ChatData>>> acceptRejectChat({
    required AcceptRejectChatReqParam param,
  }) async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.patch(
          '/chat/accept/${param.chatId}',
          data: param.toJson(),
        );
        debugPrint("Accept chat response: $response");
        debugPrint("Accept chat response: ${response.data}");

        final dataMap = (response.data is Map<String, dynamic>)
            ? response.data
            : Map<String, dynamic>.from(response.data);

        debugPrint("Accept chat response: $dataMap");

        final model = ChatData.fromJson(dataMap['data']);

        return Success(message: "Chat Accepted", data: model);
      },
    );
  }

  @override
  Future<Either<DataCRUDFailure, Success<SendMessageResponseModel>>> 
  sendMessage({required SendMessageRequestModel param}) async {
    return asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.post(
          '/chat/send-message',
          data: param.toJson(),
        );

        final dataMap = (response.data is Map<String, dynamic>)
            ? response.data
            : Map<String, dynamic>.from(response.data);
        debugPrint("Send message response: $dataMap");
        final model = SendMessageResponseModel.fromJson(dataMap['data']);

        return Success(message: "Message Sent", data: model);
      },
    );
  }
}
