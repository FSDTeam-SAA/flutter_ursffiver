import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/map_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';
import '../../../badges/presentation/screen/badges_screen.dart';

class ChatScreen extends StatelessWidget {
  final String contactName;
  final String avatarUrl;

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(avatarUrl), radius: 18),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Time left to chat 14:45",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
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
              if (value == "extend") {
                // TODO: handle extend
              } else if (value == "badge") {
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
                    child: const AllBadgesWidget(),
                  ),
                );
              } else if (value == "location") {
              }
            },

            itemBuilder: (BuildContext context) => [
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
              const PopupMenuItem(
                value: "location",
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined, color: Colors.black),
                    SizedBox(width: 10),
                    Text("Share Location"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _buildSentMessage(context, "Hi", "11:25:44 pm", "03/08/2025"),
                Gap.h16,
                _buildReceivedMessage(
                  context,
                  "Hello",
                  "11:25:44 pm",
                  "03/08/2025",
                ),
                Gap.h16,
                _buildSentMessage(
                  context,
                  "Meaow Meaow Meaow Meaow Meaow Meaow Meaow Meaow",
                  "11:25:44 pm",
                  "03/08/2025",
                ),
              ],
            ),
          ),
          _buildMessageInput(),
          Gap.bottomAppBarGap,
        ],
      ),
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
              color: Color(0xFF4C4CFF),
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // TODO: send message action
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSentMessage(
    BuildContext context,
    String text,
    String time,
    String date,
  ) {
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
                text,
                style: const TextStyle(color: Colors.white),
                softWrap: true,
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

  Widget _buildReceivedMessage(
    BuildContext context,
    String text,
    String time,
    String date,
  ) {
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
                text,
                style: AppText.mdRegular_16_400.copyWith(
                  color: AppColors.primaryTextblack,
                ),
                softWrap: true,
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
