import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/cache/smart_network_image.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controller.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';

class AllChatScreeen extends StatefulWidget {
  const AllChatScreeen({super.key});

  @override
  State<AllChatScreeen> createState() => _AllChatScreeenState();
}

class _AllChatScreeenState extends State<AllChatScreeen> {
  final InboxChatDataProvider chatController =
      Get.find<InboxChatDataProvider>();

  @override
  void initState() {
    super.initState();
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
              child: GetBuilder<InboxChatDataProvider>(
                builder: (controller) => chatController.chats.isNotEmpty
                    ? ListView.builder(
                        itemCount: chatController.chats.length,
                        itemBuilder: (context, index) {
                          final message = chatController.chats[index];
                          return MessageTile(chatController: message);
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
  final ChatController chatController;

  const MessageTile({super.key, required this.chatController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              contactName: chatController.chatTitle,
              avatarUrl: chatController.chatModel?.avatarUrl ?? '',
              chatController: chatController,
              userId: chatController.chatModel?.id ?? '',
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            (chatController.chatModel?.avatarUrl != null &&
                    chatController.chatModel!.avatarUrl!.isNotEmpty)
                ? ClipOval(
                    child: SmartNetworkImage(
                      imageUrl: chatController.chatModel?.avatarUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  )
                : CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      chatController.chatTitle.isNotEmpty
                          ? chatController.chatTitle[0].toUpperCase()
                          : "?",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chatController.chatModel?.name ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        chatController.lastMessageTime,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chatController.lastMessage,
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
