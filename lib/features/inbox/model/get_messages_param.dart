class GetMessagesParam {
  final String chatId;
  final int limit;
  final String? beforeMessageId;

  GetMessagesParam({
    required this.chatId,
    required this.limit,
    this.beforeMessageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatId': chatId,
      'limit': limit,
      'beforeMessageId': beforeMessageId,
    };
  }

}