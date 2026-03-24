class ProfileModel {
  ProfileModel({
    required this.name,
    required this.email,
    required this.phone,
    this.addressLine1,
    this.addressLine2,
    this.state,
    this.suburb,
    this.postCode,
    this.country,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        addressLine1: json["address_line_1"]?.toString(),
        addressLine2: json["address_line_2"]?.toString(),
        state: json["state"]?.toString(),
        suburb: json["suburb"]?.toString(),
        postCode: json["post_code"]?.toString(),
        country: json["country"]?.toString(),
      );

  late String name, phone, email;
  String? addressLine1, addressLine2, state, suburb, postCode, country;
}
