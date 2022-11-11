// To parse this JSON data, do
//
//     final commentedJobsModel = commentedJobsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CommentedJobsModel> commentedJobsModelFromJson(String str) => List<CommentedJobsModel>.from(json.decode(str).map((x) => CommentedJobsModel.fromJson(x)));

String commentedJobsModelToJson(List<CommentedJobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentedJobsModel {
  CommentedJobsModel({
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

  factory CommentedJobsModel.fromJson(Map<String, dynamic> json) => CommentedJobsModel(
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
