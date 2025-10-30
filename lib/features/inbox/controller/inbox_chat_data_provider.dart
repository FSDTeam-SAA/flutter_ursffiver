import 'dart:async';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controller.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:get/get.dart';
import '../service/inbox_interface.dart';

class InboxChatDataProvider extends GetxController{
  List<ChatController> chats = [];
  StreamSubscription<MessageModel>? _newMessageSubscription;
  StreamSubscription<ChatModel>? _chatUpdateSubscription;

  @override
  void dispose() {
    // TODO: implement dispose
    _newMessageSubscription?.cancel();
    _chatUpdateSubscription?.cancel();
    super.dispose();
  }

  InboxChatDataProvider(){
    _getChats();
    _listenToNewMessageStream();
    _listenToChatStream();
  }

  Future<void> _getChats() async {
    //fetch chats and populate the list
    final result = await Get.find<InboxInterface>().getChats();
    handleFold(
      either: result,
      onError: (failure) {

      },
      onSuccess: (success) {
        chats = success.map((chatModel) => ChatController.withChatModel(chatId: chatModel.id, chatModel: chatModel)).toList();
        _sortChatsByLastMessage();
        update();
      },
    );
  }

  void _listenToChatStream(){
    _chatUpdateSubscription = Get.find<InboxInterface>().chatStream().listen((chatModel) {
      //find the chat controller and update
      final chatController = chats.firstWhere((chatCtrl) => chatCtrl.chatId == chatModel.id, orElse: () => ChatController.withChatModel(chatId: chatModel.id, chatModel: chatModel));
      chatController.updateWithNewMessage(chatModel.lastMessage!);
      //move the chat to top
      chats.removeWhere((chatCtrl) => chatCtrl.chatId == chatModel.id);
      chats.insert(0, chatController);
      update();
    });
  }

  void _listenToNewMessageStream(){
    _newMessageSubscription = Get.find<InboxInterface>().messageStream().listen((messageModel) {
      //find the chat controller and update
      final chatController = chats.firstWhere((chatCtrl) => chatCtrl.chatId == messageModel.chatId, orElse: () => ChatController(chatId: messageModel.chatId));
      chatController.updateWithNewMessage(messageModel);
      //move the chat to top
      chats.removeWhere((chatCtrl) => chatCtrl.chatId == messageModel.chatId);
      chats.insert(0, chatController);
      update();
    });
  }

  void _sortChatsByLastMessage(){
    chats.sort((a, b) {
      final aTime = a.lastMessageTime;
      final bTime = b.lastMessageTime;
      return bTime.compareTo(aTime);
    });
  }
}