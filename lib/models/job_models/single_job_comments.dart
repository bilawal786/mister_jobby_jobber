// To parse this JSON data, do
//
//     final singleJobCommentsModel = singleJobCommentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

List<SingleJobCommentsModel> singleJobCommentsModelFromJson(String str) => List<SingleJobCommentsModel>.from(json.decode(str).map((x) => SingleJobCommentsModel.fromJson(x)));

String singleJobCommentsModelToJson(List<SingleJobCommentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleJobCommentsModel with ChangeNotifier{
  SingleJobCommentsModel({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.name,
    required this.image,
    required this.message,
    required this.date,
  });

  int id;
  int jobId;
  int userId;
  String name;
  String image;
  String message;
  String date;

  factory SingleJobCommentsModel.fromJson(Map<String, dynamic> json) => SingleJobCommentsModel(
    id: json["id"],
    jobId: json["job_id"],
    userId: json["user_id"],
    name: json["name"],
    image: json["image"],
    message: json["message"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "job_id": jobId,
    "user_id": userId,
    "name": name,
    "image": image,
    "message": message,
    "date": date,
  };
}
