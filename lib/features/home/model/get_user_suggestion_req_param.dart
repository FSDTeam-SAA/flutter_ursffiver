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

  double get rangeInMiles {
    switch(this) {
      case LocationRange.bluetooth:
        return 0.05;
      case LocationRange.nearby:
        return 0.5;
      case LocationRange.uptoOneMile:
        return 1.0;
      case LocationRange.uptoFiveMile:
        return 5.0;
    }
  }
}

class GetUserSuggestionReqParam {
  /// List of user's interest ids
  List<String> interests;
  Coordinates? location;
  LocationRange? locationRange;
  final int page;
  final int limit;

  GetUserSuggestionReqParam({
    required this.interests,
    required this.location,
    required this.locationRange,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    String interestString = interests.join(',');
    return {
      if(interests.isNotEmpty) 'interest': interestString,
      if(location != null) 'lat': location?.latitude,
      if(location != null) 'lng': location?.longitude,
      if(locationRange != null && location != null)'radius': locationRange!.rangeInMiles,
      if(locationRange != null && location != null)'unit': "mile",
      'page': page,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return 'GetUserSuggestionReqParam(interests: $interests, location: $location, locationRange: $locationRange, page: $page, limit: $limit)';
  }
}