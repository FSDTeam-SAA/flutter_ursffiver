import 'dart:async';
import 'package:flutter/material.dart';

class ChatTimeLeftRow extends StatefulWidget {
  final DateTime? chatStartTime;
  final DateTime chatEndsAt; // Total duration of chat in minutes

  const ChatTimeLeftRow({
    super.key,
    required this.chatStartTime,
    required this.chatEndsAt,
  });

  @override
  _ChatTimeLeftRowState createState() => _ChatTimeLeftRowState();
}

class _ChatTimeLeftRowState extends State<ChatTimeLeftRow> {
  late Timer timer;
  int minutesLeft = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _updateTimeLeft();
  }

  @override
  void initState() {
    super.initState();
    _updateTimeLeft();
    timer = Timer.periodic(const Duration(seconds: 10), (_) => setState(() {}));
  }

  void _updateTimeLeft() {
    if (widget.chatStartTime == null) return;

    final chatEndTime = widget.chatEndsAt;
    debugPrint("Current time: ${DateTime.now()}, Chat ends at: $chatEndTime");
    final duration = chatEndTime.difference(DateTime.now()).inMinutes;
    minutesLeft = duration.isNegative ? 0 : duration;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _formatMinutes(int minutes) {
    debugPrint("Minutes: $minutes");  
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
    _updateTimeLeft();
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
