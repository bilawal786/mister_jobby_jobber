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
  });

  String activity;
  String message;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    activity: json["activity"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "activity": activity,
    "message": message,
  };
}
