import 'package:flutter_ursffiver/features/inbox/socket_service/socket_service.dart'
    show SocketService;
import 'package:get/get.dart';

class ChatController extends GetxController {
  ChatController._internal();
  static ChatController instance = ChatController._internal();
  factory ChatController() => instance;

  // final ChatInterface chatInterface = Get.find<ChatInterface>();
  //final RxMap<String, RxList<Message>> chatMessages = RxMap<String, RxList<Message>>();
  //final Rx<List<ChatData>> chatList = Rx<List<ChatData>>([]);
  //final RxList<ChatData> sellerChats = <ChatData>[].obs;
  final RxBool isLoading = false.obs;

  final SocketService socketService = SocketService();

  /// Init socket for real-time chat
  void initSocket() {
    socketService.connect();

    // socketService.on("new_message", (data) {
    //   try {
    //     final message = Message.fromJson(data);
    //     final chatId = data["chatId"];
    //     if (chatMessages.containsKey(chatId)) {
    //       chatMessages[chatId]!.add(message);
    //     } else {
    //       chatMessages[chatId] = RxList<Message>([message]);
    //     }
    //     update();
    //   } catch (e) {
    //     debugPrint("❌ Error parsing incoming message: $e");
    //   }
    // });
  }
}
