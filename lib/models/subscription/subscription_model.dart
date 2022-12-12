// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

List<SubscriptionModel> subscriptionModelFromJson(String str) => List<SubscriptionModel>.from(json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

String subscriptionModelToJson(List<SubscriptionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionModel {
  SubscriptionModel({
    required this.id,
    required this.name,
    required this.offers,
    required this.fee,
    required this.price,
    required this.planId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String offers;
  String fee;
  String price;
  String planId;
  DateTime createdAt;
  DateTime updatedAt;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    id: json["id"],
    name: json["name"],
    offers: json["offers"],
    fee: json["fee"],
    price: json["price"],
    planId: json["plan_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "offers": offers,
    "fee": fee,
    "price": price,
    "plan_id": planId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
