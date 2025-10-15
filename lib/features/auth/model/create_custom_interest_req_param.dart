import 'package:flutter_ursffiver/features/auth/model/interest_model.dart';

class CreateCustomInterestReqParam {
  final String name;
  final InterestColor color;

  CreateCustomInterestReqParam({required this.name, required this.color});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color.name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreateCustomInterestReqParam &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          color == other.color;

  @override
  int get hashCode => name.hashCode ^ color.hashCode;
}
