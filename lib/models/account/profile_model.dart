class ProfileModel {
  ProfileModel({required this.name, required this.email, required this.phone});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
  );

  late String name, phone, email;
}
