import '../../../core/common/model/interest_model.dart';

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

  InterestModel toInterestModel() {
    return InterestModel(
      id:"${DateTime.now().millisecondsSinceEpoch}", // Custom interests can have a temporary negative ID
      name: name,
      color: color,
    );
  }

  factory CreateCustomInterestReqParam.fromInterest(InterestModel interest) {
    return CreateCustomInterestReqParam(
      name: interest.name,
      color: interest.color,
    );
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
