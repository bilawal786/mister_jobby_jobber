// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

List<ChatListModel> chatListModelFromJson(String str) => List<ChatListModel>.from(json.decode(str).map((x) => ChatListModel.fromJson(x)));

String chatListModelToJson(List<ChatListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatListModel {
  ChatListModel({
    required this.demandeurId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.address,
    required this.country,
    required this.countryId,
    required this.image,
    required this.gender,
    required this.description,
    required this.memberSince,
    required this.totalHireJobber,
    required this.activeJobs,
    required this.totalReview,
    required this.rating,
  });

  int demandeurId;
  String firstName;
  String lastName;
  String phone;
  String email;
  String address;
  String country;
  int countryId;
  String image;
  int gender;
  String description;
  String memberSince;
  int totalHireJobber;
  int activeJobs;
  int totalReview;
  int rating;

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
    demandeurId: json["demandeur_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    country: json["country"],
    countryId: json["country_id"],
    image: json["image"],
    gender: json["gender"],
    description: json["description"],
    memberSince: json["member_since"],
    totalHireJobber: json["total_hire_jobber"],
    activeJobs: json["active_jobs"],
    totalReview: json["total_review"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "demandeur_id": demandeurId,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "address": address,
    "country": country,
    "country_id": countryId,
    "image": image,
    "gender": gender,
    "description": description,
    "member_since": memberSince,
    "total_hire_jobber": totalHireJobber,
    "active_jobs": activeJobs,
    "total_review": totalReview,
    "rating": rating,
  };
}
