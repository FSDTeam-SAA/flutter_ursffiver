import 'chat_data.dart';

class SendMessageResponseModel {
  final int? statusCode;
  final bool? success;
  final String? message;
  final ChatModel? data;

  SendMessageResponseModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return SendMessageResponseModel(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
      data: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data?.toJson(),
    };
  }
}
