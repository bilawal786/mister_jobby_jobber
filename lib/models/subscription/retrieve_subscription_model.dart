// To parse this JSON data, do
//
//     final retrieveSubscription = retrieveSubscriptionFromJson(jsonString);

import 'dart:convert';

RetrieveSubscription retrieveSubscriptionFromJson(String str) => RetrieveSubscription.fromJson(json.decode(str));

String retrieveSubscriptionToJson(RetrieveSubscription data) => json.encode(data.toJson());

class RetrieveSubscription {
  RetrieveSubscription({
    required this.activeSubscriptionId,
    required this.subscriptionStatus,
    required this.subscriptionPortal,
    required this.remainingOffers,
  });

  String activeSubscriptionId;
  String subscriptionStatus;
  String subscriptionPortal;
  String remainingOffers;

  factory RetrieveSubscription.fromJson(Map<String, dynamic> json) => RetrieveSubscription(
    activeSubscriptionId: json["active_subscription_id"],
    subscriptionStatus: json["subscription_status"],
    subscriptionPortal: json["subscription_portal"],
    remainingOffers: json["remaining_offers"],
  );

  Map<String, dynamic> toJson() => {
    "active_subscription_id": activeSubscriptionId,
    "subscription_status": subscriptionStatus,
    "subscription_portal": subscriptionPortal,
    "remaining_offers": remainingOffers,
  };
}
