import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/widget/cache/smart_network_image.dart';
import 'package:flutter_ursffiver/features/badges/presentation/screen/award_badge_view.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controller.dart';
import 'package:flutter_ursffiver/features/inbox/model/message_model.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/widget/chat_time_widget.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/widget/time_extend-dialog_widget.dart';
import 'package:flutter_ursffiver/features/profile/controller/profile_data_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';
import '../../controller/messaging_controller.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final String avatarUrl;
  final String userId;
  final String chatId;
  final ChatController chatController;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.avatarUrl,
    required this.userId,
    required this.chatId,
    required this.chatController,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final MessagingController messagingController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    messagingController = MessagingController(
      chatId: widget.chatController.chatId,
    );

    // Scroll to bottom after a short delay to ensure messages are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  void sendMessage() {
    messagingController.sendMessage();
    // Auto scroll to bottom after sending message
    Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SmartNetworkImage.circle(
              imageUrl: widget.avatarUrl,
              diameter: 32,
              errorWidget: Icon(Icons.image, size: 32),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.contactName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                ChatTimeLeftRow(
                  chatStartTime: widget.chatController.chatModel?.time,
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == "badge") {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: AwardBadgeView(toUserId: widget.userId),
                  ),
                );
              } else if (value == "extend") {
                showExtendTimeDialog(
                  context: context,
                  chatId: widget.chatController.chatId,
                );
              } else if (value == "location") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(title: const Text("Share Location")),
                      body: const Center(
                        child: Text("Location sharing UI goes here"),
                      ),
                    ),
                    fullscreenDialog: true,
                  ),
                );
              }
            },

            itemBuilder: (_) => [
              const PopupMenuItem(
                value: "extend",
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined, color: Colors.black),
                    SizedBox(width: 10),
                    Text("Extend Time"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "badge",
                child: Row(
                  children: [
                    Icon(Icons.badge, color: Colors.black),
                    SizedBox(width: 10),
                    Text("Award Badge User"),
                  ],
                ),
              ),
              // const PopupMenuItem(
              //   value: "location",
              //   child: Row(
              //     children: [
              //       Icon(Icons.location_on_outlined, color: Colors.black),
              //       SizedBox(width: 10),
              //       Text("Share Location"),
              //     ],
              //   ),
              // ),
            ],
          ),

          const SizedBox(width: 8),
        ],
      ),
      body: ObxValue((messages) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  bool isMe = msg.isMe(
                    Get.find<ProfileDataProvider>().userProfile.value?.id ??
                        "",
                  );
                  return Column(
                    children: [
                      isMe
                          ? _buildSentMessage(context, msg)
                          : _buildReceivedMessage(context, msg),
                      Gap.h16,
                    ],
                  );
                },
              ),
            ),
            _buildMessageInput(),
            Gap.bottomAppBarGap,
          ],
        );
      }, widget.chatController.messages),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: TextField(
        controller: messagingController.textInputController,
        decoration: InputDecoration(
          hintText: 'Message...',
          hintStyle: const TextStyle(color: AppColors.secondaryText),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4C4CFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, MessageModel message) {
    final time = DateFormat.Hm().format(message.date);
    final date = DateFormat.yMd().format(message.date);
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF4C4CFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.text ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Text(
            "$time   $date",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, MessageModel message) {
    final time = DateFormat.Hm().format(message.date);
    final date = DateFormat.yMd().format(message.date);
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.text ?? "",
                style: AppText.mdRegular_16_400.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),
          ),
          Text(
            "$time   $date",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
