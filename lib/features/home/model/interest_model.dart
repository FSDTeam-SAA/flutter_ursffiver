class InterestModel {
  final String id;
  final String name;
  final String interestCategory;
  final String color;
  final String createdAt;
  final String updatedAt;

  InterestModel({
    required this.id,
    required this.name,
    required this.interestCategory,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['_id'],
      name: json['name'],
      interestCategory: json['interestCategory'],
      color: json['color'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}