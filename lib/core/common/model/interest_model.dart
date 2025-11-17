
import '../enum/interest_color.dart';

class InterestModel {
  final String id;
  final String name;
  final InterestColor color;

  InterestModel({required this.id, required this.name, required this.color});

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['_id'],
      name: json['name'],
      color: InterestColor.fromString(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'color': color.name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InterestModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          color == other.color;

  @override
  int get hashCode => Object.hashAll([id, name, color]);
}



class InterestCategoryModel {
  final String id;
  final String name;
  final List<InterestModel> interests;

  InterestCategoryModel({
    required this.id,
    required this.name,
    required this.interests,
  });

  factory InterestCategoryModel.fromJson(Map<String, dynamic> json) {
    return InterestCategoryModel(
      id: json['_id'],
      name: json['name'],
      interests: json['interests'] == null ? [] : List<InterestModel>.from(
        (json['interests'] as List<dynamic>).map((x) => InterestModel.fromJson(x)),
      ),
    );
  }

  InterestCategoryModel copyWith({
    String? id,
    String? name,
    List<InterestModel>? interests,
  }) {
    return InterestCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      interests: interests ?? this.interests,
    );
  }
}
