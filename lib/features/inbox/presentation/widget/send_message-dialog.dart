import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/theme/text_style.dart';
import 'package:flutter_ursffiver/features/home/model/user_model.dart';
import 'package:flutter_ursffiver/features/inbox/controller/chat_controllerx.dart';
import 'package:flutter_ursffiver/features/inbox/controller/inbox_chat_data_provider.dart';
import 'package:flutter_ursffiver/features/inbox/presentation/screen/inbox_screen.dart';
import 'package:get/get.dart';

class SendChatRequestDialog extends StatefulWidget {
  final UserModel user;
  const SendChatRequestDialog({super.key, required this.user});

  @override
  State<SendChatRequestDialog> createState() => _SendChatRequestDialogState();
}

class _SendChatRequestDialogState extends State<SendChatRequestDialog> {
  final InboxChatDataProvider inboxchatdatacontroller = Get.find<InboxChatDataProvider>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Send Chat Notification?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Would you like to send a chat request to this user? They’ll be notified instantly.",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: AppText.mdMedium_16_500.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFf3F42EE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      inboxchatdatacontroller.inviteChat(userId: widget.user.id);
                      Navigator.pop(
                        context,
                        // MaterialPageRoute(
                        //   builder: (context) =>
                        //       ChatScreen(contactName: '', avatarUrl: '', chatController: ,),
                        // ),
                      );
                    },
                    child: Text(
                      "Send Request",
                      style: AppText.mdMedium_16_500.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //   color: Colors.blue.shade600,
                //   onPressed: () {
                //     chatController.inviteChat(
                //       userId: widget.user.id,
                //     );
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ChatScreen(contactName: '', avatarUrl: '',),
                //       ),
                //     );
                //   },
                //   icon: Icon(Icons.message, size: 28),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
