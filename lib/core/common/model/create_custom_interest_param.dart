
import '../../../features/auth/model/interest_model.dart';

class CreateCustomInterestParam {
  final String name;
  final InterestColor color;

  CreateCustomInterestParam({
    required this.name,
    required this.color,
  });

  factory CreateCustomInterestParam.fromJson(Map<String, dynamic> json) {
    return CreateCustomInterestParam(
      name: json['name'],
      color: InterestColor.fromString(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color.name,
    };
  }

  CreateCustomInterestParam copyWith({
    String? name,
    InterestColor? color,
  }) {
    return CreateCustomInterestParam(
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }
}