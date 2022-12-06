// To parse this JSON data, do
//
//     final mySkillsModel = mySkillsModelFromJson(jsonString);

import 'dart:convert';

List<MySkillsModel> mySkillsModelFromJson(String str) => List<MySkillsModel>.from(json.decode(str).map((x) => MySkillsModel.fromJson(x)));

String mySkillsModelToJson(List<MySkillsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MySkillsModel {
  MySkillsModel({
    required this.id,
    required this.mainCategory,
    required this.subCategory,
    required this.image,
    required this.skills,
    required this.equipments,
    required this.engagments,
    required this.experience,
    required this.diplomaName,
    required this.description,
  });

  int id;
  String mainCategory;
  String subCategory;
  String image;
  String skills;
  String equipments;
  String engagments;
  String experience;
  String diplomaName;
  String description;

  factory MySkillsModel.fromJson(Map<String, dynamic> json) => MySkillsModel(
    id: json["id"],
    mainCategory: json["main_category"],
    subCategory: json["sub_category"],
    image: json["image"],
    skills: json["skills"],
    equipments: json["equipments"],
    engagments: json["engagments"],
    experience: json["experience"],
    diplomaName: json["diploma_name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_category": mainCategory,
    "sub_category": subCategory,
    "image": image,
    "skills": skills,
    "equipments": equipments,
    "engagments": engagments,
    "experience": experience,
    "diploma_name": diplomaName,
    "description": description,
  };
}
