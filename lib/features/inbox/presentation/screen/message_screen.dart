import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controller.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../model/chat_data.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final ChatController chatController = ChatController();

  @override
  void initState() {
    super.initState();
    chatController.initSocket();
    getAllChat();
  }

  Future<void> getAllChat() async {
    chatController.getAllChat();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'Messages',
                style: AppText.xxlSemiBold_24_600.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),

            // Messages List
            Expanded(
              child: Obx(
                () => chatController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : chatController.chatList.value.isNotEmpty
                    ? ListView.builder(
                        itemCount: chatController.chatList.value.length,
                        itemBuilder: (context, index) {
                          final message = chatController.chatList.value[index];
                          return MessageTile(message: message);
                        },
                      )
                    : const Center(
                        child: Text(
                          'No messages yet.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final ChatData message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatScreen(contactName: message.name!, avatarUrl: ''),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(''),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 12),

            // Message content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        message.time!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.messages[0].text!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}