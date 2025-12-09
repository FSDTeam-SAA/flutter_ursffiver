import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/notifiers/button_status_notifier.dart';

import '../../../../core/common/widget/reactive_button/r_icon.dart';

Future<void> showExtendTimeDialog({
  required Function(int extendenMinutes, ProcessStatusNotifier notifier)
  onConfirm,
  required BuildContext context,
  String title = "Extend Time",
  String hintText = "Enter time in minutes",
  required String chatId,
}) async {
  final TextEditingController timeExtendTextCntlr = TextEditingController();
  final ProcessStatusNotifier notifier = ProcessStatusNotifier(
    initialStatus: EnabledStatus(),
  );
  int timeExtend = 0;
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: timeExtendTextCntlr,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (int.tryParse(value) == null) {
                timeExtendTextCntlr.text = timeExtend.toString();
              }
              timeExtend = int.parse(timeExtendTextCntlr.text);
            },
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => onConfirm(timeExtend, notifier),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Confirm"),
                  const SizedBox(width: 4),
                  RIcon(
                    key: UniqueKey(),
                    height: 20,
                    width: 20,
                    iconWidget: Container(),
                    loadingStateWidget: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                    processStatusNotifier: notifier,
                    onDone: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      );
    },
  );
}
