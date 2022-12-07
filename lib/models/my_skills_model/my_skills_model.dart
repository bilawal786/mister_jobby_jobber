// To parse this JSON data, do
//
//     final mySkillsModel = mySkillsModelFromJson(jsonString);

import 'dart:convert';

List<MySkillsModel> mySkillsModelFromJson(String str) => List<MySkillsModel>.from(json.decode(str).map((x) => MySkillsModel.fromJson(x)));

String mySkillsModelToJson(List<MySkillsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MySkillsModel {
  MySkillsModel({
    required this.id,
    required this.mainCategoryId,
    required this.mainCategory,
    required this.subCategory,
    required this.image,
    required this.childCategories,
    required this.subCategories,
    required this.skills,
    required this.equipments,
    required this.engagments,
    required this.experience,
    required this.diplomaName,
    required this.description,
  });

  int id;
  int mainCategoryId;
  String mainCategory;
  String subCategory;
  String image;
  List<Category> childCategories;
  List<Category> subCategories;
  String skills;
  String equipments;
  String engagments;
  String experience;
  String diplomaName;
  String description;

  factory MySkillsModel.fromJson(Map<String, dynamic> json) => MySkillsModel(
    id: json["id"],
    mainCategoryId: json["main_category_id"],
    mainCategory: json["main_category"],
    subCategory: json["sub_category"],
    image: json["image"],
    childCategories: List<Category>.from(json["child_categories"].map((x) => Category.fromJson(x))),
    subCategories: List<Category>.from(json["sub_categories"].map((x) => Category.fromJson(x))),
    skills: json["skills"],
    equipments: json["equipments"],
    engagments: json["engagments"],
    experience: json["experience"],
    diplomaName: json["diploma_name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main_category_id": mainCategoryId,
    "main_category": mainCategory,
    "sub_category": subCategory,
    "image": image,
    "child_categories": List<dynamic>.from(childCategories.map((x) => x.toJson())),
    "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    "skills": skills,
    "equipments": equipments,
    "engagments": engagments,
    "experience": experience,
    "diploma_name": diplomaName,
    "description": description,
  };
}

class Category {
  Category({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
