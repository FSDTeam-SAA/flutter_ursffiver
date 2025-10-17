import 'package:flutter_ursffiver/core/common/model/coordinates.dart';

enum LocationRange {
  bluetooth("Bluetooth"),
  nearby("Nearby"),
  uptoOneMile("Upto 1 Mile"),
  uptoFiveMile("Upto 5 Mile");
  
  final String name;
  const LocationRange(this.name);
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