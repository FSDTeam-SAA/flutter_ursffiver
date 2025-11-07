import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/socket_service/socket_service.dart'
    show SocketService;
import 'package:get/get.dart';

import '../model/accept_reject_chat_req_param.dart';

class ChatController extends GetxController {
  ChatController._internal();
  static ChatController instance = ChatController._internal();
  factory ChatController() => instance;

  final ChatInterface chatInterface = Get.find<ChatInterface>();
  final RxMap<String, RxList<Message>> chatMessages =
      RxMap<String, RxList<Message>>();
  final Rx<List<ChatData>> chatList = Rx<List<ChatData>>([]);
  final RxList<ChatData> sellerChats = <ChatData>[].obs;
  final RxBool isLoading = false.obs;

  final SocketService socketService = SocketService();

  /// Init socket for real-time chat
  void initSocket() {
    socketService.connect();

    socketService.on("new_message", (data) {
      try {
        final message = Message.fromJson(data);
        final chatId = data["chatId"];
        if (chatMessages.containsKey(chatId)) {
          chatMessages[chatId]!.add(message);
        } else {
          chatMessages[chatId] = RxList<Message>([message]);
        }
        update();
      } catch (e) {
        debugPrint("❌ Error parsing incoming message: $e");
      }
    });
  }

  @override
  void onClose() {
    socketService.disconnect();
    super.onClose();
  }

  //-------------Get all chats----------------------
  Future<void> getAllChat() async {
    isLoading.value = true;
    try {
      final result = await chatInterface.getAllChat();
      result.fold((failure) => debugPrint("❌ GetAllChat Error: $failure"), (
        success,
      ) {
        if (success.data != null) {
          debugPrint("GetAllChat Success: ${success.data!.length}");
          chatList.value = success.data!;
          for (final chat in chatList.value) {
            chatMessages[chat.id] = RxList<Message>(
              chat.lastMessage != null ? [chat.lastMessage!] : [],
            );
          }
        }
      });
    } finally {
      isLoading.value = false;
    }
  }

  //-----------------------------invite chat---------------------
  Future<ChatData?> inviteChat({required String userId}) async {
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
          final index = chatList.value.indexWhere((c) => c.id == chatId);
          if (index != -1) {
            chatList.value[index] = updatedChat;
            chatList.refresh(); // Notify observers
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

  // void sendMessageSocket({
  //   required String chatId,
  //   required String text,
  //   required ProfileData currentUser,
  // }) {
  //   final messageData = {
  //     "chatId": chatId,
  //     "text": text,
  //     "user": currentUser.toJson(), // send full ProfileData
  //   };
  //   socketService.emit("send_message", messageData);

  //   // Add message locally for instant UI update
  //   final message = Message(
  //     text: text,
  //     user: currentUser,
  //     date: DateTime.now().toIso8601String(),
  //     read: false,
  //   );
  //   if (chatMessages.containsKey(chatId)) {
  //     chatMessages[chatId]!.add(message);
  //   } else {
  //     chatMessages[chatId] = RxList<Message>([message]);
  //   }
  // }
}
