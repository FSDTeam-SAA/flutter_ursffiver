import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/constants/api_endpoints.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/get_messages_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_param.dart';
import 'package:flutter_ursffiver/features/inbox/service/inbox_interface.dart';

import '../../../core/services/app_pigeon/app_pigeon.dart';

final class InboxService extends InboxInterface{

  final AppPigeon appPigeon;
  InboxService({required this.appPigeon});

  @override
  FutureRequest<Success<List<ChatModel>>> getChats() async{
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(ApiEndpoints.getAllChat);

        //parse
        final data = response.data["data"] as List<dynamic>;
        final List<ChatModel> chats = [];

        for (int i = 0; i < data.length; i++) {
          chats.add(ChatModel.fromMap(data[i]));
        }

        //return
        return Success(
          message: extractSuccessMessage(response),
          data: chats,
        );
      },
    );
  }

  @override
  FutureRequest<Success<List<MessageModel>>> getMessages(GetMessagesParam param) async{
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
          messages.add(MessageModel.fromMap(data[i]));
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
  FutureRequest<Success<MessageModel>> sendMessage(SendMessageParam param) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.post(
          ApiEndpoints.sendMessage(param.chatId),
          data: await param.toFormData(),
        );

        //parse
        final data = response.data["data"];
        final message = MessageModel.fromMap(data);

        //return
        return Success(
          message: extractSuccessMessage(response),
          data: message,
        );
      },
    );
  }
  
  @override
  FutureRequest<Success<ChatModel>> getChat(String chatId) async{
    return await asyncTryCatch(
      tryFunc: () async {
        //api call
        final response = await appPigeon.get(
          ApiEndpoints.getSingleChat(chatId),
        );

        //parse
        final data = response.data["data"];
        final chat = ChatModel.fromMap(data);

        //return
        return Success(
          message: extractSuccessMessage(response),
          data: chat,
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
        return Success(
          message: extractSuccessMessage(response),
          data: null,
        );
      },
    );
    
  }
  
  @override
  Stream<MessageModel> messageStream() {
    return appPigeon.listen("newMessage").map((event) => MessageModel.fromMap(event));
  }
  
  @override
  Stream<ChatModel> chatStream() {
    return appPigeon.listen("chatUpdate").map((event) => ChatModel.fromMap(event));
  }
}