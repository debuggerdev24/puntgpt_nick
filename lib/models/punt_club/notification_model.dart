class NotificationModel {
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        message: json["message"],
        createdAt: json["created_at"],
      );

  NotificationModel({
    required this.id,
    required this.message,
    required this.createdAt,
  });
  int id;
  String message, createdAt;
}
