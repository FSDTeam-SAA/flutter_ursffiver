
class TimeExtendReqParam {
  final int time;
  final String chatId;

  TimeExtendReqParam({required this.time, required this.chatId});


  Map<String, dynamic> toJson() {
    return {"time": time, "chatId": chatId};
  }
}
