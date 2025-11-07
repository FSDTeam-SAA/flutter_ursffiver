
class AcceptRejectChatReqParam {
  final String chatId;
  final String status; // "accepted" or "rejected"

  AcceptRejectChatReqParam({
    required this.chatId,
    required this.status,
  });

  AcceptRejectChatReqParam.accept({required String chatId}) : this(chatId: chatId, status: "accept"); 
  AcceptRejectChatReqParam.reject({required String chatId}) : this(chatId: chatId, status: "reject");


  Map<String, dynamic> toJson() {
    return {
      "chatId": chatId,
      "status": status,
    };
  } 
}
