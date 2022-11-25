// To parse this JSON data, do
//
//     final allReviewsModel = allReviewsModelFromJson(jsonString);

import 'dart:convert';

AllReviewsModel allReviewsModelFromJson(String str) => AllReviewsModel.fromJson(json.decode(str));

String allReviewsModelToJson(AllReviewsModel data) => json.encode(data.toJson());

class AllReviewsModel {
  AllReviewsModel({
    required this.totalReviews,
    required this.rating,
    required this.stars5,
    required this.stars4,
    required this.stars3,
    required this.stars2,
    required this.stars1,
    required this.reviews,
  });

  int totalReviews;
  int rating;
  int stars5;
  int stars4;
  int stars3;
  int stars2;
  int stars1;
  List<Review> reviews;

  factory AllReviewsModel.fromJson(Map<String, dynamic> json) => AllReviewsModel(
    totalReviews: json["total_reviews"],
    rating: json["rating"],
    stars5: json["stars_5"],
    stars4: json["stars_4"],
    stars3: json["stars_3"],
    stars2: json["stars_2"],
    stars1: json["stars_1"],
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_reviews": totalReviews,
    "rating": rating,
    "stars_5": stars5,
    "stars_4": stars4,
    "stars_3": stars3,
    "stars_2": stars2,
    "stars_1": stars1,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
  };
}

class Review {
  Review({
    required this.id,
    required this.userId,
    required this.name,
    required this.image,
    required this.message,
    required this.star,
    required this.date,
  });

  int id;
  int userId;
  String name;
  String image;
  String message;
  int star;
  String date;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    image: json["image"],
    message: json["message"],
    star: json["star"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "image": image,
    "message": message,
    "star": star,
    "date": date,
  };
}
