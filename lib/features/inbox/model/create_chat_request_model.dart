class CreateChatRequestModel {
  final String userId;
  final String? time;

  CreateChatRequestModel({required this.userId, this.time});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "time": time
    };
  }
}
