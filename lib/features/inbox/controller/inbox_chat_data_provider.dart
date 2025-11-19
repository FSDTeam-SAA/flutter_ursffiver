import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controller.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/accept_reject_chat_req_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:get/get.dart';

class InboxChatDataProvider extends GetxController {
  RxList<ChatController> chats = RxList<ChatController>([]);
  StreamSubscription<MessageModel>? _newMessageSubscription;
  StreamSubscription<ChatModel>? _chatUpdateSubscription;

  final InboxInterface chatInterface = Get.find<InboxInterface>();

  @override
  void dispose() {
    // TODO: implement dispose
    _newMessageSubscription?.cancel();
    _chatUpdateSubscription?.cancel();
    super.dispose();
  }

  InboxChatDataProvider() {
    _getChats();
    _listenToNewMessageStream();
    _listenToChatStream();
  }

  Future<void> _getChats() async {
    //fetch chats and populate the list
    final result = await Get.find<InboxInterface>().getAllChat();
    handleFold(
      either: result,
      onError: (failure) {},
      onSuccess: (success) {
        chats = RxList(success
            .map(
              (chatModel) => ChatController.withChatModel(
                chatId: chatModel.id,
                chatModel: chatModel,
              ),
            )
            .toList());
        _sortChatsByLastMessage();
        update();
      },
    );
  }

  void _listenToChatStream() {
    _chatUpdateSubscription = Get.find<InboxInterface>().chatStream().listen((
      chatModel,
    ) {
      //find the chat controller and update
      final chatController = chats.firstWhere(
        (chatCtrl) => chatCtrl.chatId == chatModel.id,
        orElse: () => ChatController.withChatModel(
          chatId: chatModel.id,
          chatModel: chatModel,
        ),
      );
      if(chatModel.lastMessage != null) chatController.updateWithNewMessage(chatModel.lastMessage!);
      //move the chat to top
      chats.removeWhere((chatCtrl) => chatCtrl.chatId == chatModel.id);
      chats.insert(0, chatController);
      chats.refresh();
      update();
    });
  }

  void _listenToNewMessageStream() {
    _newMessageSubscription = Get.find<InboxInterface>().messageStream().listen(
      (messageModel) {
        //find the chat controller and update
        final chatController = chats.firstWhere(
          (chatCtrl) => chatCtrl.chatId == messageModel.chatId,
          orElse: () => ChatController(chatId: messageModel.chatId),
        );
        chatController.updateWithNewMessage(messageModel);
        //move the chat to top
        chats.removeWhere((chatCtrl) => chatCtrl.chatId == messageModel.chatId);
        chats.insert(0, chatController);
        update();
      },
    );
  }

  void _sortChatsByLastMessage() {
    chats.sort((a, b) {
      final aTime = a.lastMessageDate;
      final bTime = b.lastMessageDate;
      return bTime.compareTo(aTime);
    });
  }

  //-----------------------------invite chat---------------------
  Future<ChatModel?> inviteChat({required String userId}) async {
    final result = await chatInterface.inviteChat(
      param: CreateChatRequestModel(userId: userId),
    );
    return result.fold((failure) {
      debugPrint("❌ CreateChat Error: $failure");
      return null;
    }, (success) => success.data);
  }

  // //-------------------------Accept chat-----------------

  Future<bool> acceptChat(String chatId) async {
    final result = await chatInterface.acceptRejectChat(
      param: AcceptRejectChatReqParam.accept(chatId: chatId),
    );
    return result.fold(
      (failure) {
        debugPrint("❌ AcceptChat Error: $failure");
        return false;
      },
      (success) {
        debugPrint("✅ Chat Accepted: ${success.data?.id}");
        // Update chatList to reflect the accepted chat status
        final updatedChat = success.data;
        if (updatedChat != null) {
          final index = chats.indexWhere((c) => c.chatId == chatId);
          if (index != -1) {
            chats[index] = ChatController.withChatModel(
              chatId: updatedChat.id,
              chatModel: updatedChat,
            );
            update(); // Notify observers
          }
        }
        return true;
      },
    );
  }

  // //-------------------------Reject chat-----------------
  Future<bool> rejectChat(String chatId) async {
    final result = await chatInterface.acceptRejectChat(
      param: AcceptRejectChatReqParam.reject(chatId: chatId),
    );
    return result.fold(
      (failure) {
        debugPrint("❌ RejectChat Error: $failure");
        return false;
      },
      (success) {
        debugPrint("✅ Chat Rejected: ${success.data?.id}");
        // Update chatList to reflect the rejected chat status
        return true;
      },
    );
  }
}
