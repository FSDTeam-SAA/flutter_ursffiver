import 'package:flutter_ursffiver/core/common/model/coordinates.dart';

class SetVisibilityReq {
  final bool active;
  final Coordinates? location;

  SetVisibilityReq({required this.active, this.location});

  Map<String, dynamic> toJson() => {
    'active': active,
    'locationActive': location?.toJson(),
  };
}
