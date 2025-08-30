import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_style.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  final List<MessageItem> messages = const [
    MessageItem(
      name: 'Leslie Alexander',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Bessie Cooper',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Kristin Watson',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Jane Cooper',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Annette Black',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Ralph Edwards',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Courtney Henry',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
    ),
    MessageItem(
      name: 'Cody Fisher',
      message: 'Respected Sir, I Peter, your com...',
      time: '4 Mar',
      avatarUrl:
          'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?w=150&h=150&fit=crop&crop=face',
    ),
  ];

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
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageTile(message: message);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final MessageItem message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              contactName: message.name,
              avatarUrl: message.avatarUrl,
            ),
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
              backgroundImage: NetworkImage(message.avatarUrl),
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
                        message.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        message.time,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.message,
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

class MessageItem {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  const MessageItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
  });
}

