import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_response_model.dart';

final class ChatInterfaceImpl extends ChatInterface {
  final AppPigeon appPigeon;

  ChatInterfaceImpl({required this.appPigeon});

  /// Helper function like AuthInterfaceImpl
  Future<Either<DataCRUDFailure, Success<T>>> asyncTryCatch<T>({
    required Future<Success<T>> Function() tryFunc,
  }) async {
    try {
      final result = await tryFunc();
      return Right(result);
    } catch (e, s) {
      debugPrint("❌ Chat API Error: $e\n$s");
      return Left(
        DataCRUDFailure(
          failure: Failure.unknownFailure,
          uiMessage: e.toString(),
          fullError: e.toString(),
        ),
      );
    }
  }

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
  Future<Either<DataCRUDFailure, Success<CreateChatResponseModel>>> inviteChat({
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

        final model = CreateChatResponseModel.fromJson(dataMap);

        return Success(message: "Chat Created", data: model);
      },
    );
  }
}

