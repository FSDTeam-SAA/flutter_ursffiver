import 'package:flutter/rendering.dart';
import 'package:flutter_ursffiver/core/helpers/handle_fold.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/get_messages_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final String chatId;
  ChatModel? chatModel;
  String _chatTitle = "unknown";
  MessageModel? _lastMessage;

  String get lastMessage => _lastMessage?.text ?? "";

  DateTime get lastMessageDate => _lastMessage?.date ?? DateTime.now();

  String get lastMessageTime => _lastMessage != null
      ? "${_lastMessage!.date.hour}:${_lastMessage!.date.minute}"
      : "";

  bool get lastMessageSeen => _lastMessage?.read ?? false;

  String get chatTitle => chatModel?.name ?? "Unknown";

  RxList<MessageModel> messages = RxList<MessageModel>([]);

  ChatController({required this.chatId}) {
    if (chatModel == null) {
      _getChat();
    }
    getMessages();
  }

  ChatController.withChatModel({
    required this.chatId,
    required ChatModel chatModel,
  }) {
    this.chatModel = chatModel;
    getMessages();
  }

  Future<void> _getChat() async {
    //fetch chat by id
    final result = await Get.find<InboxInterface>().getChat(chatId);

    handleFold(
      either: result,
      onError: (failure) {},
      onSuccess: (success) {
        chatModel = success;
        _chatTitle = chatModel?.name ?? "";
        _lastMessage = chatModel?.lastMessage;
        update();
      },
    );
  }

  Future<void> getMessages() async {
    debugPrint("Fetching messages for chatId: $chatId");
    final result = await Get.find<InboxInterface>().getMessages(
      GetMessagesReqParam(
        chatId: chatId,
        limit: 20,
        beforeMessageId: _lastMessage?.id,
      ),
    );
    handleFold(
      either: result,
      onError: (failure) {},
      onSuccess: (success) {
        if (success.isNotEmpty) {
          _lastMessage = success.last;
          messages.addAll(success);
          update();
        }
      },
    );
  }

  void updateWithNewMessage(MessageModel messageModel) {
    // IF the message already exists, do not add it again, update instead
    if (messages.any((msg) => msg.id == messageModel.id)) {
      final index =
          messages.indexWhere((msg) => msg.id == messageModel.id);
      messages[index] = messageModel;
      if (_lastMessage == null ||
          messageModel.date.isAfter(_lastMessage!.date)) {
        _lastMessage = messageModel;
      }
      update();
      return;
    }
    _lastMessage = messageModel;
    messages.add(messageModel);
    update();
  }
}
