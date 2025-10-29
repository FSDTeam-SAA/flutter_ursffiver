import 'package:dartz/dartz.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';

abstract base class ChatInterface {
  // Future<Either<DataCRUDFailure, Success<CreateChatResponseModel>>> createChat({
  //   required CreateChatRequestModel param,
  // });

  Future<Either<DataCRUDFailure, Success<List<ChatData>>>> getAllChat();

  // Future<Either<DataCRUDFailure, Success<ChatData>>> getChatById(String chatId);

  // Future<Either<DataCRUDFailure, Success<GetChatSellerResponseModel>>> getChatSeller({
  //   required GetChatSellerRequestModel param,
  // });

  // Future<Either<DataCRUDFailure, Success<SendMessageResponseModel>>> sendMessage({
  //   required SendMessageRequestModel param,
  // });
}