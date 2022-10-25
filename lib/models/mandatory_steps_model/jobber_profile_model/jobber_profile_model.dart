// To parse this JSON data, do
//
//     final jobberProfileModel = jobberProfileModelFromJson(jsonString);

import 'dart:convert';

JobberProfileModel jobberProfileModelFromJson(String str) => JobberProfileModel.fromJson(json.decode(str));

String jobberProfileModelToJson(JobberProfileModel data) => json.encode(data.toJson());

class JobberProfileModel {
  JobberProfileModel({
    required this.jobberId,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.address,
    required this.country,
    required this.image,
    required this.gender,
    required this.description,
    required this.hours,
    required this.totalHours,
    required this.memberSince,
    required this.experince,
    required this.totalJobs,
    required this.completedJobs,
    required this.cancelJobs,
    required this.skilsSubcategory,
    required this.skilsChildcategory,
    required this.badge,
    this.qualification,
    required this.professional,
    required this.availableStatus,
    required this.pro,
    required this.verified,
    required this.equipements,
    required this.engagments,
    required this.personalDescription,
    required this.totalReview,
    required this.rating,
    required this.reviews,
    required this.latitude,
    required this.longitude,
    required this.radius,
  });

  int jobberId;
  String firstName;
  String lastName;
  String phone;
  String email;
  String address;
  String country;
  String image;
  int gender;
  String description;
  String hours;
  String totalHours;
  DateTime memberSince;
  String experince;
  int totalJobs;
  int completedJobs;
  int cancelJobs;
  List<SkilsCategory> skilsSubcategory;
  List<SkilsCategory> skilsChildcategory;
  int badge;
  dynamic qualification;
  String professional;
  bool availableStatus;
  bool pro;
  bool verified;
  String equipements;
  String engagments;
  String personalDescription;
  int totalReview;
  int rating;
  List<dynamic> reviews;
  String latitude;
  String longitude;
  String radius;

  factory JobberProfileModel.fromJson(Map<String, dynamic> json) => JobberProfileModel(
    jobberId: json["jobber_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    address: json["address"],
    country: json["country"],
    image: json["image"],
    gender: json["gender"],
    description: json["description"],
    hours: json["hours"],
    totalHours: json["total_hours"],
    memberSince: DateTime.parse(json["member_since"]),
    experince: json["experince"],
    totalJobs: json["total_jobs"],
    completedJobs: json["completed_jobs"],
    cancelJobs: json["cancel_jobs"],
    skilsSubcategory: List<SkilsCategory>.from(json["skilsSubcategory"].map((x) => SkilsCategory.fromJson(x))),
    skilsChildcategory: List<SkilsCategory>.from(json["skilsChildcategory"].map((x) => SkilsCategory.fromJson(x))),
    badge: json["badge"],
    qualification: json["qualification"],
    professional: json["professional"],
    availableStatus: json["available_status"],
    pro: json["pro"],
    verified: json["verified"],
    equipements: json["equipements"],
    engagments: json["engagments"],
    personalDescription: json["personal_description"],
    totalReview: json["total_review"],
    rating: json["rating"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    radius: json["radius"],
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "jobber_id": jobberId,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "address": address,
    "country": country,
    "image": image,
    "gender": gender,
    "description": description,
    "hours": hours,
    "total_hours": totalHours,
    "member_since": memberSince.toIso8601String(),
    "experince": experince,
    "total_jobs": totalJobs,
    "completed_jobs": completedJobs,
    "cancel_jobs": cancelJobs,
    "skilsSubcategory": List<dynamic>.from(skilsSubcategory.map((x) => x.toJson())),
    "skilsChildcategory": List<dynamic>.from(skilsChildcategory.map((x) => x.toJson())),
    "badge": badge,
    "qualification": qualification,
    "professional": professional,
    "available_status": availableStatus,
    "pro": pro,
    "verified": verified,
    "equipements": equipements,
    "engagments": engagments,
    "personal_description": personalDescription,
    "total_review": totalReview,
    "rating": rating,
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
  };
}

class SkilsCategory {
  SkilsCategory({
    required this.id,
    required this.title,
    required this.image,
  });

  int id;
  String title;
  String image;

  factory SkilsCategory.fromJson(Map<String, dynamic> json) => SkilsCategory(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}
