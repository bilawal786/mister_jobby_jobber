// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

AboutModel aboutModelFromJson(String str) => AboutModel.fromJson(json.decode(str));

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  AboutModel({
    required this.description,
    required this.condition,
    required this.copyright,
  });

  String description;
  String condition;
  String copyright;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    description: json["description"],
    condition: json["condition"],
    copyright: json["copyright"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "condition": condition,
    "copyright": copyright,
  };
}
