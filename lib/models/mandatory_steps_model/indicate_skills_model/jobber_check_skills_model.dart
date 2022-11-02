// To parse this JSON data, do
//
//     final jobberCheckSkillModel = jobberCheckSkillModelFromJson(jsonString);

import 'dart:convert';

JobberCheckSkillModel jobberCheckSkillModelFromJson(String str) =>
    JobberCheckSkillModel.fromJson(json.decode(str));

String jobberCheckSkillModelToJson(JobberCheckSkillModel data) =>
    json.encode(data.toJson());

class JobberCheckSkillModel {
  JobberCheckSkillModel({
    required this.bricolage,
    required this.jardinage,
    required this.livraison,
    required this.menage,
    required this.enfants,
    required this.animal,
    required this.informative,
    required this.aide,
    required this.course,
    required this.enviorment,
    required this.technical,
    required this.mechanique,
    required this.location,
    required this.amenegement,
    required this.electric,
    required this.renovation,
    required this.plumber,
  });

  bool bricolage;
  bool jardinage;
  bool livraison;
  bool menage;
  bool enfants;
  bool animal;
  bool informative;
  bool aide;
  bool course;
  bool enviorment;
  bool technical;
  bool mechanique;
  bool location;
  bool amenegement;
  bool electric;
  bool renovation;
  bool plumber;

  factory JobberCheckSkillModel.fromJson(Map<String, dynamic> json) =>
      JobberCheckSkillModel(
        bricolage: json["bricolage"],
        jardinage: json["jardinage"],
        livraison: json["livraison"],
        menage: json["menage"],
        enfants: json["enfants"],
        animal: json["animal"],
        informative: json["informative"],
        aide: json["aide"],
        course: json["course"],
        enviorment: json["enviorment"],
        technical: json["technical"],
        mechanique: json["mechanique"],
        location: json["location"],
        amenegement: json["amenegement"],
        electric: json["electric"],
        renovation: json["renovation"],
        plumber: json["plumber"],
      );

  Map<String, dynamic> toJson() => {
        "bricolage": bricolage,
        "jardinage": jardinage,
        "livraison": livraison,
        "menage": menage,
        "enfants": enfants,
        "animal": animal,
        "informative": informative,
        "aide": aide,
        "course": course,
        "enviorment": enviorment,
        "technical": technical,
        "mechanique": mechanique,
        "location": location,
        "amenegement": amenegement,
        "electric": electric,
        "renovation": renovation,
        "plumber": plumber,
      };
}
