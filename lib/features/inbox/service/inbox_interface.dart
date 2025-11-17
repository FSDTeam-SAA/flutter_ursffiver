import 'package:flutter_ursffiver/features/inbox/model/get_messages_param.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';

import '../../../core/api_handler/base_repository.dart';
import '../../../core/api_handler/success.dart';
import '../../../core/helpers/typedefs.dart';
import '../model/chat_model.dart';
import '../model/send_message_param.dart';

 abstract base class InboxInterface extends BaseRepository {
  // Define chat-related abstract methods here
  FutureRequest<Success<List<ChatModel>>> getChats();

  FutureRequest<Success<ChatModel>> getChat(String chatId);

  FutureRequest<Success<List<MessageModel>>> getMessages(GetMessagesParam param);

  FutureRequest<Success<MessageModel>> sendMessage(SendMessageParam param);

  FutureRequest<Success<void>> markMessageAsRead(String messageId);

  Stream<MessageModel> messageStream();

  Stream<ChatModel> chatStream();
}