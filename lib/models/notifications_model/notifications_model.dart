// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.activity,
    required this.message,
    required this.createdAt,
    required this.status,
  });

  String activity;
  String message;
  String createdAt;
  String status;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    activity: json["activity"],
    message: json["message"],
    createdAt: json["created_at"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "activity": activity,
    "message": message,
    "created_at": createdAt,
    "status": status,
  };
}
