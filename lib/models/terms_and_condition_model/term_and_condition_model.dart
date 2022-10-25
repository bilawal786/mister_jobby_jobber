// To parse this JSON data, do
//
//     final termsAndConditionModel = termsAndConditionModelFromJson(jsonString);

import 'dart:convert';

TermsAndConditionModel termsAndConditionModelFromJson(String str) => TermsAndConditionModel.fromJson(json.decode(str));

String termsAndConditionModelToJson(TermsAndConditionModel data) => json.encode(data.toJson());

class TermsAndConditionModel {
  TermsAndConditionModel({
    required this.privacy,
    required this.terms,
  });

  String privacy;
  String terms;

  factory TermsAndConditionModel.fromJson(Map<String, dynamic> json) => TermsAndConditionModel(
    privacy: json["privacy"],
    terms: json["terms"],
  );

  Map<String, dynamic> toJson() => {
    "privacy": privacy,
    "terms": terms,
  };
}
