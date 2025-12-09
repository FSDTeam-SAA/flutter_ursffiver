import 'package:flutter/material.dart';
import 'package:flutter_ursffiver/core/common/model/coordinates.dart';

enum LocationRange {
  bluetooth("Bluetooth"),
  nearby("Nearby"),
  uptoOneMile("Upto 1 Mile"),
  uptoFiveMile("Upto 5 Mile");
  
  final String name;
  const LocationRange(this.name);

  IconData get icon {
    switch(this) {
      case LocationRange.bluetooth:
        return Icons.bluetooth;
      case LocationRange.nearby:
        return Icons.near_me;
      case LocationRange.uptoOneMile:
        return Icons.location_on;
      case LocationRange.uptoFiveMile:
        return Icons.location_on;
    }
  }
}

class GetUserSuggestionReqParam {
  /// List of user's interest ids
  List<String> interests;
  Coordinates? location;
  LocationRange? locationRange;

  GetUserSuggestionReqParam({
    required this.interests,
    required this.location,
    required this.locationRange,
  });

  Map<String, dynamic> toMap() {
    String interestString = interests.join(',');
    return {
      if(interests.isNotEmpty) 'interest': interestString,
      if(location != null) 'location': location?.toJson(),
      if(locationRange != null && location != null)'locationRange': locationRange!.name,
    };
  }

  @override
  String toString() {
    return 'GetUserSuggestionReqParam(interests: $interests, location: $location, locationRange: $locationRange)';
  }
}