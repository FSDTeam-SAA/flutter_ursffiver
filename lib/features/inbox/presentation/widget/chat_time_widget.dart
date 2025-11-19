import 'dart:async';
import 'package:flutter/material.dart';

class ChatTimeLeftRow extends StatefulWidget {
  final DateTime? chatStartTime;
  final int chatDurationMinutes; // Total duration of chat in minutes

  const ChatTimeLeftRow({
    Key? key,
    required this.chatStartTime,
    this.chatDurationMinutes = 35,
  }) : super(key: key);

  @override
  _ChatTimeLeftRowState createState() => _ChatTimeLeftRowState();
}

class _ChatTimeLeftRowState extends State<ChatTimeLeftRow> {
  late Timer timer;
  int minutesLeft = 0;

  @override
  void initState() {
    super.initState();
    _updateTimeLeft();
    timer = Timer.periodic(const Duration(seconds: 10), (_) => _updateTimeLeft());
  }

  void _updateTimeLeft() {
    if (widget.chatStartTime == null) return;

    final chatEndTime =
        widget.chatStartTime!.add(Duration(minutes: widget.chatDurationMinutes));
    final duration = chatEndTime.difference(DateTime.now());

    setState(() {
      minutesLeft = duration.isNegative ? 0 : duration.inMinutes;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _formatMinutes(int minutes) {
    if (minutes >= 60) {
      final h = minutes ~/ 60;
      final m = minutes % 60;
      return m == 0 ? '${h}h' : '${h}h ${m}m';
    } else {
      return '$minutes minutes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Time left to chat: ",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          _formatMinutes(minutesLeft),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
