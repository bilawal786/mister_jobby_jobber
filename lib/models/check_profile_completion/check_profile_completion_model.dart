// To parse this JSON data, do
//
//     final checkProfileCompletion = checkProfileCompletionFromJson(jsonString);

import 'dart:convert';

CheckProfileCompletion checkProfileCompletionFromJson(String str) => CheckProfileCompletion.fromJson(json.decode(str));

String checkProfileCompletionToJson(CheckProfileCompletion data) => json.encode(data.toJson());

class CheckProfileCompletion {
  CheckProfileCompletion({
    required this.skills,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thersday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.insurance1,
    required this.rules1,
    required this.euIdCardFront,
    required this.euIdResidencePermitFront,
    required this.vitalCardNumber,
    required this.socialSecurityNumber,
    required this.answer1,
    required this.score,
  });

  String skills;
  String monday;
  String tuesday;
  String wednesday;
  String thersday;
  String friday;
  String saturday;
  String sunday;
  String insurance1;
  String rules1;
  String euIdCardFront;
  String euIdResidencePermitFront;
  String vitalCardNumber;
  String socialSecurityNumber;
  String answer1;
  String score;

  factory CheckProfileCompletion.fromJson(Map<String, dynamic> json) => CheckProfileCompletion(
    skills: json["skills"],
    monday: json["monday"],
    tuesday: json["tuesday"],
    wednesday: json["wednesday"],
    thersday: json["thersday"],
    friday: json["friday"],
    saturday: json["saturday"],
    sunday: json["sunday"],
    insurance1: json["insurance1"],
    rules1: json["rules1"],
    euIdCardFront: json["eu_id_card_front"],
    euIdResidencePermitFront: json["eu_id_residence_permit_front"],
    vitalCardNumber: json["vital_card_number"],
    socialSecurityNumber: json["social_security_number"],
    answer1: json["answer1"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "skills": skills,
    "monday": monday,
    "tuesday": tuesday,
    "wednesday": wednesday,
    "thersday": thersday,
    "friday": friday,
    "saturday": saturday,
    "sunday": sunday,
    "insurance1": insurance1,
    "rules1": rules1,
    "eu_id_card_front": euIdCardFront,
    "eu_id_residence_permit_front": euIdResidencePermitFront,
    "vital_card_number": vitalCardNumber,
    "social_security_number": socialSecurityNumber,
    "answer1": answer1,
    "score": score,
  };
}
