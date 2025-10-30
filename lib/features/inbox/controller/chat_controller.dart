import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/get_messages_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/service/inbox_interface.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  final String chatId;
  ChatModel? _chatModel;
  String _chatTitle = "";
  MessageModel? _lastMessage;

  String get lastMessage => _lastMessage?.text ?? "";

  String get lastMessageTime => _lastMessage != null ? "${_lastMessage!.createdAt.hour}:${_lastMessage!.createdAt.minute}" : "";

  bool get lastMessageSeen => _lastMessage?.isRead ?? false;

  String get chatTitle => _chatTitle;

  List<MessageModel> get messages => [];

  ChatController({required this.chatId}){
    if(_chatModel == null){
      _getChat();
    }
  }

  ChatController.withChatModel({required this.chatId, required ChatModel chatModel}){
    _chatModel = chatModel;
  }

  Future<void> _getChat() async {
    //fetch chat by id
    final result = await Get.find<InboxInterface>().getChat(chatId);

    handleFold(
      either: result,
      onError: (failure) {
        
      },
      onSuccess: (success) {
        _chatModel = success;
        _chatTitle = _chatModel?.title ?? "";
        _lastMessage = _chatModel?.lastMessage;
        update();
      },
    );
  }

  Future<void> getMessages() async {
    final result = await Get.find<InboxInterface>().getMessages(
      GetMessagesParam(chatId: chatId, limit: 20, beforeMessageId: _lastMessage?.id),
    );
    handleFold(
      either: result,
      onError: (failure) {
        
      },
      onSuccess: (success) {
        if(success.isNotEmpty){
          _lastMessage = success.last;
          messages.addAll(success);
          update();
        }
      },
    );
  }

  void updateWithNewMessage(MessageModel messageModel) {
    _lastMessage = messageModel;
    messages.add(messageModel);
    update();
  }

}