import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/api_handler/failure.dart';
import 'package:flutter_ursffiver/core/api_handler/success.dart';
import 'package:flutter_ursffiver/core/services/app_pigeon/app_pigeon.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';

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
      return Left(DataCRUDFailure(
        failure: Failure.unknownFailure,
        uiMessage: e.toString(),
        fullError: e.toString(),
      ));
    }
  }

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
}