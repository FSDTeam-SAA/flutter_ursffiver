// class Chapter {
//   final String title;
//   final String start;
//   final String end;

//   Chapter({
//     required this.title,
//     required this.start,
//     required this.end,
//   });

//   int get startInSeconds {
//     final parts = start.split(':');
//     return int.parse(parts[0]) * 60 + int.parse(parts[1]);
//   }

//   int get endInSeconds {
//     final parts = end.split(':');
//     return int.parse(parts[0]) * 60 + int.parse(parts[1]);
//   }

//   // Additional computed properties for convenience
//   Duration get startTime => Duration(seconds: startInSeconds);
//   Duration get endTime => Duration(seconds: endInSeconds);
//   Duration get duration => Duration(seconds: endInSeconds - startInSeconds);

//   // Check if a position falls within this chapter
//   bool containsPosition(Duration position) {
//     final positionSeconds = position.inSeconds;
//     return positionSeconds >= startInSeconds && positionSeconds < endInSeconds;
//   }

//   // Format time for display
//   String formatTime(String timeString) {
//     final parts = timeString.split(':');
//     if (parts.length == 2) {
//       return timeString; // Already in MM:SS format
//     }
//     return timeString;
//   }

//   // Get formatted duration string
//   String get formattedDuration {
//     final dur = duration;
//     final minutes = dur.inMinutes;
//     final seconds = dur.inSeconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   // Generate a unique identifier based on content (since no ID from backend)
//   String get uniqueId => '${title}_${start}_${end}'.replaceAll(' ', '_').toLowerCase();

//   @override
//   String toString() {
//     return 'Chapter(title: $title, start: $start, end: $end, duration: $formattedDuration)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     return other is Chapter && 
//            other.title == title && 
//            other.start == start && 
//            other.end == end;
//   }

//   @override
//   int get hashCode => title.hashCode ^ start.hashCode ^ end.hashCode;
// }
