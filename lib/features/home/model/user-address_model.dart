class UserAddressModel {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  UserAddressModel({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) {
    return UserAddressModel(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
    };
  }
}
