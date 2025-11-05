import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:flutter_ursffiver/features/inbox/model/chat_data.dart';
import 'package:flutter_ursffiver/features/inbox/model/create_chat_request_model.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/socket_service/socket_service.dart'
    show SocketService;
import 'package:get/get.dart';

class ChatController extends GetxController {
  ChatController._internal();
  static ChatController instance = ChatController._internal();
  factory ChatController() => instance;

  final ChatInterface chatInterface = Get.find<ChatInterface>();
  final RxMap<String, RxList<Message>> chatMessages = RxMap<String, RxList<Message>>();
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
      result.fold(
            (failure) => debugPrint("❌ GetAllChat Error: $failure"),
            (success) {
          if (success.data != null) {
            debugPrint("GetAllChat Success: ${success.data!.length}");
            chatList.value = success.data!;
            for (final chat in chatList.value) {
              chatMessages[chat.id] = RxList<Message>(chat.messages);
            }
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  //-----------------------------invite chat---------------------
  Future<ChatData?> inviteChat({
    required String userId,
  }) async {
    final result = await chatInterface.inviteChat(
      param: CreateChatRequestModel(userId: userId),
    );
    return result.fold(
          (failure) {
        debugPrint("❌ CreateChat Error: $failure");
        return null;
      },
          (success) => success.data?.data,
    );
  }

  // //-------------------------Invite chat-----------------
  // Future<void> inviteChat({required String userId}) async {
  //   isLoading.value = true;
  //   try {
  //     final result = await chatInterface.inviteChat(
  //     );

  //     result.fold(
  //       (failure) {
  //         debugPrint("❌ InviteChat Error: $failure");
  //         Get.snackbar("Error", "Failed to invite to chat");
  //       },
  //       (success) {
  //         if (success.data != null) {
  //           final ChatData newChat = ChatData.fromJson(success.data!);

  //           final exists = chatList.value.any((chat) => chat.id == newChat.id);
  //           if (!exists) {
  //             chatList.value = [...chatList.value, newChat];
  //             chatMessages[newChat.id] = RxList<Message>(newChat.messages);
  //           }
  //           Get.snackbar("Success", "Chat invited successfully");
  //         }
  //       },
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
