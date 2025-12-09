import 'package:flutter_ursffiver/features/inbox/model/send_message_request_param.dart';

class TimeExtendReqParam {
  final int time;
  final String chatId;

  TimeExtendReqParam({required this.time, required this.chatId});


  Map<String, dynamic> toJson() {
    return {"time": time, "chatId": chatId};
  }
}
