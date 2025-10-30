import 'package:flutter_ursffiver/core/common/model/interest_model.dart';

import '../../../core/common/enum/interest_color.dart';

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
