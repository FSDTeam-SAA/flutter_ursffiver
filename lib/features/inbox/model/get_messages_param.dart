class GetMessagesReqParam {
  final String chatId;
  final int? page;
  final int limit;
  final String? beforeMessageId;

  GetMessagesReqParam({
    required this.chatId,
    this.page,
    required this.limit,
    this.beforeMessageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
      'beforeMessageId': beforeMessageId,
    };
  }
}
