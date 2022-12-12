// To parse this JSON data, do
//
//     final subscriptionPaymentModel = subscriptionPaymentModelFromJson(jsonString);

import 'dart:convert';

SubscriptionPaymentModel subscriptionPaymentModelFromJson(String str) => SubscriptionPaymentModel.fromJson(json.decode(str));

String subscriptionPaymentModelToJson(SubscriptionPaymentModel data) => json.encode(data.toJson());

class SubscriptionPaymentModel {
  SubscriptionPaymentModel({
    required this.url,
  });

  String url;

  factory SubscriptionPaymentModel.fromJson(Map<String, dynamic> json) => SubscriptionPaymentModel(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}
