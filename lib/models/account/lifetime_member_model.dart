class LifeTimeMember {
  factory LifeTimeMember.fromJson(Map<String, dynamic> json) => LifeTimeMember(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    addressLine1: json["address_line_1"] ?? "Not provided",
    addressLine2: json["address_line_2"] ?? "Not provided",
    suburb: json["suburb"] ?? "Not provided",
    state: json["state"],
    postCode: json["post_code"] ?? "Not provided",
    country: json["country"] ?? "Not provided",
  );

  LifeTimeMember({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.suburb,
    required this.state,
    required this.postCode,
    required this.country,
  });
  String firstName,
      lastName,
      email,
      phone,
      addressLine1,
      addressLine2,
      suburb,
      state,
      postCode,
      country;
}
