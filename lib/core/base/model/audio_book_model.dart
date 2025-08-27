// import 'package:flutter_kmondesir472_fo82e52cc7/core/helpers/dekhao.dart';
// import 'package:flutter_kmondesir472_fo82e52cc7/core/base/entity/audio_book.dart';

// import '../entity/chapter.dart';
// import 'chapter_model.dart';

// class AudioBookModel extends AudioBook {
//   AudioBookModel({
//     required super.id,
//     required super.title,
//     required super.subject,
//     required super.language,
//     required super.filePath,
//     required super.coverImage,
//     required super.listeners,
//     required super.duration,
//     required super.description,
//     required super.tags,
//     required super.author,
//     required super.about,
//     required super.category,
//     required super.chapters,
//     required super.createdAt,
//     required super.updatedAt,
//   });

//   factory AudioBookModel.fromJson(Map<String, dynamic> json) {
//     try {
//       return AudioBookModel(
//       id: json['_id'] ?? '',
//       title: json['title'] ?? '',
//       subject: json['subject'] ?? '',
//       language: json['language'] ?? '',
//       filePath: json['filePath'] ?? '',
//       coverImage: json['coverImage'] ?? '',
//       listeners: json['listeners'] ?? 0,
//       duration: json['duration'] ?? 0,
//       description: json['description'] ?? '',
//       tags: List<String>.from(json['tags'] ?? []),
//       author: json['author'] ?? '',
//       about: json['about'] ?? '',
//       category: json['subject'] ?? '',
//       chapters: json['chapter'] == null ? [] : List<Chapter>.from(json['chapter']?.map((x) => ChapterModel.fromJson(x)) ?? []),
//       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//       updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
//     );
//     } catch (e) {
//       dekhao("Error in AudioBookModel.fromJson: $e");
//       throw Exception("Error in AudioBookModel.fromJson: $e");
//     }
//   }
// }

// class Meta {
//   final int total;
//   final int page;
//   final int limit;
//   final int totalPages;

//   Meta({
//     required this.total,
//     required this.page,
//     required this.limit,
//     required this.totalPages,
//   });

//   factory Meta.fromJson(Map<String, dynamic> json) {
//     return Meta(
//       total: json['total'] ?? 0,
//       page: json['page'] ?? 1,
//       limit: json['limit'] ?? 10,
//       totalPages: json['totalPages'] ?? 1,
//     );
//   }
// }
