class SendMessageRequestModel {
  final String chatId;
  final String message;

  SendMessageRequestModel({
    required this.chatId,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "chatId": chatId,
      "message": message,
    };
  }
}
