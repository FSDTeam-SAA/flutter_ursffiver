import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/features/inbox/controller/time_extend_controller.dart';
import 'package:flutter_ursffiver/features/inbox/interface/chat_interface.dart';
import 'package:get/get.dart';

Future<void> showExtendTimeDialog({
  required BuildContext context,
  String title = "Extend Time",
  String hintText = "Enter time in minutes",
  required String chatId,
}) async {
  final TimeExtendController controller = Get.put(
  TimeExtendController(inboxInterface: Get.find<InboxInterface>()),
);
  controller.timeController.clear();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Obx(
        () => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.timeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              if (controller.isLoading.value)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      Navigator.pop(context);
                    },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                      final input = controller.timeController.text.trim();
                      if (input.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter a value")),
                        );
                        return;
                      }

                      try {
                        await controller.extendTime(
                          input: input,
                          chatId: chatId,
                        );

                        // Optionally show success message
                        if (!controller.isLoading.value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Time extended successfully"),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Error: $e")));
                      }
                    },
              child: const Text("Confirm"),
            ),
          ],
        ),
      );
    },
  );
}
