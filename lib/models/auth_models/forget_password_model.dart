// To parse this JSON data, do
//
//     final forgetPasswordModel = forgetPasswordModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel forgetPasswordModelFromJson(String str) => ForgetPasswordModel.fromJson(json.decode(str));

String forgetPasswordModelToJson(ForgetPasswordModel data) => json.encode(data.toJson());

class ForgetPasswordModel {
  ForgetPasswordModel({
    required this.success,
  });

  Success success;

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
    success: Success.fromJson(json["success"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toJson(),
  };
}

class Success {
  Success({
    required this.token,
    required this.id,
  });

  String token;
  int id;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    token: json["token"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
  };
}
