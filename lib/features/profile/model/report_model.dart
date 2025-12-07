import 'package:dio/dio.dart';

class ReportModel {
  final String title;
  final String message;
  final String? url; // file path or null

  ReportModel({
    required this.title,
    required this.message,
    this.url,
  });

  Future<FormData> toFormData() async {
    final formData = FormData.fromMap({
      'name': title,
      'message': message,
      if (url != null && url!.isNotEmpty)
        'attachment': await MultipartFile.fromFile(url!),
    });
    return formData;
  }
}
