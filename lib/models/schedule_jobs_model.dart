// To parse this JSON data, do
//
//     final scheduleJobs = scheduleJobsFromJson(jsonString);

import 'dart:convert';

Map<String, List<ScheduleJobs>> scheduleJobsFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<ScheduleJobs>>(k, List<ScheduleJobs>.from(v.map((x) => ScheduleJobs.fromJson(x)))));

String scheduleJobsToJson(Map<String, List<ScheduleJobs>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class ScheduleJobs {
  ScheduleJobs({
    required this.id,
    required this.title,
    required this.childcategoryId,
    required this.subcategoryId,
    required this.categoryId,
    required this.detailDescription,
    required this.description,
    required this.categoryTitle,
    required this.subcategoryTitle,
    required this.distance,
    required this.estimateBudget,
    required this.timeDifference,
    required this.duration,
    required this.serviceDate,
    required this.date,
    required this.views,
    required this.isApplied,
    required this.urgent,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.country,
    required this.startTime,
    required this.endTime,
    required this.jobbers,
    required this.hours,
    required this.status,
    required this.address,
    required this.phone,
    required this.image1,
    required this.image2,
    required this.image3,
    required this.small,
    required this.medium,
    required this.large,
    required this.verylarge,
    required this.question,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.surface,
    required this.count,
    required this.input,
    required this.pickupAddress,
    required this.destinationAddress,
    required this.dob,
    required this.demander,
  });

  int id;
  String title;
  int childcategoryId;
  int subcategoryId;
  int categoryId;
  String detailDescription;
  String description;
  String categoryTitle;
  String subcategoryTitle;
  String distance;
  String estimateBudget;
  int timeDifference;
  String duration;
  String serviceDate;
  DateTime date;
  int views;
  bool isApplied;
  int urgent;
  String latitude;
  String longitude;
  String createdAt;
  String country;
  String startTime;
  String endTime;
  int jobbers;
  String hours;
  int status;
  String address;
  String phone;
  String image1;
  String image2;
  String image3;
  String small;
  String medium;
  String large;
  String verylarge;
  String question;
  String question1;
  String question2;
  String question3;
  String surface;
  String count;
  String input;
  String pickupAddress;
  String destinationAddress;
  String dob;
  Demander demander;

  factory ScheduleJobs.fromJson(Map<String, dynamic> json) => ScheduleJobs(
    id: json["id"],
    title: json["title"],
    childcategoryId: json["childcategory_id"],
    subcategoryId: json["subcategory_id"],
    categoryId: json["category_id"],
    detailDescription: json["detail_description"],
    description: json["description"],
    categoryTitle: json["category_title"],
    subcategoryTitle: json["subcategory_title"],
    distance: json["distance"],
    estimateBudget: json["estimate_budget"],
    timeDifference: json["time_difference"],
    duration: json["duration"],
    serviceDate: json["service_date"],
    date: DateTime.parse(json["date"]),
    views: json["views"],
    isApplied: json["is_applied"],
    urgent: json["urgent"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: json["created_at"],
    country: json["country"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    jobbers: json["jobbers"],
    hours: json["hours"],
    status: json["status"],
    address: json["address"],
    phone: json["phone"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
    verylarge: json["verylarge"],
    question: json["question"],
    question1: json["question1"],
    question2: json["question2"],
    question3: json["question3"],
    surface: json["surface"],
    count: json["count"],
    input: json["input"],
    pickupAddress: json["pickup_address"],
    destinationAddress: json["destination_address"],
    dob: json["dob"],
    demander: Demander.fromJson(json["demander"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "childcategory_id": childcategoryId,
    "subcategory_id": subcategoryId,
    "category_id": categoryId,
    "detail_description": detailDescription,
    "description": description,
    "category_title": categoryTitle,
    "subcategory_title": subcategoryTitle,
    "distance": distance,
    "estimate_budget": estimateBudget,
    "time_difference": timeDifference,
    "duration": duration,
    "service_date": serviceDate,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "views": views,
    "is_applied": isApplied,
    "urgent": urgent,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt,
    "country": country,
    "start_time": startTime,
    "end_time": endTime,
    "jobbers": jobbers,
    "hours": hours,
    "status": status,
    "address": address,
    "phone": phone,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "small": small,
    "medium": medium,
    "large": large,
    "verylarge": verylarge,
    "question": question,
    "question1": question1,
    "question2": question2,
    "question3": question3,
    "surface": surface,
    "count": count,
    "input": input,
    "pickup_address": pickupAddress,
    "destination_address": destinationAddress,
    "dob": dob,
    "demander": demander.toJson(),
  };
}

class Demander {
  Demander({
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

  factory Demander.fromJson(Map<String, dynamic> json) => Demander(
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
