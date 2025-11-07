import 'package:dartz/dartz.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/helpers/typedefs.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/get_messages_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_request_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_response_model.dart';

import '../../../core/api_handler/trycatch.dart';
import '../model/accept_reject_chat_req_param.dart';

abstract base class InboxInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<List<ChatModel>>>> getAllChat();
  Future<Either<DataCRUDFailure, Success<ChatModel>>> inviteChat({
    required CreateChatRequestModel param,
  });

  Future<Either<DataCRUDFailure, Success<ChatModel>>> acceptRejectChat({
    required AcceptRejectChatReqParam param,
  });

  FutureRequest<Success<ChatModel>> getChat(String chatId);

  FutureRequest<Success<List<MessageModel>>> getMessages(
    GetMessagesReqParam param,
  );

  FutureRequest<Success<MessageModel>> sendMessage(SendMessageReqParam param);

  FutureRequest<Success<void>> markMessageAsRead(String messageId);

  Stream<MessageModel> messageStream();

  Stream<ChatModel> chatStream();
}
