import 'dart:io';
import 'package:dio/dio.dart';

class Attachment {
  final File file;

  Attachment({required this.file});

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'attachment': await MultipartFile.fromFile(file.path),
    });
  }
}
