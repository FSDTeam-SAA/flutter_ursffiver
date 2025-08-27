// import 'chapter.dart';

// class AudioBook {
//   final String id;
//   final String title;
//   final String subject;
//   final String language;
//   final String filePath;
//   final String coverImage;
//   final int listeners;
//   final int duration;
//   final String description;
//   final List<String> tags;
//   final String author;
//   final String about;
//   final String category;
//   final List<Chapter> chapters;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   AudioBook({
//     required this.id,
//     required this.title,
//     required this.subject,
//     required this.language,
//     required this.filePath,
//     required this.coverImage,
//     required this.listeners,
//     required this.duration,
//     required this.description,
//     required this.tags,
//     required this.author,
//     required this.about,
//     required this.category,
//     required this.chapters,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   // Get chapter by ID
//   Chapter? getChapterById(String chapterId) {
//     try {
//       return chapters.firstWhere((chapter) => chapter.uniqueId == chapterId);
//     } catch (e) {
//       return null;
//     }
//   }

//   // Get chapter by position in audio
//   Chapter? getChapterByPosition(Duration position) {
//     try {
//       return chapters.firstWhere((chapter) => chapter.containsPosition(position));
//     } catch (e) {
//       return null;
//     }
//   }

//   // Get next chapter
//   Chapter? getNextChapter(String currentChapterId) {
//     final currentIndex = chapters.indexWhere((chapter) => chapter.uniqueId == currentChapterId);
//     if (currentIndex != -1 && currentIndex < chapters.length - 1) {
//       return chapters[currentIndex + 1];
//     }
//     return null;
//   }

//   // Get previous chapter
//   Chapter? getPreviousChapter(String currentChapterId) {
//     final currentIndex = chapters.indexWhere((chapter) => chapter.uniqueId == currentChapterId);
//     if (currentIndex > 0) {
//       return chapters[currentIndex - 1];
//     }
//     return null;
//   }

//   // Get total duration as Duration object
//   Duration get totalDuration => Duration(seconds: duration);

//   @override
//   String toString() {
//     return 'AudioBook{id: $id, title: $title, subject: $subject, language: $language, filePath: $filePath, coverImage: $coverImage, listeners: $listeners, duration: $duration, description: $description, tags: $tags, author: $author, about: $about, category: $category, chapters: $chapters, createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
  
// }
