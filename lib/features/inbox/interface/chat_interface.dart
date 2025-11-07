import 'package:dartz/dartz.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/send_message_response_model.dart';

import '../../../core/api_handler/trycatch.dart';
import '../model/accept_reject_chat_req_param.dart';

abstract base class ChatInterface extends BaseRepository {
  Future<Either<DataCRUDFailure, Success<ChatData>>> inviteChat({
    required CreateChatRequestModel param,
  });

  Future<Either<DataCRUDFailure, Success<ChatData>>> acceptRejectChat({
    required AcceptRejectChatReqParam param,
  });

  Future<Either<DataCRUDFailure, Success<SendMessageResponseModel>>>
  sendMessage({required SendMessageRequestModel param});

  Future<Either<DataCRUDFailure, Success<List<ChatData>>>> getAllChat();
}
