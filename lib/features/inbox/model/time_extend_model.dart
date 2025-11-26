import 'package:flutter_ursffiver/features/inbox/model/send_message_request_param.dart';

class TimeExtendModel {
  final int time;
  final SendMessageReqParam? sendMessageReqParam;

  TimeExtendModel({
    required this.time,
    this.sendMessageReqParam,
  });

  Map<String, dynamic> toFormData() {
    return {
      "time": time,
      "sendMessageReqParam": sendMessageReqParam?.toJson(),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "sendMessageReqParam": sendMessageReqParam?.toJson(),
    };
  }
}
