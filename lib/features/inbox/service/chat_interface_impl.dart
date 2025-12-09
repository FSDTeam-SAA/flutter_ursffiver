import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/get_messages_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_request_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/time_extend_model.dart';

import '../model/accept_reject_chat_req_param.dart';
import '../model/chat_model.dart';

final class ChatInterfaceImpl extends InboxInterface {
  final AppPigeon appPigeon;

  ChatInterfaceImpl({required this.appPigeon});

  ///-----------------------------------Get All Chats-----------------------------------
  @override
  Future<Either<DataCRUDFailure, Success<List<ChatModel>>>> getAllChat() async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.get('/chat/get-chat');
        debugPrint("Get all chats response: ${response.data}");

        // Handle different response formats
        if (response.data is Map<String, dynamic>) {
          final dataMap = response.data as Map<String, dynamic>;

          if (dataMap['data'] is List) {
            final chatList = (dataMap['data'] as List)
                .map((item) => ChatModel.fromMap(item))
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
  Future<Either<DataCRUDFailure, Success<ChatModel>>> inviteChat({
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
        final model = ChatModel.fromJson(dataMap['data']);

        return Success(message: "Chat Created", data: model);
      },
    );
  }

  @override
  Future<Either<DataCRUDFailure, Success<ChatModel>>> acceptRejectChat({
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

        final model = ChatModel.fromJson(dataMap['data']);

        return Success(message: "Chat Accepted", data: model);
      },
    );
  }

  @override
  @override
  Stream<ChatModel> chatStream() {
    return appPigeon
        .listen("chatUpdate")
        .map((event) => ChatModel.fromJson(event));
  }

  @override
  FutureRequest<Success<ChatModel>> getChat(String chatId) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(
          ApiEndpoints.getSingleChat(chatId),
        );

        //parse
        final data = response.data["data"];
        final chat = ChatModel.fromJson(data);

        //return
        return Success(message: extractSuccessMessage(response), data: chat);
      },
    );
  }

  @override
  FutureRequest<Success<List<MessageModel>>> getMessages(
    GetMessagesReqParam param,
  ) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(
          ApiEndpoints.getMessages(param.chatId),
          query: param.toMap().isEmpty ? null : param.toMap(),
        );

        //parse
        final data = response.data["data"] as List<dynamic>;
        final List<MessageModel> messages = [];

        for (int i = 0; i < data.length; i++) {
          messages.add(MessageModel.fromJson(data[i]));
        }

        //return
        return Success(
          message: extractSuccessMessage(response),
          data: messages,
        );
      },
    );
  }

  @override
  FutureRequest<Success<void>> markMessageAsRead(String messageId) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.post(
          ApiEndpoints.messageRead(messageId),
        );

        //return
        return Success(message: extractSuccessMessage(response), data: null);
      },
    );
  }

  @override
  Stream<MessageModel> messageStream() {
    return appPigeon
        .listen("messageUpdate")
        .map((event) => MessageModel.fromJson(event));
  }

  @override
  FutureRequest<Success<MessageModel>> sendMessage(
    SendMessageReqParam param,
  ) async {
    debugPrint(
      "Sending message with param: ${param.chatId}, ${param.content}, attachments: ${param.attachments.length}",
    );
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.post(
          ApiEndpoints.sendMessage(param.chatId),
          data: param.toJson(),
        );

        //parse

        //return
        return Success(message: extractSuccessMessage(response), data: null);
      },
    );
  }

  @override
  FutureRequest<Success> extendTime(TimeExtendReqParam param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        final response = await appPigeon.patch(
          ApiEndpoints.timeExtend(param.chatId),
          data: param.toJson(),
        );
        final message = extractSuccessMessage(response);
        return Success(message: message);
      },
    );
  }
}
